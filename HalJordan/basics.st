; States file for Hal Jordan -- Basics
;
;---------------------------------------------------------------------------
; Vars:
;   0: for Super Jump (0=vertical, 1=forward, -1=backward)
; Helpers:
;   0: superjump opponent position indicator
; Explods:
;---------------------------------------------------------------------------


;---------------------------------------------------------------------------
; Lose (on timeover)
[Statedef 170]
type = S
ctrl = 0
anim = 170
velset = 0,0

[State 170,0]
type = PlaySnd
trigger1 = !Time
value = 6,10

[State 170,1]
type = AssertSpecial     
trigger1 = Time = [0,100]
flag = RoundNotOver


;---------------------------------------------------------------------------
; Draw game (on timeover)
[Statedef 175]
type = S
ctrl = 0
anim = 175
velset = 0,0

[State 175,0]
type = PlaySnd
trigger1 = !Time
value = 6,11

[State 175,1]
type = AssertSpecial     
trigger1 = Time = [0,100]
flag = RoundNotOver


;---------------------------------------------------------------------------
; Winposes
[Statedef 180]  ; winpose selector
type = S
ctrl = 0
velset = 0,0

; custom Lantern Corps winposes
[State 180, CorpsWins]
type = ChangeState
trigger1 = PalNo = [7,12]
value = 10180 + (1000*PalNo)	; e.g. pal 7 (red): 17180

[State 180,Winpose decider]
type = ChangeState
trigger1 = Time = 1
value = 181 + ((Random * 3) / 1000)     ; change the 1 to however many winposes you have

;-----------------------
; Winpose #1 - do better
[Statedef 181]
type = S
ctrl = 0
anim = 181
velset = 0,0

[State 181,0]
type = PlaySnd
trigger1 = !Time
value = 6,0

[State 181,1]
type = AssertSpecial     
trigger1 = Time = [0,120]
flag = RoundNotOver

;-----------------------
; Winpose #2 - Mission accomplished
[Statedef 182]
type = S
ctrl = 0
anim = 182
velset = 0,0

[State 182,0]
type = PlaySnd
trigger1 = !Time
value = 6,1

[State 182,1]
type = AssertSpecial
trigger1 = Time = [0,80]
flag = RoundNotOver


;-----------------------
; Winpose #3 - Good Over Evil
[Statedef 183]
type = S
physics = N
ctrl = 0
anim = 183
velset = 0,0

[State 0, PlaySnd]
type = PlaySnd
trigger1 = animelem = 6
value = S0,3

[State 0, PlaySnd]
type = PlaySnd
trigger1 = animelem = 14
value = S0,2

[State 0, PlaySnd]
type = PlaySnd
trigger1 = animelem = 16
value = S6,2

[State 0, VelSet]
type = VelSet
trigger1 = animelem = 6
x = -3
y = -8

[State 0, VelMul]
type = VelMul
trigger1 = 1
x = 0.8
y = 0.95

[State 182,1]
type = AssertSpecial
trigger1 = Time = [0,180]
flag = RoundNotOver


;---------------------------------------------------------------------------
; Intros
[Statedef 190]  ; intro selector
type = S
ctrl = 0
velset = 0,0

; special vs crappy leaked Hal -- force intro 192 w/ custom dialog
[State 190, vs Leak]
type = ChangeState
trigger1 = P2Name="Green Lantern Hal jordan"
value = 192

; custom Lantern Corps intros
[State 190, CorpsIntros]
type = ChangeState
trigger1 = MatchNo = 1 && PalNo = [7,12]
trigger2 = PalNo = 8		; Orange always gets this one
value = 10190 + (1000*PalNo)	; e.g. pal 7 (red): 17190

; custom Lantern Corps oaths (all use intro 191)
[State 190, CorpsIntros]
type = ChangeState
trigger1 = MatchNo > 1 && PalNo = [7,12]
value = 191

[State 190,intro decider]
type = ChangeState
trigger1 = Time = 1
value = 191 + ((Random * 2) / 1000)     ; change the 1 to however many intros you have

;-----------------------
; Intro #1 - oath + lantern charge (customized for the various corps' oaths)
[Statedef 191]
type = S
ctrl = 0
anim = ifelse(palno=11,21192,191)  
velset = 0,0
sprpriority = 1

[State 191, 1] ; GL oath
type = PlaySnd
trigger1 = !Time && PalNo = [1,6]
value = 5,0
channel = 0

; TODO: voices for other corps' oaths...?

[State 191, 1]
type = PlaySnd
trigger1 = Time = 122
value = S9,31

[State 191, light beams]
type = Explod
trigger1 = !Time && PalNo != 11
anim = 1911
ID = 1910
pos = 47,-88
scale = 1,1
postype = p1
facing = 1
vfacing = 1
bindtime = 1
removetime = 122
scale = 1.25,0.75
sprpriority =2

[State 191, light beams indigo]
type = Explod
trigger1 = !Time && PalNo = 11
anim = 1911
ID = 1910
pos = 83,-154
scale = 1,1
postype = p1
facing = 1
vfacing = 1
bindtime = 1
removetime = 122
scale = 1.25,0.75
sprpriority =2

[State 191, lantern glow]
type = Explod
trigger1 = !Time && PalNo != 11
anim = 1910
ID = 1910
pos = 47,-88
scale = 0.5,0.5
postype = p1
facing = 1
vfacing = 1
bindtime = 1
removetime = 122
scale = 1,1
sprpriority = 2

[State 0, sparks]
type = Helper
trigger1 = time = 122 && PalNo != 11
helpertype = normal ;player
name = "Explod"
stateno = 1006
ID = 1006
pos = 47,-88

[State 191, ring flash]
type = Explod
trigger1 = !Time
anim = 936
pos = 0,-84
ID = 936
bindtime = -1
removetime = 122
sprpriority = 3

[State 0, PalFX]
type = PalFX
trigger1 = time = 122 && PalNo != 11
time = 4
add = 0,128,0
sinadd = 0,-128,0,12
invertall = 0
color = 256
;ignorehitpause =
;persistent =

[State 191, RemoveExplod]
type = RemoveExplod
trigger1 = Time= 100
id = 936

[State 192, 2]             
type = AssertSpecial
trigger1 = 1
flag = Intro

[State 192, ChangeState]
type = ChangeState
trigger1 = !AnimTime 
value = 0
ctrl = 0

;-----------------------
; Intro #2 - "Ya wanna fight?" costume change
[Statedef 192]
type = S
ctrl = 0
anim = 192
velset = 0,0

; voice (with custom dialog vs crappy leaked Hal)
[State 192, 1]
type = PlaySnd
trigger1 = !Time
value = 5, IfElse(P2Name="Green Lantern Hal jordan", 100, 1)

[State 192, spark1]
type = Explod
trigger1 = Time = 30
anim = 930
ID = 930
pos = -1,-92
postype = p1
removetime = -2
sprpriority = 4

[State 192, spark2]
type = Explod
trigger1 = AnimElem = 4
anim = 935
ID = 935
pos = -26,-121
postype = p1
removetime = -2
sprpriority = 4

[State 192, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 4
value = S9,2

[State 192, costume]
type = Explod
trigger1 = AnimElemTime(4) = 8
anim = 1920
ID = 1920
bindtime = 1
removetime = -2
sprpriority = 3

[State 192, spark3]
type = Explod
trigger1 = Time = 90
anim = 940
ID = 940
pos = -26,-121
postype = p1
removetime = -2
sprpriority = 4

[State 192, PlaySnd]
type = PlaySnd
trigger1 = Time = 90
value = S9,2

[State 192, spark4]
type = Explod
trigger1 = Time = 118
anim = 950
ID = 950
pos = -26,-121
postype = p1
removetime = -2
sprpriority = 4

[State 192, PlaySnd]
type = PlaySnd
trigger1 = Time = 118
value = S9,31

[State 192, 2]
type = AssertSpecial
trigger1 = Time = [0,150]
flag = Intro


;---------------------------------------------------------------------------
; Taunt - begin lantern charge
[Statedef 195]
type = S
ctrl = 0
anim = 195
velset = 0,0

[State 195, ChangeState]
type = ChangeState
trigger1 = command = "charge"
value = 196
ctrl = 0

[State 195, ChangeState]
type = ChangeState
trigger1 = !animtime
value = 0
ctrl = 1

;-----------------
; taunt - keep charging
[Statedef 196]
type = S
ctrl = 0
anim = 196
velset = 0,0

[State 196, Explod]
type = Explod
trigger1 = !Time
anim = 1911
ID = 1910
pos = 58,-86
scale = 1,1
postype = p1
facing = 1
vfacing = 1
bindtime = -1
removetime = -1
scale = 1.25,0.75
sprpriority =2

[State 196, Explod]
type = Explod
trigger1 = !Time
anim = 1910
ID = 1910
pos = 58,-86
scale = 0.5,0.5
postype = p1
facing = 1
vfacing = 1
bindtime = -1
removetime = -1
scale = 1,1
sprpriority = 2

[State 196, Explod]
type = Explod
trigger1 = !Time
anim = 936
pos = -11,-84
ID = 936
bindtime = -1
removetime = -1
sprpriority = 3

[State 196, PlaySnd]
type = PlaySnd
trigger1 = TimeMod = 10,0
value = S9,2
persistent = 0

[State 196, PowerAdd]
type = PowerAdd
trigger1 = Alive
value = 12

[State 196, ChangeState]
type = ChangeState
triggerall = !animtime
trigger1 = command != "charge"
trigger2 = Power = 3000
value = 197

;-----------------
; taunt - stop charging
[Statedef 197]
type = S
ctrl = 0
anim = 197
velset = 0,0

[State 197, RemoveExplod]
type = RemoveExplod
trigger1 = !Time
id = 1910

[State 197, RemoveExplod]
type = RemoveExplod
trigger1 = !Time
id = 1911

[State 197, RemoveExplod]
type = RemoveExplod
trigger1 = !Time
id = 936

[State 197, ChangeState]
type = ChangeState
trigger1 = !animtime
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Stand Light Punch
[StateDef 210]
anim = 210
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 210, swoosh]
type = PlaySnd
trigger1 = AnimElem = 2
value = 0,0

[State 210, grunt]
type = PlaySnd
trigger1 = AnimElem = 2
value = 1,0

[State 210, HitDef]
type = HitDef
trigger1 = AnimElem = 2
attr = S, NA
damage = 30
guardflag = MA
pausetime = 8,8
hitsound = S2,0
guardsound = S3,0
sparkno = S9990
sparkxy = 0,-99
animtype = Light
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -3
guard.velocity = -2
air.velocity = -2,-3

[State 210, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Stand Light Kick
[StateDef 220]
anim = 220
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 220, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,0

[State 220, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,0

[State 220, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
damage = 25
guardflag = MAFD
pausetime = 6,6
hitsound = S2,0
guardsound = S3,0
sparkno = S9990
sparkxy = 0,-30
animtype = Light
ground.type = Low
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -3
guard.velocity = -2
air.velocity = -2,-3

[State 220, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Stand Medium Punch
[StateDef 230]
anim = 230
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 230, swoosh]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0,1

[State 230, grunt]
type = PlaySnd
trigger1 = AnimElem = 4
value = 1,1

[State 230, HitDef]
type = HitDef
trigger1 = AnimElem = 4
attr = S, NA
damage = 65
guardflag = MA
pausetime = 9,9
hitsound = S2,1
guardsound = S3,0
sparkno = S9991
sparkxy = 0,-100
animtype = Medium
ground.type = High
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -7
guard.velocity = -5
air.velocity = -3,-6

[State 230, glove]
type = Explod
trigger1 = AnimElem = 2
anim = ifelse(palno=12, 30231, 231)
sprpriority = 3
;ontop = 0

[State 230, 1]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Stand Medium Kick
[StateDef 240]
anim = 240
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 240, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,1

[State 240, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,1

[State 240, HitDef]
type = HitDef
trigger1 = !Time
attr = S, NA
damage = 65
guardflag = MA
pausetime = 9,9
hitsound = S2,1
guardsound = S3,0
sparkno = S9991
sparkxy = 0,-80
animtype = Medium
ground.type = High
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -7
guard.velocity = -5
air.velocity = -3,-6

[State 240, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Stand Hard Punch
[StateDef 250]
anim = 250
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 250, swoosh]
type = PlaySnd
trigger1 = AnimElem = 3
value = 0,2

[State 250, grunt]
type = PlaySnd
trigger1 = AnimElem = 3
value = 1,2

[State 250, Explod]
type = Explod
trigger1 = AnimElem = 1
anim = ifelse(palno=12, 30251, 251)
pos = -5,-1
postype = p1
facing = 1
vfacing = 1
bindtime = 1
ontop = 1
removeongethit = 1

[State 250, HitDef]
type = HitDef
trigger1 = AnimElem = 3
attr = S, NA
damage = 96
guardflag = MA
pausetime = 11,11
hitsound = S2,2
guardsound = S3,0
sparkno = S9992
sparkxy = 0,-96
animtype = Heavy
ground.type = High
ground.slidetime = 20
ground.hittime  = 20
ground.velocity = -8
guard.velocity = -5
air.velocity = -4,8

[State 250, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Stand Hard Kick
[StateDef 260]
anim = 260
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 260, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,2

[State 260, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,2

[State 260, HitDef]
type = HitDef
trigger1 = !Time
attr = S, NA
damage = 96
guardflag = MA
pausetime = 6,6
hitsound = S2,2
guardsound = S3,0
sparkno = S9992
sparkxy = 0,-70
animtype = Heavy
ground.type = High
ground.slidetime = 8
ground.hittime  = 20
ground.velocity = -7
guard.velocity = -4
air.velocity = -4,-8

[State 260, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;--------------------------------------------------------------------
; SethZ Remixed standing basics

;---------------------------------------------------------------------------
; Stand Light Punch (Seth Remix)
[StateDef 300]
anim = 300
ctrl = 0
type = S
movetype = A
physics = S

[State 300, swoosh]
type = PlaySnd
trigger1 = AnimElem = 3
value = 0,0

[State 300, grunt]
type = PlaySnd
trigger1 = AnimElem = 4
value = 1,0

[State 300, HitDef]
type = HitDef
trigger1 = !Movecontact
attr = S, NA
damage = 30
guardflag = MA
pausetime = 8,8
hitsound = S2,0
guardsound = S3,0
sparkno = -1
sparkxy = 0,-99
animtype = Light
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -3
guard.velocity = -2
air.velocity = -2,-3

[State 777, dcvm hitspark1]
type = null ;helper
trigger1 = movehit
helpertype = normal
stateno = 47060   ;;; 47000 = weak spark  /  47001 = medium spark  /  47002 = strong spark
ID = 47000
name = "hitspark"
postype = p1
pos = ceil(p2dist x-p2bodydist x),-99  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = -1
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=0
ownpal = 1

[State 300, ring]
type = Explod
trigger1 = !time
anim = 301
ID = 301
postype = p1
pos = 0,0
bindtime = 1
sprpriority = 3
removeongethit = 1

[State 300, glove]
type = Explod
trigger1 = animelem = 4
anim = 302
ID = 302
postype = p1
scale = 2.5,1
pos = 20,-102
bindtime = 1
sprpriority = 3
removeongethit = 1
ignorehitpause = 1

[State 300, back to stance]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1



;---------------------------------------------------------------------------
; Crouch Light Punch
[StateDef 410]
anim = 410
ctrl = 0
type = C
movetype = A
physics = C
velset = 0,0

[State 410, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,0

[State 410, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,0

[State 410, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
damage = 30
guardflag = L
pausetime = 8,8
hitsound = S2,0
guardsound = S3,0
sparkxy = 0,-60
animtype = Light
ground.type = Low
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -3
guard.velocity = -2
air.velocity = -3,-6

[State 410, 1]
type = ChangeState
trigger1 = !AnimTime
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Crouch Light Kick
[StateDef 420]
anim = 420
ctrl = 0
type = C
movetype = A
physics = C
velset = 0,0

[State 420, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,0

[State 420, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,0

[State 420, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
damage = 25
guardflag = L
pausetime = 8,8
hitsound = S2,0
guardsound = S3,0
sparkxy = 0,0
animtype = Light
ground.type = Low
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -2
guard.velocity = -1
air.velocity = -2,-3

[State 420, 1]
type = ChangeState
trigger1 = !AnimTime
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Crouch Medium Punch
[StateDef 430]
anim = 430
ctrl = 0
type = C
movetype = A
physics = C
velset = 0,0

[State 430, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,1

[State 430, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,1

[State 430, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
damage = 65
guardflag = L
pausetime = 9,9
hitsound = S2,1
guardsound = S3,0
sparkxy = 0,-70
animtype = Medium
ground.type = Low
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -8
guard.velocity = -10
air.velocity = -3,-6

[State 430, 1]
type = ChangeState
trigger1 = !AnimTime
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Crouch Medium Kick
[StateDef 440]
anim = 440
ctrl = 0
type = C
movetype = A
physics = C
velset = 0,0

[State 440, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,1

[State 440, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,1

[State 440, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
damage = 30
guardflag = L
pausetime = 9,9
hitsound = S2,1
guardsound = S3,0
sparkxy = 0,-50
animtype = Medium
ground.type = Low
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -6,-2
guard.velocity = -3
air.velocity = -6,-6

[State 440, 1]
type = ChangeState
trigger1 = !AnimTime
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Crouch Hard Punch
[StateDef 450]
anim = 450
ctrl = 0
type = C
movetype = A
physics = C
velset = 0,0

[State 450, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,2

[State 450, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,2

[State 450, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
damage = 25
guardflag = L
pausetime = 11,11
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,-70
animtype = Heavy
ground.type = Low
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -3,-6
guard.velocity = -5
air.velocity = -4,-6

[State 450, Explod]
type = Explod
trigger1 = AnimElem = 1
anim = ifelse(palno=12, 30455, 455)
ID = 455
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
;removetime = -2
;sprpriority = 2
ontop = 1
removeongethit = 1

[State 450, 1]
type = ChangeState
trigger1 = !AnimTime
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Crouch Hard Kick
[StateDef 460]
anim = 460
ctrl = 0
type = C
movetype = A
physics = C
velset = 0,0

[State 460, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,2

[State 460, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,2

[State 460, Explod]
type = Explod
trigger1 = AnimElem = 3
anim = ifelse(palno=12, 30465, 465)
ID = 465
bindtime = 100
ontop = 1
removeongethit = 1

[State 460, HitDef]
type = HitDef
trigger1 = !Time
attr = C, NA
hitflag = MD
damage = 60
guardflag = L
pausetime = 0,5
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,0
animtype = Up
ground.type = Low
ground.slidetime = 20
ground.hittime  = 20
ground.velocity = 0, -13
guard.velocity = -3
air.velocity = 0, -13

[State 460, superjump follow]
type = ChangeState
trigger1 = MoveHit && command = "holdup"
value = 700

[State 460, 1]
type = ChangeState
trigger1 = !AnimTime
value = 11
ctrl = 1


;---------------------------------------------------------------------------
; Air Light Punch
[StateDef 610]
anim = 610
ctrl = 0
type = A
movetype = A
physics = A

[State 610, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,0

[State 610, grunt]
type = PlaySnd
trigger1 = Time = 1
value = 1,0

[State 610, HitDef]
type = HitDef
trigger1 = !Time
attr = A, NA
damage = 25
guardflag = HA
pausetime = 4,8
hitsound = S2,0
guardsound = S3,0
sparkxy = 0,-70
animtype = Light
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -5
guard.velocity = -7
air.velocity = -2,-3

[State 610, bounce]
type = VelAdd
trigger1 = !Time
y = IfElse(Vel Y <= 2, -2, -7)

[State 610, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;---------------------------------------------------------------------------
; Air Light Kick
[StateDef 620]
anim = 620
ctrl = 0
type = A
movetype = A
physics = A

[State 620, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,0

[State 620, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,0

[State 620, HitDef]
type = HitDef
trigger1 = !Time
attr = A, NA
damage = 22
guardflag = HA
pausetime = 4,8
hitsound = S2,0
guardsound = S3,0
sparkxy = 0,-10
animtype = Light
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -5
guard.velocity = -7
air.velocity = -2,-3

[State 620, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;---------------------------------------------------------------------------
; Air Medium Punch
[StateDef 630]
anim = 630
ctrl = 0
type = A
movetype = A
physics = A

[State 630, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,1

[State 630, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,1

[State 630, HitDef]
type = HitDef
trigger1 = !Time
attr = A, NA
damage = 65
guardflag = HA
pausetime = 4,8
hitsound = S2,1
guardsound = S3,0
sparkxy = 0,-70
animtype = Medium
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -5
guard.velocity = -7
air.velocity = -2,-3

[State 630, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;---------------------------------------------------------------------------
; Air Medium Kick
[StateDef 640]
anim = 640
ctrl = 0
type = A
movetype = A
physics = A

[State 640, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,1

[State 640, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,1

[State 640, HitDef]
type = HitDef
trigger1 = !Time
attr = A, NA
damage = 65
guardflag = HA
pausetime = 4,8
hitsound = S2,1
guardsound = S3,0
sparkxy = 0,-10
animtype = Medium
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -5
guard.velocity = -7
air.velocity = -2,-3

[State 640, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;---------------------------------------------------------------------------
; Air Hard Punch
[StateDef 650]
anim = 650
ctrl = 0
type = A
movetype = A
physics = A

[State 650, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,2

[State 650, grunt]
type = PlaySnd
trigger1 = AnimElem = 3
value = 1,2

[State 650, HitDef]
type = HitDef
trigger1 = !Time
attr = A, NA
damage = 96
guardflag = HA
pausetime = 0,8
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,-70
animtype = Heavy
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -5
guard.velocity = -7
air.velocity = -2,-3

[State 650, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;---------------------------------------------------------------------------
; Air Hard Kick
[StateDef 660]
anim = 660
ctrl = 0
type = A
movetype = A
physics = A

[State 660, swoosh]
type = PlaySnd
trigger1 = Time = 2
value = 0,2

[State 660, Explod]
type = Explod
trigger1 = AnimElem = 2
anim = ifelse(palno=12, 30665, 665)
ID = 665
bindtime = 100
ontop = 1
removeongethit = 1

[State 660, grunt]
type = PlaySnd
trigger1 = !Time
value = 1,2

[State 660, HitDef]
type = HitDef
trigger1 = !Time
attr = A, NA
damage = 92
guardflag = HA
pausetime = 0,8
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,-10
animtype = Heavy
ground.type = High
ground.slidetime = 10
ground.hittime  = 10
ground.velocity = -5
guard.velocity = -7
air.velocity = -2,-3

[State 660, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;--------------------------------------------------
; Anvil Slam (throw)
; throw start
[Statedef 800, Anvil Slam]
type = S
movetype = A
physics = S
ctrl = 0
anim = 800
velset = 0,0

[State 800, HitDef]
type = HitDef
trigger1 = !movecontact
attr = S,NT        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAF        ;HLAFD+-
guardflag = ;MA         ;HLA
getpower = 0,0
givepower = 0,0
animtype = DiagUp          ;light,medium,hard,back,up,diagup
air.animtype = Diagup
fall.animtype = Diagup
priority = 3,Miss
damage = 0,0
pausetime = 0,50
sparkno = -1
guard.sparkno = 0
sparkxy = 0,-75
hitsound = F5,5
guardsound = F5,5
ground.type = High      ;Low,Trip,None
air.type = High
ground.slidetime = 100
ground.hittime = 100
air.hittime = 100
ground.velocity = -4,-3
air.velocity = -4,-3
yaccel = 0.8
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = -1
p2facing = 1
p1stateno = 805
p2stateno = 806
forcestand = 1
fall = 1
fall.recovertime = 10
fall.xvelocity = -0.25
fall.yvelocity = -3.5
ignorehitpause = 1
persistent = 0

[State 800,1]
type = ChangeState
trigger1 = !animtime
value = 0
ctrl = 1

; Anvil Slam - throw connected
[Statedef 805]
type = S
movetype = A
physics = S
ctrl = 0
anim = 805
velset = 0,0
sprpriority = 2

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 1
time = 2
pos = 80,0
ignorehitpause = 1

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 2
time = 2
pos = 60,-110
ignorehitpause = 1

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 3
time = 12
pos = 35,-115
ignorehitpause = 1

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 4
time = 2
pos = 45,-120
ignorehitpause = 1

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 5
time = 8
pos = -15,-125
ignorehitpause = 1

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 6
time = 2
pos = 30,-120
ignorehitpause = 1

[State 805, TargetBind]
type = TargetBind
trigger1 = animelem = 7
time = 5
pos = 55,-65
ignorehitpause = 1

[State 805, Explod]
type = Explod
trigger1 = animelem = 5
anim = 935
ID = 935
pos = 48,-82
postype = p1  ;p2,front,back,left,right
bindtime = -1
removetime = 8
scale = 1,1
sprpriority = 6
ownpal = 1
removeongethit = 1

[State 805, Explod]
type = Explod
trigger1 = animelem = 5
anim = ifelse(palno=12, 30810, 810)
ID = 810
pos = 75,5
postype = p1  ;p2,front,back,left,right
bindtime = -1
removetime = -2
scale = 1,1
sprpriority = 4
ownpal = 1
removeongethit = 1

[State 805, Explod]
type = Explod
trigger1 = animelem = 7
anim = F60
ID = 60
pos = 75,-60
postype = p1  ;p2,front,back,left,right
bindtime = 1
scale = 1,1
sprpriority = 10
ontop = 0
shadow = -1,-1,-1
ownpal = 1

[State 805, Explod]
type = Explod
trigger1 = animelem = 7
anim = F1006
ID = 1006
pos = 120,-60
postype = p1  ;p2,front,back,left,right
bindtime = 1
scale = 1,1
sprpriority = 10
ontop = 0
shadow = -1,-1,-1
ownpal = 1

[State 805, dcvm hitspark1]
type = helper
trigger1 = animelem = 7
helpertype = normal
stateno = 1006  ;;; 47000 = weak spark  /  47001 = medium spark  /  47002 = strong spark
ID = 1006
name = "hitspark"
postype = p1
pos = 75,-60  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = -1
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 805, dcvm hitspark1]
type = helper
trigger1 = animelem = 7
helpertype = normal
stateno = 1006  ;;; 47000 = weak spark  /  47001 = medium spark  /  47002 = strong spark
ID = 1006
name = "hitspark"
postype = p1
pos = 75,-60  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = 1
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 805, PlaySnd]
type = PlaySnd
trigger1 = animelem = 6
value = S1,2
volume = 0
channel = 0
ignorehitpause = 1
persistent = 0

[State 805, PlaySnd]
type = PlaySnd
trigger1 = animelem = 7
value = F7,2
freqmul = 1.0
ignorehitpause = 1
persistent = 0

[State 805, PlaySnd]
type = PlaySnd
trigger1 = animelem = 7
value = S710,0
freqmul = 1.0
ignorehitpause = 1
persistent = 0

[State 805, EnvShake]
type = EnvShake
trigger1 = animelem = 7
time = 8
ampl = -10

[State 805,1]
type = ChangeState
trigger1 = !animtime
value = 0
ctrl = 1


; Anvil Slam - P2 custom thrown state
[Statedef 806]
type = A
movetype = H
physics = N
ctrl = 0
velset = 0,0
sprpriority = 0

[State 806, ChangeAnim2]
type = ChangeAnim2
trigger1 = !time
value = 806
ignorehitpause = 1
persistent = 0

[State 806, ScreenBound]
type = ScreenBound
trigger1 = time <= 40
value = 1
movecamera = 1,0

[State 806, SprPriority]
type = SprPriority
trigger1 = animelem = 6
value = 6

[State 806, LifeAdd]
type = LifeAdd
trigger1 = animelem = 6
value = -120
kill = 1
absolute = 0

[State 806, VelSet]
type = VelSet
trigger1 = time <=40
x = -4
y = -6
;persistent = 0

[State 806, 3] ;Gravity
type = VelAdd
trigger1 = time >= 40
y = GetHitVar(yaccel)

[State 806, PosAdd]
type = PosAdd
trigger1 = animelem = 7
y = -const(size.mid.pos.y)
ignorehitpause = 1
persistent = 0

[State 806, SelfState]
type = SelfState
trigger1 = !animtime
value = 5030
anim = 5030


;---------------------------------------------------------------------------
;Super Jump opponent locator
[Statedef 910]
type    = A
physics = N
ctrl = 0
sprpriority = 2

[State 910, arrow]
type = ChangeAnim
trigger1 = IsHelper(0)
;trigger1 = TeamSide = 2
value = 910

[State 910, destroyself]
type = DestroySelf
triggerall = IsHelper(0)
trigger1 = RootDist Y > 0

;-----------------------
; Safe fall (from superjump, or jumping attack)
[StateDef 948]
type = A
movetype = I
physics = A
ctrl = 1

; neutral
[State 948, ChangeAnim]
type = ChangeAnim
trigger1 = (!Time) && (Vel X = 0)
value = 48

; forwards
[State 948, ChangeAnim]
type = ChangeAnim
trigger1 = (!Time) && (Vel X > 0)
value = 49

; backwards
[State 948, ChangeAnim]
type = ChangeAnim
trigger1 = (!Time) && (Vel X < 0)
value = 50


;==========================================================================
;Guilty Gear Style 1-Hit Kill Haze Effect Positive States by Shinra358 Start
; (first implemented by SethZankuten for GLHal; borrowed and adapted by Buyog)
;==========================================================================
[Statedef 10050]; aura glow definition start
type = S
movetype = I
physics = N
sprpriority = -15
velset = 0,0
ctrl = 0
;

[State 10050, VarSet] ; grab Hal's palette number
type = VarSet
trigger1 = !Time
v = 10
value = parent,palno
;
[state 10050, noshadow]; aura has no shadow
type = assertspecial
triggerall = alive
trigger1 = 1
flag = noshadow
;
[state 10050, playerpush]; the aura can go right through you
type = playerpush
triggerall = alive
trigger1 = 1
time = -1
ignorehitpause = 1
persistent = 1
value = 0
;
[state 10050, nohit]; not able to hit the aura and vice versa
type = nothitby
triggerall = alive
trigger1 = 1
time = -1
persistent = 1
value = SCA
;
[State 10050, ChangeAnim]; makes the aura do what you do
type = ChangeAnim
triggerall = alive
trigger1 = selfanimexist(parent,anim)
elem = parent,animelemno(0)
value = parent, anim
;
[State 10050, bindtoroot]; binds the auras position to the player using it
type = bindtoroot
triggerall = alive
trigger1 = 1
facing = 1
pos = 0, 0
time = -1
ignorehitpause = 1
persistent = 1

; aura colors:
;palno<=6:    0, 150,   0   ;green
;palno=7:   215,   0,   0	;red
;palno=8:   215, 106,   0	;orange
;palno=9:   215, 215,   0	;yellow
;palno=10:    0,   0, 256	;blue
;palno=11:   64,   0, 256	;indigo
;palno=12:    0,   0,   0	;black

[State 10050, color]; normal: green
type = PalFX
triggerall = var(10) <= 6
trigger1 = 1
add = 0, 150, 0
mul = 125, 256, 0
sinadd = 10, 256, 10, 50
invertall = 0
color = 256
ownpal = 1
time = -1
ignorehitpause = 1
persistent = 1

[State 10050, color]; warm alternates (red/orange/yellow)
type = PalFX
triggerall = var(10) = [7,9]
trigger1 = 1
add = 215, IfElse(var(10)=7, 0, IfElse(var(10)=8, 106, 215)), 0
mul = 256, IfElse(var(10)=7, 64, IfElse(var(10)=8, 128, 256)),0
sinadd = 256, IfElse(var(10)=7, 10, IfElse(var(10)=8, 128, 256)), 10, 50
invertall = 0
color = 256
ownpal = 1
time = -1
ignorehitpause = 1
persistent = 1

[State 10050, color]; cool alternates (blue/indigo)
type = PalFX
triggerall = var(10) = [10,11]
trigger1 = 1
add = IfElse(var(10)=10,0,64), 0, 256
mul = IfElse(var(10)=10,0,64), 0, 256
sinadd = IfElse(var(10)=10, 0, 32), 0, 160, 1
invertall = 0
color = 256
ownpal = 1
time = -1
ignorehitpause = 1
persistent = 1

[State 10050, black] ; no palfx necessary to get a black aura
type = Null ;PalFX
triggerall = var(10) = 6
trigger1 = 1
add = 192, 0, 256
mul = 192, 0, 256
sinadd = 64, 0, 160, 1
invertall = 0
color = 256
ownpal = 1
time = -1
ignorehitpause = 1
persistent = 1

[State 10050, trans]; makes the aura see through
type = trans
triggerall = alive
trigger1 = 1
trans = addalpha
alpha = 256 - (15*time), (15*time)
time = -1
ignorehitpause = 1
persistent = 1
;
[State 10050, angledraw]; how big the aura radiates over time
type = angledraw
triggerall = alive
trigger1 = 1
value = 0
scale = 1 + (.0065*time), 1 + (0.0065*time)
time = -1
ignorehitpause = 1
persistent = 1
;
[State 10050, destroyself]; time to restart the hazing animations of the aura
type = Destroyself
triggerall = alive
trigger1 = time >= 15
;
;==========================================================================
;Guilty Gear Style 1-Hit Kill Haze Effect Positive States by Shinra358 End
;==========================================================================

