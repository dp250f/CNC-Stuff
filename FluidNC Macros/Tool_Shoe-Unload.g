(Unload dust shoe)
; G28 Z0 must be set to most retracted position!!!
; Set G30 to dock center location
G91         ; Set incremental distance mode
G28 Z0      ; Lift Z to safe position
G30 X0 Y0   ; Move XY to center of Dock
 G0 Y-25     ; Move Y in front of Dock
 G30 Z0      ; Move Z to dock level
 G30 Y0      ; Move Y to center of Dock
G0 Y5       ; Move Y + 5mm to weaken magnets
G28 Z0      ; Lift Z to safe position
G90         ; Set absolute distance mode

(Unload Tool)
M6 T0

(Load dust shoe)
; G28 Z0 must be set to most retracted position!!!
; Set G30 to dock center location
G91         ; Set incremental distance mode
G28 Z0      ; Lift Z to safe position
G30 X0 Y0   ; Move XY to center of Dock
 G0 Y5       ; Move Y 5mm behind Dock to weaken magnets
 G30 Z0      ; Move Z to dock level
 G30 Y0      ; Move Y to center of Dock
G0 Y-25     ; Move Y in front of Dock
G28 Z0      ; Lift Z to safe position
G90         ; Set absolute distance mode
