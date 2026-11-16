# Counters that the camera attaches to every frame as chunk data.
#
# header.stamp is the very same stamp carried by the image message of this frame, so
# downstream nodes pair the two by exact equality and not by a tolerance window
# (sensor_msgs/Image has no seq field in ROS 2).
std_msgs/Header header

# Each counter is enabled independently, since a camera model may provide one chunk and
# not the other. A counter this camera does not provide is reported as -1.

# Frames acquired by this camera. It does NOT restart with the acquisition: it pauses during
# stop_grabbing and resumes from the same value on start_grabbing (measured on an acA5472,
# 2026-10-15), and load_user_set (stop, UserSetLoad, start) does not reset it either. It DOES
# restart from zero when this node restarts, whether it is killed or shuts down cleanly
# (measured on an acA5472 with external trigger and startup_user_set UserSet1, 2026-11-16;
# with pypylon, a bare Close/Open of the camera kept it, 2026-09-30), and when the camera is
# power-cycled. So it is not an index across node restarts. -1 if not provided.
int64 frame_counter

# Trigger pulses received on the trigger line since the camera was powered on. It keeps
# counting across stop_grabbing / start_grabbing and across a restart of this node (it does
# not go back to zero), so cameras wired to the same trigger line share this index up to a
# per-camera offset. That offset is not guaranteed across a restart of this node: some of the
# pulses that arrive while the node restarts are not counted (measured on an acA5472,
# 2026-11-16: 22 of ~69 and 19 of ~34 pulses missed in two restarts; pulses sent read at
# 1 Hz, +-5), so the offset has to be checked again after it. On an acA5472 in free-run (no
# trigger) it also advances with every frame with no pulse on the line (= frame_counter + 1,
# measured 2026-10-15; same advance measured 2026-10-08), so it only counts trigger pulses
# while the camera is armed. -1 if not provided.
int64 trigger_input_counter
