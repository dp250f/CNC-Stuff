; Probe X+ macro (set workspace X0)

; Define macro variables
#<probe_dist>=15.0   ; Distance the probe will move before failing
#<probe_feed>=100.0  ; Speed at which it probes
#<probe_tip_dia>=2.0 ; Probe tip diameter

; Save current modals
#<units_mode> = #<_metric>
#<distance_mode> = #<_incremental>
#<wcs_num> = [#<_coord_system> / 10 ]

; Set macro modals
G91 ; Set incremental
G21 ; Set metric

; Save starting position
#<saved_x>=#5420

; Probe toward
G38.2 F#<probe_feed> X#<probe_dist>
#<probed_toward> = [#5061 + [#<probe_tip_dia> / 2]] ; save the probe location
;(print, Probe toward X value: #<probed_toward>)

; Pause for a bit
G4 P0.25

; Probe away
G38.4 F#<probe_feed> X-1.0
#<probed_away> = [#5061 + [#<probe_tip_dia> / 2]] ; save the probe location
;(print, Probe away X value: #<probed_away>)

; Return to starting position
G90 G0 X#<saved_x>

; Compute average probed value
#<probed_average> = [[#<probed_toward> + #<probed_away>] / 2]

; Set workspace X0 using the average value
(print, Saving average probed G%.1f#<wcs_num>  X offset: %f#<probed_average>)
G10 L2 X#<probed_average>

; Restore modals
G[90 + #<distance_mode>] ; restore the distance mode
G[20 + #<units_mode>] ; restore the units mode
