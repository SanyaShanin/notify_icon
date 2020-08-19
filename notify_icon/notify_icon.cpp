// notify_icon.cpp : Определяет экспортированные функции для приложения DLL.
//

#include "stdafx.h"
#include "windows.h"
#include "stdio.h"
#include "shellapi.h"
#include <map>
#include <string>
#include <vector>

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#define trace(...) { printf("[notify_icon:%d] ", __LINE__); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }

#pragma region Conversions
std::wstring to_wstring(const std::string& str,
	const std::locale& loc = std::locale())
{
	std::vector<wchar_t> buf(str.size());
	std::use_facet<std::ctype<wchar_t>>(loc).widen(str.data(),
		str.data() + str.size(),
		buf.data());
	return std::wstring(buf.data(), buf.size());
}

// convert wstring to string with '?' as default character
std::string to_string(const std::wstring& str,
	const std::locale& loc = std::locale())
{
	std::vector<char> buf(str.size());
	std::use_facet<std::ctype<wchar_t>>(loc).narrow(str.data(),
		str.data() + str.size(),
		'?', buf.data());
	return std::string(buf.data(), buf.size());
}

struct buffer {
	char* pos;
public:
	buffer(char* origin) : pos(origin) {}
	template<class T> T read() {
		T r = *(T*)pos;
		pos += sizeof(T);
		return r;
	}
	template<class T> void write(T val) {
		*(T*)pos = val;
		pos += sizeof(T);
	}
	//
	char* read_string() {
		char* r = pos;
		while (*pos != 0) pos++;
		pos++;
		return r;
	}
	void write_string(const char* s) {
		for (int i = 0; s[i] != 0; i++) write<char>(s[i]);
		write<char>(0);
	}
};

const wchar_t *GetWC(const char *c)
{
	const size_t cSize = strlen(c) + 1;
	wchar_t* wc = new wchar_t[cSize];
	//mbstowcs_s(cSize, wc, c, cSize);

	return wc;
}

class StringConv {
public:
	char* cbuf = NULL;
	size_t cbuf_size = 0;
	WCHAR* wbuf = NULL;
	size_t wbuf_size = 0;
	StringConv() {

	}
	LPCWSTR wget(size_t size) {
		if (wbuf_size < size) {
			if (wbuf != NULL) delete wbuf;
			wbuf = new WCHAR[size];
			wbuf_size = size;
		}
		return wbuf;
	}
	LPCWSTR proc(const char* src, int cp = CP_UTF8) {
		size_t size = MultiByteToWideChar(cp, 0, src, -1, NULL, 0);
		LPCWSTR buf = wget(size);
		MultiByteToWideChar(cp, 0, src, -1, wbuf, size);
		return wbuf;
	}
	char* get(size_t size) {
		if (cbuf_size < size) {
			if (cbuf != NULL) delete cbuf;
			cbuf = new char[size];
			cbuf_size = size;
		}
		return cbuf;
	}
	char* proc(LPCWSTR src, int cp = CP_UTF8) {
		size_t size = WideCharToMultiByte(cp, 0, src, -1, NULL, 0, NULL, NULL);
		char* buf = get(size);
		WideCharToMultiByte(cp, 0, src, -1, buf, size, NULL, NULL);
		return buf;
	}
} utf8;

double get_handle(HANDLE h) {
	return (double)(int)h;
}
HANDLE get_handle(double h) {
	return (HANDLE)(int)h;
}
#pragma endregion

#pragma region register callback
void(*CreateAsynEvent)(int, int) = NULL;
int(*CreateDsMap)(int _num, ...) = NULL;
bool(*DsMapAddDouble)(int _index, char *_pKey, double value) = NULL;
bool(*DsMapAddString)(int _index, char *_pKey, char *pVal) = NULL;

dllx double RegisterCallbacks(char *arg1, char *arg2, char *arg3, char *arg4)
{
	trace("register callbacks");
	void(*CreateAsynEventWithDSMapPtr)(int, int) = (void(*)(int, int))(arg1);
	int(*CreateDsMapPtr)(int _num, ...) = (int(*)(int _num, ...)) (arg2);
	CreateAsynEvent = CreateAsynEventWithDSMapPtr;
	CreateDsMap = CreateDsMapPtr;

	bool(*DsMapAddDoublePtr)(int _index, char *_pKey, double value) = (bool(*)(int, char*, double))(arg3);
	bool(*DsMapAddStringPtr)(int _index, char *_pKey, char *pVal) = (bool(*)(int, char*, char*))(arg4);

	DsMapAddDouble = DsMapAddDoublePtr;
	DsMapAddString = DsMapAddStringPtr;

	return true;
}



bool ds_map_add(int map, char* key, char* value) {
	return DsMapAddString(map, key, value);
}
bool ds_map_add(int map, const char* key, const char* value) {
	return DsMapAddString(map, (char*)key, (char*)value);
}
bool ds_map_add(int map, char* key, double value) {
	return DsMapAddDouble(map, key, value);
}
bool ds_map_add(int map, const char* key, double value) {
	return DsMapAddDouble(map, (char*)key, value);
}
bool ds_map_add(int map, const char* key, HWND h) {
	return DsMapAddDouble(map, (char*)key, (double)(int)h);
}
void gm_async(int map) {
	CreateAsynEvent(map, 70);
}

int ds_map_create() {
	int map = CreateDsMap(0);
	ds_map_add(map, "source", "notify_icon");
	return map;
}

int ds_map_event_create(HWND h, const char* ev) {
	int map = ds_map_create();
	ds_map_add(map, "window", h);
	ds_map_add(map, "request", "event");
	ds_map_add(map, "event", ev);
	return map;
}

#pragma endregion

using namespace std;

map<double, NOTIFYICONDATA> container;
double index = 0;
double add_notify_icon(NOTIFYICONDATA data) {
	data.uID = index;
	container[index] = data;
	index++;
	return index - 1;
}
NOTIFYICONDATA get_notify_icon(double ind) {
	return container[ind];
}
bool notify_exists(double ind) {
	return ind >= 0 && ind < index;
}

bool init = false;
WNDPROC def_message_handler;
LRESULT message_handler(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam) 
{
	if (message == WM_USER + 10) {
		if (lparam == WM_LBUTTONDOWN) {
			int map = ds_map_create();
			ds_map_add(map, "event_type", "notify_icon");
			ds_map_add(map, "index", wparam);
			gm_async(map);
		}
		return true;
	} 
	else
		return CallWindowProc(def_message_handler, hwnd, message, wparam, lparam);
}

dllx double notify_icon_create(char* chwnd) {
	HWND hwnd = (HWND)chwnd;

	if (!init) {
		init = true;
		def_message_handler = (WNDPROC)SetWindowLongPtr(hwnd, GWL_WNDPROC, (LONG_PTR)message_handler);
		trace("init");
	}

	NOTIFYICONDATA data;
	data.cbSize = sizeof(NOTIFYICONDATA);
	data.hIcon = (HICON)GetClassLong(hwnd, GCL_HICON);
	data.uCallbackMessage = WM_USER + 10;
	data.uFlags = NIF_ICON | NIF_MESSAGE;
	data.uVersion = 0;
	data.hWnd = hwnd;
	return add_notify_icon(data);
}

dllx double notify_icon_add_tip(double ind, char* tip) {
	if (!notify_exists(ind)) {
		trace("undefined notify with index %f", ind);
		return false;
	}
	NOTIFYICONDATA data = get_notify_icon(ind);

	data.uFlags |= NIF_TIP;

	wstring stip = wstring(utf8.proc(tip)) + L'\0';
	stip.copy((wchar_t*)data.szTip, stip.length());

	container[ind] = data;
	return true;
}

dllx double notify_icon_add_message(double ind, char* title, char* content) {
	if (!notify_exists(ind)) {
		trace("undefined notify with index %f", ind);
		return false;
	}
	NOTIFYICONDATA data = get_notify_icon(ind);

	data.uFlags |= NIF_INFO;
	data.dwInfoFlags = NIIF_NONE;

	wstring stitle = wstring(utf8.proc(title)) + L'\0';
	wstring scontent = wstring(utf8.proc(content)) + L'\0';

	stitle.copy((wchar_t*)data.szInfoTitle, stitle.length());
	scontent.copy((wchar_t*)data.szInfo, scontent.length());

	container[ind] = data;
	return true;
}

dllx double notify_icon_show(double ind) {
	if (!notify_exists(ind)) {
		trace("undefined notify with index %f", ind);
		return false;
	}
	NOTIFYICONDATA data = get_notify_icon(ind);
	return Shell_NotifyIcon(NIM_ADD, &data);
}

dllx double notify_icon_hide(double ind) {
	if (!notify_exists(ind)) {
		trace("undefined notify with inex %f", ind);
		return false;
	}
	NOTIFYICONDATA data = get_notify_icon(ind);
	return Shell_NotifyIcon(NIM_DELETE, &data);
}

dllx double notify_icon_dispose() {
	for (int i = 0; i < index; i++) {
		Shell_NotifyIcon(NIM_DELETE, &get_notify_icon(i));
	}
	return true;
}