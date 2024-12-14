; Circle Center Finding Macro
; 1: Move the probe inside the circle
; 2: Start the macro
; Macro will probe in three directions to find an edge to the circle
; If successful the probe will move to the center of the circle
; Any failures will terminate the macro
#<probe_dist>=15.0   ; Distance the probe will move in each direction before failing
#<probe_feed>=100.0  ; Speed at which it probes.

; the directions it will probe from the starting point
#<angle_a>=120 ; degrees
#<angle_b>=0.0
#<angle_c>=-120

; save current location so we can return after each probe.
#<saved_x>=#5420 
#<saved_y>=#5421


#<probe_x> = [#<probe_dist> * COS[#<angle_a>]]
#<probe_y> = [#<probe_dist> * SIN[#<angle_a>]]
G38.2 G91 F#<probe_feed> X#<probe_x> Y#<probe_y>
; save the probe locations
#<AX>=#5061
#<AY>=#5062
G90 G0 X#<saved_x> Y#<saved_y>

#<probe_x> = [#<probe_dist> * COS[#<angle_b>]]
#<probe_y> = [#<probe_dist> * SIN[#<angle_b>]]
G38.2 G91 F#<probe_feed> X#<probe_x> Y#<probe_y>
; save the probe locations
#<BX>=#5061
#<BY>=#5062
G90 G0 X#<saved_x> Y#<saved_y>

#<probe_x> = [#<probe_dist> * COS[#<angle_c>]]
#<probe_y> = [#<probe_dist> * SIN[#<angle_c>]]
G38.2 G91 F#<probe_feed> X#<probe_x> Y#<probe_y>
; save the probe locations
#<CX>=#5061
#<CY>=#5062
G90

; Calculate the center
; all calculations are done in machine coordinates because that is what
; G38 returns
#<MidABX> = [[#<AX> + #<BX>] / 2]
#<MidABY> = [[#<AY> + #<BY>] / 2]
#<MidBCX> = [[#<BX> + #<CX>] / 2]
#<MidBCY> = [[#<BY> + #<CY>] / 2]

#<SlopeAB> = [[#<BX> - #<AX>] / [#<BY> - #<AY>] * -1.0]
#<SlopeBC> = [[#<CX> - #<BX>] / [#<CY> - #<BY>] * -1.0]

#<CirX> = [[[#<SlopeAB> * #<MidABX>] - [#<SlopeBC> * #<MidBCX>] + #<MidBCY> - #<MidABY>] / [#<SlopeAB> - #<SlopeBC>]]
#<CirY> = [#<SlopeAB> * [#<CirX> - #<MidABX>] + #<MidABY>]

G53 G0 X#<CirX> Y#<CirY> ; move to center.
G10 L20 P0 X0 Y0 ; Set workspace zero