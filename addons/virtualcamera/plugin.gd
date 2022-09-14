tool
extends EditorPlugin

const VCAMERA_PREVIEW_SCENE = preload("res://addons/virtualcamera/vcameras/preview_plugin/vcamera_preview_plugin.tscn")
var vcamera_preview

var follow_gizmo_plugin = preload("res://addons/virtualcamera/transform_modifiers/gizmos/follow_gizmo_plugin.gd").new()

func _enter_tree():
	add_spatial_gizmo_plugin(follow_gizmo_plugin)

func handles(object: Object) -> bool:
	return object is VCamera

func edit(object: Object) -> void:
	close_vcamera_preview()
	vcamera_preview = VCAMERA_PREVIEW_SCENE.instance()
	vcamera_preview.target_vcamera = object
	vcamera_preview.connect("closing", self, "close_vcamera_preview")
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, vcamera_preview)

func close_vcamera_preview() -> void:
	if is_instance_valid(vcamera_preview):
		remove_control_from_docks(vcamera_preview)
		vcamera_preview.queue_free()

func _exit_tree():
	close_vcamera_preview()
	remove_spatial_gizmo_plugin(follow_gizmo_plugin)
