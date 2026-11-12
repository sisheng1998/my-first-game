extends CharacterBody2D

var leaf_count = 0

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * 400
	move_and_slide()


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("leaf") and not $HeldLeaf.visible:
		area.queue_free()
		$HeldLeaf.visible = true
		
	if area.is_in_group("basket") and $HeldLeaf.visible:
		$HeldLeaf.visible = false
		leaf_count += 1
		$CanvasLayer/LeafCountDisplay.text = "Leaves: " + str(leaf_count)
