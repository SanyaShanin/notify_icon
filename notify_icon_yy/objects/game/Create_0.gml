/// @description Insert description here
// You can write your code in this editor

notify = new NotifyIcon()
	.SetMessage("YellowAfterLife на страже", "Оказалось, что сейчас в сети YellowAfterLife, и если его пингануть, он придёт и поможет!")
	.SetTip("Позвать YellowAfterLife на помощь")
	.SetMouseAction(function() {h_dino.active = true; notify.Hide()}) 
	.Show();


goose_show = new NotifyIcon()
	.SetTip("Возвратить гуся")
	.SetMouseAction(function() {instance_activate_object(h_goose); goose_hide.Show(); goose_show.Hide() })
	
goose_hide = new NotifyIcon()
	.SetTip("Удалить гуся")
	.SetMouseAction(function() {instance_deactivate_object(h_goose); goose_show.Show(); goose_hide.Hide() })
	.Show();