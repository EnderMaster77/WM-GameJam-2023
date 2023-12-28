extends Area2D





func _on_area_entered(area):
	queue_free()

func _on_body_entered(body):
	queue_free()
