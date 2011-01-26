; States file for Hal Jordan -- Specials
;
;---------------------------------------------------------------------------
; Vars:
;   0: for Super Jump (0=vertical, 1=forward, -1=backward)
;   2: remembers the strength (W/M/H) of the most recent command
;   4: for keeping track of Hal's position during Ion Force
;   5: 0 if GL mode; 1-6 if in a custom mode (red, orange, yellow, blue, indigo, black)
; Helpers:
;   0: superjump opponent position indicator
; Explods:
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; Special Attacks
;
; Ring Strike (QCF + P) -- states 1000-1010
;   Just your basic ring energy beam
;
; Emerald Swordsman (QCF + P in air) -- states 1100-1105
;   Schwinnng!
;
; Charging Ram (QCF + K) -- state 1400, 1500 (air version)
;   Like Captain America's "Charging Star" -- powered-up dash move.
;
; Buzzcut (QCB + P) -- state 2000
;   Anti-air move; Hal creates a large spinning buzzsaw overhead to stop jump-ins;
;   Also effective as a launcher.
;
; Plasma Sphere (QCB + K) -- state 2300
;   Traps opponent in a ball of energy and slams him around
;
;---------------------------------------------------------------------------


;------------------------------
; Ring Strike
[StateDef 1000]
type = S
movetype = A
physics = S
ctrl = 0

[State 1000, VarSet]
type = PowerAdd
trigger1 = !Time && PalNo != 12
value = -150

[State 1000, VarSet]
type = VarSet
trigger1 = !Time
v = 2
value = IfElse(command = "qcf_x", 0, IfElse(command = "qcf_y", 1, 2))

[State 1000, changestate]
type = ChangeState
trigger1 = !Time
value = 1002+var(2)


;------------------------------
; Ring Strike (weak: fireball)
[StateDef 1002]
type = S
movetype = A
physics = S
anim = 1000
ctrl = 0

[State 1002, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 1
value = S9,0
channel = 0

[State 1002, Explod]
type = Explod
trigger1 = AnimElem = 1
anim = 918
ID = 918
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
sprpriority = 3
removeongethit = 1

[State 1002, Explod]
type = Explod
trigger1 = Time = 5
anim = 1001
ID = 1001
pos = 65,-93
bindtime = 1
removetime = -2
sprpriority = 2
ownpal = 1
removeongethit = 1

[State 1002, Projectile]
type = Projectile
trigger1 = Time = 10
ProjID = 1002
projanim = 1002
velocity = 5,0
projpriority = 1
projsprpriority = 3
offset = 65,-93
; HitDef
attr = S,SP
hitflag = MAF
guardflag = MA
getpower = 0,0
animtype = medium          ;light,medium,hard,back,up,diagup
priority = 4,Hit
damage = 30,8
pausetime = 4,5
sparkno = S9990
;guard.sparkno = S
;sparkxy = 0,0
hitsound = S2,2
guardsound = S3,0
ground.type = High
ground.slidetime = 15
ground.hittime  = 15
air.hittime = 20
ground.velocity = -1.7,0
air.velocity = -1.9,0
sprpriority = 2

[State 1002, changestate]
type = ChangeState
trigger1 = Time = 50
value = 1009

;------------------------------
; Ring Strike (medium)
[StateDef 1003]
type = S
movetype = A
physics = S
anim = 1000
ctrl = 0

[State 1003, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 1
value = S9,0
volume = 0
channel = 0
freqmul = 1.0
loop = 0
pan = 0

[State 1003, Explod]
type = Explod
trigger1 = AnimElem = 1
anim = 918
ID = 918
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
sprpriority = 3
removeongethit = 1

[State 1003, Explod]
type = Explod
trigger1 = Time = 5
anim = 1001
ID = 1001
pos = 65,-93
bindtime = 1
removetime = -2
sprpriority = 2
ownpal = 1
removeongethit = 1

[State 1003, beam]
type = Helper
trigger1 = Time = 10
helpertype = normal
name = "beam"
ID = 1013
pos = 65,-93
postype = p1
stateno = 1013
ownpal = 1

[State 1003, changestate]
type = ChangeState
trigger1 = AnimTime = 0 & NumHelper(1013) = 0
value = 1009

;------------------------------
; Ring Strike (heavy)
[StateDef 1004]
type = S
movetype = A
physics = S
anim = 1000
ctrl = 0

[State 1004, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 1
value = S9,0
volume = 0
channel = 0
freqmul = 1.0
loop = 0
pan = 0

[State 1004, Explod]
type = Explod
trigger1 = AnimElem = 1
anim = 918
ID = 918
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
sprpriority = 3
removeongethit = 1

[State 1004, beam]
type = Helper
trigger1 = Time = 10
helpertype = normal
name = "beam"
ID = 1014
pos = 65,-93
postype = p1
stateno = 1014
ownpal = 1

[State 1004, changestate]
type = ChangeState
trigger1 = AnimTime = 0 & NumHelper(1014) = 0
value = 1009


;------------------------------
; Energy Hit
[StateDef 1006]
type = S
movetype = I
physics = N
anim = ifelse((root, PalNo = 12), 30950, 950)
velset = 0,0
sprpriority = 10
ctrl = 0

[State 47002, a3] ;particles
type = Explod
trigger1= NumExplod(936)<10
trigger1 = time < 5
anim = ifelse((root, PalNo = 12), 30935, 935)
id = 936
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
vel = 6+(random/250),-5+(random/100)
accel = -.1,0
removetime = 20
supermovetime = 999
pausemovetime = 999
scale = .75,.75
sprpriority = 18
ownpal = 1

[State 47002, a3] ;particles
type = Explod
trigger1= NumExplod(936)<10
trigger1 = time < 5
anim = ifelse((root, PalNo = 12), 30935, 935)
id = 936
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
vel = 6+(random/250),-5+(random/100)
accel = -.1,0
removetime = 20
supermovetime = 999
pausemovetime = 999
scale = .75,.75
sprpriority = 18
ownpal = 1

[State 1006, DestroySelf]
type = DestroySelf
trigger1 = !animtime
ignorehitpause = 1
persistent = 1


;---------
; Ring Strike - end
[StateDef 1009]
type = S
movetype = A
physics = S
anim = 1009

[State 1009, changestate]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;--------
; Ring Strike -- "fireball" helper state
[StateDef 1010]
type = A
movetype = A
physics = C
anim = 1005
ctrl = 0
sprpriority = 2

[State 1010, PosSet]
type = PosSet
trigger1 = 1
x = parent, Pos X
y = parent, Pos Y

[State 1010, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S9,1
volume = 0
channel = -1
freqmul = 1.0
loop = 0
pan = 0

[State 1010, hitdef]
type = HitDef
trigger1 = movecontact = 0
attr = S,SP
hitflag = MAF
guardflag = MAF
animtype = Medium
air.animtype = Medium
fall.animtype = Medium
damage = 85,15
getpower = 0,0
guardflag = MA
pausetime = 5,11
hitsound = S9,2
guardsound = S3,0
sparkno = S9992
sparkxy = 0,-96
animtype = Heavy
ground.type = High
ground.slidetime = 10
ground.hittime  = 20
ground.velocity = -8
guard.velocity = -5
air.velocity = -4,8
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 4
palfx.time = 15
palfx.add = 0,64,0

[State 1010, DestroySelf]
type = DestroySelf
trigger1 = AnimTime = 0

;--------
; Ring Strike -- medium beam helper state
[StateDef 1013]
type = A
movetype = A
physics = C
anim = 1003
ctrl = 0

[State 1013, ontop]
type = SprPriority
trigger1 = 1
value = 2

[State 1013, PosSet]
type = PosSet
trigger1 = 1
x = parent, Pos X + (65 * parent, facing)
y = parent, Pos Y - 93

[State 1013, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S9,1
volume = 0
channel = -1
freqmul = 1.0
loop = 0
pan = 0

[State 3515, dcvm hitspark1]
type = helper
triggerall = numhelper(47000) <= hitcount
trigger1 = movehit && enemynear,time = 0
helpertype = normal
stateno = 1006  ;;; 47000 = weak spark  /  47001 = medium spark  /  47002 = strong spark
ID = 1006
name = "hitspark"
postype = p1
pos = ceil(p2dist x),ceil(p2dist y + enemynear,const(size.mid.pos.y))  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = ifelse(p2dist x > 0, 1,-1)
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 1013, hitdef]
type = HitDef
trigger1 = TimeMod = 15,0
attr = S,SP
hitflag = MAF
guardflag = MAF
animtype = Medium
air.animtype = Medium
fall.animtype = Medium
damage = 21,3
getpower = 0,0
guardflag = MA
pausetime = 5,11
hitsound = S9,2
guardsound = S3,0
sparkno = -1 ;S9991
animtype = Heavy
ground.type = High
ground.slidetime = 8
ground.hittime  = 16
ground.velocity = -7
guard.velocity = -4
air.velocity = -3,6
kill = 1
guard.kill = 1
fall.kill = 1
palfx.time = 15
palfx.add = 0,64,0

[State 1013, DestroySelf]
type = DestroySelf
trigger1 = AnimTime = 0
trigger2 = parent, Anim != 1000


;--------
; Ring Strike -- heavy beam helper state
[StateDef 1014]
type = A
movetype = A
physics = C
anim = 1004
ctrl = 0

[State 1014, ontop]
type = SprPriority
trigger1 = 1
value = 2

[State 1014, PosSet]
type = PosSet
trigger1 = 1
x = parent, Pos X + (65 * parent, facing)
y = parent, Pos Y - 93

[State 1014, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S9,1
volume = 0
channel = -1
freqmul = 1.0
loop = 0
pan = 0

[State 3515, dcvm hitspark1]
type = helper
triggerall = numhelper(47000) <= hitcount
trigger1 = movehit && enemynear,time = 0
helpertype = normal
stateno = 1006  ;;; 47000 = weak spark  /  47001 = medium spark  /  47002 = strong spark
ID = 1006
name = "hitspark"
postype = p1
pos = ceil(p2dist x),ceil(p2dist y + enemynear,const(size.mid.pos.y))  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = ifelse(p2dist x > 0, 1,-1)
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 1014, hitdef]
type = HitDef
trigger1 = TimeMod = 10,0
attr = S,SP
hitflag = MAF
guardflag = MAF
animtype = Medium
air.animtype = Medium
fall.animtype = Medium
damage = 18,3
getpower = 0,0
guardflag = MA
pausetime = 6,12
hitsound = S9,1
guardsound = S3,0
sparkno = -1 ;S9992
animtype = Heavy
ground.type = High
ground.slidetime = 10
ground.hittime  = 20
ground.velocity = -8
guard.velocity = -5
air.velocity = -4,8
kill = 1
guard.kill = 1
fall.kill = 1
palfx.time = 25
palfx.add = 0,64,0

[State 1014, DestroySelf]
type = DestroySelf
trigger1 = AnimTime = 0
trigger2 = parent, Anim != 1000


;------------------------------
; Ring Strike (air) - deprecated for the moment
[StateDef 1050]
type = A
movetype = A
physics = A
anim = 1000
ctrl = 0

[State 1100, noGravity]
type = VelSet
trigger1 = TimeMod = 2,1
y = 0

[State 1100, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA, NA, SA, HA, NP, SP, HP
slot = 0
stateno = 5000
time = 1
forceair = 1

[State 1100, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 1
value = S9,0
volume = 0
channel = 0
freqmul = 1.0
loop = 0
pan = 0

[State 1100, Explod]
type = Explod
trigger1 = Time = 5
anim = 1001
ID = 1001
pos = 65,-93
bindtime = 1
removetime = -2
sprpriority = 2
ownpal = 1
removeongethit = 1

[State 1100, beam]
type = Helper
trigger1 = Time = 10
helpertype = normal
name = "beam"
ID = 1014
pos = 65,-93
postype = p1
stateno = 1014
ownpal = 1

[State 1100, changestate]
type = ChangeState
trigger1 = AnimTime = 0 & NumHelper(1014) = 0
value = 1051
ctrl = 1


;------------------------------
; Ring Strike - end
[StateDef 1051]
type = A
movetype = I
physics = A
anim = 1001

[State 1101, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 948
ctrl = 1


;------------------------------
; Emerald Swordsman (air)
[StateDef 1100]
type = A
movetype = A
physics = A
anim = 1100
ctrl = 0

[State 1000, VarSet]
type = PowerAdd
trigger1 = !Time && PalNo != 12
value = -90

[State 1100, noGravity]
type = VelSet
trigger1 = TimeMod = 2,1
y = 0

[State 1100, sword]
type = Helper
trigger1 = AnimElem = 1
helpertype = normal
name = "beam"
ID = 1105
pos = 0,0
postype = p1
stateno = 1105
ownpal = 1

[State 1100, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


;------------------------------
; Emerald Swordsman (sword helper)
[StateDef 1105]
type = A
movetype = A
physics = N
anim = ifelse((root, PalNo = 12), 31105, 1105)

[State 1105, ontop]
type = SprPriority
trigger1 = 1
value = 2

[State 1105, PosSet]
type = PosSet
trigger1 = 1
x = parent, Pos X
y = parent, Pos Y

[State 1105, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S9,40
channel = 0

[State 1105, hitdef]
type = HitDef
trigger1 = AnimElem = 3
attr = S,SP
hitflag = MAF
guardflag = MAF
animtype = Medium
air.animtype = Medium
fall.animtype = Medium
damage = 18,3
getpower = 0,0
guardflag = MA
pausetime = 6,12
hitsound = S2,10
guardsound = S3,0
sparkno = S9992
animtype = Heavy
ground.type = High
ground.slidetime = 10
ground.hittime  = 20
ground.velocity = -8
guard.velocity = -5
air.velocity = -9,-2
kill = 1
guard.kill = 1

[State 1105, DestroySelf]
type = DestroySelf
trigger1 = AnimTime = 0
trigger2 = parent, Anim != 1100


;------------------------------
; Battering Ram
[StateDef 1400]
type    = A
movetype = A
physics = N
ctrl = 0
anim = 1400

[State 1400, VarSet]
type = PowerAdd
trigger1 = !Time && PalNo != 12
value = -150

[State 1400, Explod]
type = Explod
trigger1 = AnimElem = 1
anim = 918
ID = 918
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
sprpriority = 3
removeongethit = 1

[State 1400, voice]
type = PlaySnd
trigger1 = Time = 0
value = 9,10

[State 1400, sfx]
type = PlaySnd
trigger1 = AnimElem = 2
value = 9,11

[State 1400, velset]
type = VelSet
trigger1 = AnimElem = 2
x = 8

[State 1400, lines]
type = Explod
trigger1 = 1
anim = ifelse(PalNo = 12, 30113, 113)
ID = 113
removeongethit = 1
removetime = 60
vel = -10-ceil(random/20), 0
postype = p1
pos = -20, -80
random = 0,80
xscale = 0.5
yscale = 0.5
sprpriority = -3
bindtime = 1
ownpal = 1

[State 1400, spark]
type = Explod
trigger1 = AnimElem = 2
ID = 1420
anim = ifelse(PalNo = 12, 31420, 1420)
bindtime = -1
facing = 1
removetime = -1
sprpriority = 2
removeongethit = 1

[State 1400, HitDef]
type = HitDef
trigger1 = Time % 4 = 0
attr = S, SA
damage = 14
getpower = 0,0
guardflag = MA
pausetime = 11,11
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,-70
animtype = Heavy
ground.type = High
ground.slidetime = 20
ground.hittime  = 20
ground.velocity = -4,-1
guard.velocity = -2
air.velocity = -4,-1
priority = 7,Hit

[State 1400, sparkBegone]
type = RemoveExplod
trigger1 = AnimElem = 3
ID = 1420

[State 1400, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;------------------------------
; Battering Ram (air)
[StateDef 1500]
type    = A
movetype = A
physics = N
ctrl = 0
anim = 1400

[State 1500, VarSet]
type = PowerAdd
trigger1 = !Time && PalNo != 12
value = -150

[State 1500, noGravity]
type = VelSet
trigger1 = 1
y = 0

[State 1500, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA, NA, SA, HA, NP, SP, HP
slot = 0
stateno = 5000
time = 1
forceair = 1

[State 1500, voice]
type = PlaySnd
trigger1 = Time = 0
value = 9,10

[State 1500, sfx]
type = PlaySnd
trigger1 = AnimElem = 2
value = 9,11

[State 1500, velset]
type = VelSet
trigger1 = AnimElem = 2
x = 8

[State 1500, lines]
type = Explod
trigger1 = 1
anim = ifelse(PalNo = 12, 30113, 113)
ID = 113
removeongethit = 1
removetime = 60
vel = -10-ceil(random/20), 0
postype = p1
pos = -20, -80
random = 0,80
xscale = 0.5
yscale = 0.5
sprpriority = -3
bindtime = 1
ownpal = 1

[State 1500, spark]
type = Explod
trigger1 = AnimElem = 2
ID = 1420
anim = ifelse(PalNo = 12, 31420, 1420)
bindtime = -1
facing = 1
removetime = -1
sprpriority = 2
removeongethit = 1

[State 1500, HitDef]
type = HitDef
trigger1 = Time % 4 = 0
attr = S, SA
damage = 15
getpower = 0,0
guardflag = MA
pausetime = 11,11
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,-70
animtype = Heavy
ground.type = High
ground.slidetime = 20
ground.hittime  = 20
ground.velocity = -4,-1
guard.velocity = -2
air.velocity = -4,-1
priority = 7,Hit

[State 1500, sparkBegone]
type = RemoveExplod
trigger1 = AnimElem = 3
ID = 1420

[State 1500, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 948
ctrl = 1


;------------------------------
; Buzzcut
[StateDef 2000]
type = S
movetype = A
physics = S
anim = 2000
ctrl = 0

[State 2000, VarSet]
type = PowerAdd
trigger1 = !Time && PalNo != 12
value = -75

[State 2000, voice]
type = PlaySnd
trigger1 = !Time && PalNo != 7
value = 9,20
channel = 0
persistent = 1

[State 2000, red voice]
type = PlaySnd
trigger1 = AnimElem = 3 && PalNo = 7
value = 1,11
channel = 0
persistent = 1

[State 2000, sfx]
type = PlaySnd
trigger1 = AnimElem = 5
value = 9,21
persistent = 0

[State 2000, VelSet]
type = VelSet
trigger1 = animelem = 5
x = 4
ignorehitpause = 1
persistent = 0

[State 2000, Width]
type = Width
trigger1 = time = [12,42]
edge = 40,0
ignorehitpause = 1

[State 2000, HitDef]
type = HitDef
trigger1 = !movecontact
attr = S,SA
hitflag = MAF
guardflag = MA
animtype = up
priority = 3,Hit
damage = 40,0
getpower = 0,0
pausetime = 10,4
sparkno = S9992
guard.sparkno = 0
sparkxy = -20,-65
hitsound = S2,2
guardsound = S3,0
ground.type = High
ground.slide = 10
ground.hit = 12
air.hittime = 20
ground.velocity = 1,-12
guard.velocity = -9
air.velocity = 0,-12
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0

[State 2000, Helper]
type = Helper
trigger1 = AnimElem = 5
name = "buzzsaw"
ID = 2010
stateno = 2010
pos = 0,0
postype = p1

[State 2000, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


; Buzzcut (helper state)
[StateDef 2010]
type = S
movetype = A
physics = S
anim = 2010
ctrl = 0
sprpriority = 3

[State 2010, PosSet]
type = PosSet
trigger1 = IsHelper
x = parent, pos x
y = parent, pos y

[State 2010, nothitby]
type = NotHitBy
trigger1 = IsHelper
value = SCA

[State 3515, dcvm hitspark1]
type = helper
triggerall = numhelper(47000) <= hitcount
trigger1 = movehit && enemynear,time = 0
helpertype = normal
stateno = 1006  ;;; 47000 = weak spark  /  47001 = medium spark  /  47002 = strong spark
ID = 1006
name = "hitspark"
postype = p1
pos = ceil(p2dist x),ceil(p2dist y + enemynear,const(size.mid.pos.y))  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = ifelse(p2dist x > 0, 1,-1)
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 2010, HitDef]
type = HitDef
trigger1 = Time % 4 = 0
attr = S,SA
hitflag = MAF
guardflag = MA
animtype = diagup
priority = 5,Hit   ;Hit,Miss,Dodge
damage = 30,5
getpower = 0,0
pausetime = 14,10
sparkno = -1 ;S9992
sparkxy = -65,-155
hitsound = S2,2
guardsound = S3,0
ground.type = High
ground.slide = 0
;guard.slide = 0
ground.hit = 0
;guard.hit = 0
air.hittime = 20
;guard.ctrl  = 0
;guard.dist = 320
;yaccel = 0.5
ground.velocity = -2,-5
;guard.velocity = 0
air.velocity = -1.5,-6.5
sprpriority = 4
fall = 1
;fall.xvelocity = -3
fall.yvelocity = -4.5
fall.recover = 1
fall.recovertime = 4
fall.damage = 0
down.bounce = 1
kill = 1
guard.kill = 1

[State 2010, ChangeAnim]
type = ChangeState
trigger1 = Time = 50
trigger2 = parent, AnimElem >= 6
trigger3 = parent, Anim != 2000
value = 2015

; Buzzcut (helper fading away)
[StateDef 2015]
type = S
movetype = A
physics = S
anim = 2015
ctrl = 0
sprpriority = 3

[State 2015, nothitby]
type = NotHitBy
trigger1 = IsHelper
value = SCA

[State 2015, DestroySelf]
type = DestroySelf
trigger1 = AnimTime = 0


;------------------------------
; Plasma Sphere
[StateDef 2300]
type = S
movetype = A
physics = S
anim = 2300
ctrl = 0

[State 2300, VarSet]
type = PowerAdd
trigger1 = !Time && PalNo != 12
value = -100

[State 2300, Helper]
type = Helper
trigger1 = AnimElem = 4
helpertype = normal
name = "Plasma Sphere"
ID = 2310
stateno = 2310
pos = 160,-100
postype = p1
facing = 1

[State 2300, ring spark]
type = Explod
trigger1 = AnimElem = 4
anim = ifelse(PalNo = 12, 30936, 936)
pos = 47,-107
ID = 936
bindtime = 24
removetime = 24
sprpriority = 3

[State 2300, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 2350

; Plasma Sphere - construct
[StateDef 2310]
type = S
movetype = A
physics = S
anim = ifelse((root, PalNo = 12), 32310, 2310)
ctrl = 0

[State 2310, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,31

[State 2310, HitDef]
type = HitDef
trigger1 = IsHelper
attr = S,ST
hitflag = MAF
guardflag = MA
animtype = hard
priority = 5,Hit
damage = 10,0
getpower = 0,0
pausetime = 0,10
sparkno = S9992
sparkxy = 0,0
hitsound = S2,2
guardsound = S3,0
ground.type = High
ground.slide = 14
ground.hit = 12
air.hittime = 20
ground.velocity = 0,0
air.velocity = 0,0
sprpriority = 3
p1stateno = 2320
p2stateno = 2330
kill = 1
guard.kill = 1
numhits = 1

[State 2310, DestroySelf]
type = DestroySelf
trigger1 = !AnimTime


; Plasma Sphere - P1 throw action
[StateDef 2320]
anim = ifelse((root, PalNo = 12), 32320, 2320)
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0

[State 2320, 0]
type = PlaySnd
trigger1 = !Time
persistent = 0
value = S9,32

[State 2320, Bind 1]
type = TargetBind
trigger1 = AnimElem = 1
pos = 0,0

[State 2320, targetdrop]
type = TargetDrop
trigger1 = AnimTime = -1

[State 2320, turn]
type = Turn
trigger1 = AnimTime = -1

[State 2320, destroySelf]
type = DestroySelf
trigger1 = !AnimTime


;-------------------------------------------
; Being grabbed (p2 custom hit state)
[StateDef 2330]
type = A
movetype = H
physics = N
ctrl = 0
velset = 0,0

;Generated by Fighter Factory PalFX Editor
[State 2330, PalFXWiz]
type = PalFX
trigger1 = 1
time = 1
add = 0,128,0
mul = 256,256,256
sinadd = 0,64,0,32
invertall = 0
color = 256

[State 2330, ChangeAnim2]
type = ChangeAnim2
Trigger1 = !Time
value = 2330

[State 2330, screenbound]  ; don't move the camera to follow P2
type = ScreenBound
trigger1 = Alive
movecamera = 0,0

[State 2330, 2] ;dropped
type = SelfState
trigger1 = !AnimTime
value = 5050


;-------------------------------------------
; Being thrown (p2 custom hit state)
[StateDef 2340]
type = A
movetype = H
physics = N
ctrl = 0
velset = 10,-2

[State 2340, ChangeAnim2]
type = ChangeAnim2
Trigger1 = Time = 0
value = 2340

[State 2340, 0]
type = PosSet
trigger1 = Time = 0
y = Pos Y - 10

[State 2340, turn around]
type = Turn
trigger1 = AnimTime = 0

[State 2340, 2] ;dropped
type = SelfState
trigger1 = AnimTime = 0
value = 5050

;------------------------------
; Plasma Sphere: finish
[StateDef 2350]
type    = S
movetype = I
physics = S
anim = 2350

[State 2350, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Finish Hit Explod (based on FlowaGirl and Ethan Lives codes)
; (taken with permission from McCready's StrongGuy char)
[Statedef 8900]
type = S
movetype = I
physics = N
anim = 8930

;[State 8900, 1]
;type = Pause
;trigger1 = (!Time)
;time = 12
;movetime = 12

[State 8900, 1]
type = EnvShake
trigger1 = (!Time)
time = 12
freq = 120;10
ampl = -3;2
phase = 90

[State 8900, 2]
type = Explod
triggerall = (NumExplod(8900) < 1)
trigger1 = Time = 0
persistent = 0
anim = 8900
ID = 8900
postype = left
pos = 0, 0
velocity = 0, 0
accel = 0, 0
removetime = -2
sprpriority = -4
bindtime = -1
ontop = 1
ownpal = 1
supermovetime = 1000
pausemovetime = 1000
ignorehitpause = 1

[State 8900, 3]
type = PlaySnd
trigger1 = (NumExplod(8900) != 0)
value = 30, 0
persistent = 0
supermovetime = 1000
pausemovetime = 1000
ignorehitpause = 1

[State 8900, done]
type = DestroySelf
trigger1 = RoundState = 4
