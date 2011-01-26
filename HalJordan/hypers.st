; States file for Hal Jordan -- Hypers
;
;---------------------------------------------------------------------------
; Vars:
; Var(0): for Super Jump (0=vertical, 1=forward, -1=backward)
; Var(1): AI trigger
; Var(2): strength (W/M/H) of last command (1000, 17700, 18700, 18800, 21700)
; Var(3): air or ground version of a move (17800)
; Var(4): for keeping track of Hal's position during Ion Force
; Var(5): 0 if GL mode; 1-6 if in a custom mode (red, orange, yellow, blue, indigo, black)
; Var(10): Palette number of parent (for Ring Slinging blobs) (3305)
; Var(50): StateDef -3

; Floats:
; fVar(2) - StateDef 3305, 22800, 22805, 22810, 22811
; fVar(3) - StateDef 3305, 18810, 22811
; fVar(25) - StateDef 3500, 3505


; Helpers:
;   0: superjump opponent position indicator
; Explods:
;---------------------------------------------------------------------------


;---------------------------------------------------------------------------
; Hyper Attacks
; 
; Soldier of Oa (QCB + P+K of equal strength): 3000-3005
;  Chain hyper with three parts (eventually :-P):
;    1. Missle barrage from a ring-constructed bunker
;    (not yet) 2. Ring-generated bum rush of soldiers
;    (not yet) 3. Fighter jet flyby/strafing run
;
; Emerald Knight (QCF + KK): 3100-3155
;   Hal creates a suit or armor, lance, and horse -- then charges at the user doing major chip damage
;
; Knockout (QCF + PP): 3200-3250
;   A Hal Jordan staple... the huge boxing glove
;
; Ring Slinging (QCB + KK): 3300-3305
;   Hal crouches and unleashes a volley of energy trails that fill the screen and seek out their targets
;
; Ion Force (QCB + PP): 3500-3520
;   Hal summons the power of Ion (yeah, I know that was Kyle, but just roll with it... ;))
;
; Smackdown (QCF + PK): 4200-4220
;   Another huge boxing glove, this one smashes the opponent to the ground before knocking them high into the air
;
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; Soldier of Oa (intro)
[StateDef 3000]
type = A
movetype = A
physics = N
anim = 3000
ctrl = 0
velset = -3.8,-6.3

; "Come get some!"
[State 3000, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S10,10
channel = 1

[State 3000, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S8,0
channel = -1

[State 3000, Gravity]
type = VelAdd
trigger1 = 1
y = .35

[State 3000, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 3000, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA, AA, AT, AP
slot = 0
stateno = 5050
time = 1
forceair = 1

[State 3000, on the ground]
type = ChangeState
trigger1 = (Vel y > 0) && (Pos y >= 0)
value = 3005

; Soldier of Oa - firing the barrage
[StateDef 3005]
type = S
movetype = A
physics = S
anim = 3005
ctrl = 0
velset = 0,0
sprpriority = 4

[State 3005, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 3005, followP2]
type = ScreenBound
trigger1 = 1
value = 0

; Bunker creation SND
[State 3000, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S9,31
channel = -1

[State 3005, Explod]
type = Explod
trigger1 = Time = 0
anim = ifelse(palno=12, 33010, 3010)
ID = 3010
pos = 0,0
postype = p1
facing = 1
vfacing = 1
bindtime = 200
vel = 0,0
removetime = -2
supermove
pausemove
scale = 1,1
sprpriority = 5
ontop = 1
removeongethit = 1

[State 3005, superpause]
type = SuperPause
trigger1 = Time = 21
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

;-------------------
; DCvM hyper portrait/BG
[State 3005, superportrait]
type = Explod
trigger1 = Time = 21
anim = 10000 + var(5)
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 3005, portraitBG]
type = Explod
trigger1 = Time = 21
anim = 10020
ID = 10020
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -2
ownpal = 1

[State 3005, superBG]
type = Helper
trigger1 = Time = 22
name = "Super BG"
ID = 8005
stateno = 8005
postype = back
facing = 1
ownpal = 1
supermovetime = 999999
pausemovetime = 999999
ownpal = 1
; end DCvM stuff
;-------------------

; "Homing Missles!"
[State 3005, PlaySnd]
type = PlaySnd
trigger1 = Time = 22
value = S10,12
channel = 1

; missle SND
[State 3005, PlaySnd]
type = PlaySnd
trigger1 = (Time >= 25) && TimeMod = 10,0
value = S10,11 ;13

[State 3005, missle1]
type = Projectile
trigger1 = (Time >= 25) && TimeMod = 10,0
ProjID = 3020
projanim = ifelse(palno=12, 33020, 3020)
projscale = 1,1
projremove = 1
projremovetime = -1
velocity = 1.8,0.4
remvelocity = 0,0
accel = 1,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 5
projedgebound = 240
projstagebound = 40
projheightbound = -240
offset = 56,-31
postype = p1
projshadow = 0,0,0
; HitDef
attr = S,HP
hitflag = MAF
guardflag = MA
animtype = back
priority = 7,Hit
damage = 8,2
pausetime = 1,3
sparkno = S950
ground.type = Low
ground.slide = 10
ground.hit = 10
air.hittime = 3
ground.velocity = -5,-2
air.velocity = -6,-4
sprpriority = 2
fall = 1
down.bounce = 1
palfx.time = 2
palfx.add = 0,128,0

[State 3005, missle2]
type = Projectile
trigger1 = (Time >= 25) && TimeMod = 10,0
ProjID = 3020
projanim = ifelse(palno=12, 33020, 3020)
projscale = 1,1
projremove = 1
projremovetime = -1
velocity = 1.8,-0.4
remvelocity = 0,0
accel = 1,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 5
projedgebound = 240
projstagebound = 40
projheightbound = -240
offset = -9,-16
postype = p1
projshadow = 0,0,0
; HitDef
attr = S,HP
hitflag = MAF
guardflag = MA
animtype = back
priority = 7,Hit
damage = 8,2
pausetime = 1,3
sparkno = S950
ground.type = Low
ground.slide = 10
ground.hit = 10
air.hittime = 3
ground.velocity = -5,-2
air.velocity = -6,-4
sprpriority = 2
fall = 1
down.bounce = 1
palfx.time = 2
palfx.add = 0,128,0

[State 3005, missle3]
type = Projectile
trigger1 = (Time >= 25) && TimeMod = 10,0
ProjID = 3020
projanim = ifelse(palno=12, 33020, 3020)
projscale = 1,1
projremove = 1
projremovetime = -1
velocity = 1.8,0.5
remvelocity = 0,0
accel = 1,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 5
projedgebound = 240
projstagebound = 40
projheightbound = -240
offset = 52,-69
postype = p1
projshadow = 0,0,0
; HitDef
attr = S,HP
hitflag = MAF
guardflag = MA
animtype = back
priority = 7,Hit
damage = 8,2
pausetime = 1,3
sparkno = S950
ground.type = Low
ground.slide = 10
ground.hit = 10
air.hittime = 3
ground.velocity = -5,-2
air.velocity = -6,-4
sprpriority = 2
fall = 1
down.bounce = 1
palfx.time = 2
palfx.add = 0,128,0

[State 3005, missle4]
type = Projectile
trigger1 = (Time >= 25) && TimeMod = 10,0
ProjID = 3020
projanim = ifelse(palno=12, 33020, 3020)
projscale = 1,1
projremove = 1
projremovetime = -1
velocity = 1.8,0.3
remvelocity = 0,0
accel = 1,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 5
projedgebound = 240
projstagebound = 40
projheightbound = -240
offset = -20,-67
postype = p1
projshadow = 0,0,0
; HitDef
attr = S,HP
hitflag = MAF
guardflag = MA
animtype = back
priority = 7,Hit
damage = 8,2
pausetime = 1,3
sparkno = S950
ground.type = Low
ground.slide = 10
ground.hit = 10
air.hittime = 3
ground.velocity = -5,-2
air.velocity = -6,-4
sprpriority = 2
fall = 1
down.bounce = 1
palfx.time = 2
palfx.add = 0,128,0

[State 3005, screenBound]
type = ScreenBound
trigger1 = 1
value = 0

[State 3005, back to normal]
type = null ;ChangeState
trigger1 = AnimTime = 0
value = 3250

[State 3005, 1] ; DCvM dash onscreen
type = ChangeState
triggerall = !AnimTime
trigger1 = BackEdgeBodyDist <= -1 || frontedgebodydist <= -1
value = 7100

[State 3005, ChangeState]
type = ChangeState
triggerall = !AnimTime
trigger1 = BackEdgeBodyDist >= 0 || frontedgebodydist >= 0
value = 0
ctrl = 1



;---------------------------------------------------------------------------
; Hyper: Emerald Knight (startup when on ground)
[Statedef 3100]
type    = S
physics = S
anim = 40
ctrl = 0
sprpriority = 1

[State 3100, dust]
type = Explod
trigger1 = Time = 0
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

[State 3100, 0]
type = VelSet
trigger1 = !AnimTime
x = const(velocity.jump.back.x)
y = const(velocity.jump.y)

[State 3100, 1]
type = ChangeState
trigger1 = !AnimTime
value = 3125
ctrl = 1


;------------------------------
; Emerald Knight: superpause, construct generation
[StateDef 3125]
type    = A
movetype = A
physics = N
ctrl = 0
anim = 3125
velset = 0,0

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 3125, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 3125, superpause]
type = SuperPause
trigger1 = AnimElem = 1
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

[State 3125, superportrait]
type = Explod
trigger1 = AnimElem = 1
anim = 10000 + var(5)
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 3125, portraitBG]
type = Explod
trigger1 = AnimElem = 1
anim = 10020
ID = 10020
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -2
ownpal = 1
; end DCvM stuff
;-------------------

; show construct-generation explods
[State 3125, lance]
type = Explod
trigger1 = AnimElem = 2
anim = ifelse(PalNo=12, 33126, 3126)
ID = 3126
sprpriority = 2
removeongethit = 1

[State 3125, horse]
type = Explod
trigger1 = AnimElem = 2
anim = ifelse(PalNo=12, 33127, 3127)
ID = 3127
sprpriority = 3
removeongethit = 1

[State 3125, whinney]
type = PlaySnd
trigger1 = AnimElem = 2
value = S10,30

[State 3125, armor]
type = Explod
trigger1 = AnimElem = 2
anim = ifelse(PalNo=12, 33128, 3128)
ID = 3128
sprpriority = 4
removeongethit = 1

[State 3125, PlaySnd]
type = PlaySnd
trigger1 = Time = 15
value = S9,2

[State 3125, charge fwd]
type = ChangeState
trigger1 = !AnimTime
value = 3150
ctrl = 1


;------------------------------
; Emerald Knight: charge!
[StateDef 3150]
type    = A
movetype = A
physics = N
ctrl = 0
anim = 3150
sprpriority = 1

[State 3150, lance]
type = Explod
trigger1 = !Time
anim = ifelse(PalNo=12, 33151, 3151)
ID = 3151
bindtime = 99999
removetime = -1
sprpriority = 2
removeongethit = 1

[State 3150, horse]
type = Explod
trigger1 = !Time
anim = ifelse(PalNo=12, 33152, 3152)
ID = 3152
bindtime = 99999
removetime = -1
sprpriority = 3
removeongethit = 1

[State 3150, armor]
type = Explod
trigger1 = !Time
anim = ifelse(PalNo=12, 33153, 3153)
ID = 3153
bindtime = 99999
removetime = -1
sprpriority = 4
removeongethit = 1

[State 3005, superBG]
type = Helper
trigger1 = AnimElem = 1
name = "Super BG"
ID = 8005
stateno = 8005
postype = back
facing = 1
ownpal = 1
supermovetime = 999999
pausemovetime = 999999
ownpal = 1

[State 1000, Explod]
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

[State 3150, sfx]
type = PlaySnd
trigger1 = Time = 3
loop = 99
channel = 2
value = 10,31

[State 3150, velset]
type = VelSet
trigger1 = AnimElem = 1
x = 8

[State 3150, lines]
type = Explod
trigger1 = 1
anim = ifelse(PalNo=12, 30113, 113)
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

[State 3150, spark]
type = Explod
trigger1 = AnimElem = 2
ID = 1420
anim = 1420
bindtime = -1
facing = 1
removetime = -1
sprpriority = 2
removeongethit = 1

[State 3150, HitDef]
type = HitDef
trigger1 = Time % 4 = 0
attr = S, HA
damage = 14
guardflag = MA
pausetime = 11,11
hitsound = S2,2
guardsound = S3,0
sparkxy = 0,-100
animtype = Heavy
ground.type = High
ground.slidetime = 20
ground.hittime  = 20
ground.velocity = -4,-1
guard.velocity = -2
air.velocity = -4,-1
priority = 6,Hit

[State 3150, sparkBegone]
type = RemoveExplod
trigger1 = AnimElem = 3
ID = 1420

[State 3150, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 3155


;------------------------------
; Emerald Knight: finish
[StateDef 3155]
type    = U
movetype = I
physics = U

[State 3155, StopSnd]
type = StopSnd
trigger1 = Time = 0
channel = 2

[State 3155, RemoveExplod]
type = RemoveExplod
trigger1 = Time = 0
id = 3151

[State 3155, RemoveExplod]
type = RemoveExplod
trigger1 = Time = 0
id = 3152

[State 3155, RemoveExplod]
type = RemoveExplod
trigger1 = Time = 0
id = 3153

[State 3155, ChangeState]
type = ChangeState
trigger1 = Time = 1
value = IfElse((Pos Y < 0), 948, 0)
ctrl = 1


;---------------------------------------------------------------------------
; Knockout
[StateDef 3200]
type = S
movetype = A
physics = S
anim = 3200
ctrl = 0
velset = 0,0

[State 3200, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 3200, superpause]
type = SuperPause
trigger1 = AnimElem = 2
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

;-------------------
; DCvM hyper portrait/BG
[State 3005, superportrait]
type = Explod
trigger1 = AnimElem = 2
anim = 10000 + var(5)
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 3005, portraitBG]
type = Explod
trigger1 = AnimElem = 2
anim = 10020
ID = 10020
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -2
ownpal = 1

[State 3005, superBG]
type = Helper
trigger1 = AnimElem = 3
name = "Super BG"
ID = 8005
stateno = 8005
postype = back
facing = 1
ownpal = 1
supermovetime = 999999
pausemovetime = 999999
ownpal = 1
; end DCvM stuff
;-------------------

[State 3200, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S10,20
;volume = 0

[State 3200, Projectile]
type = Projectile
trigger1 = AnimElem = 3
ProjID = 3210
projanim = ifelse(PalNo = 12, 33210, 3210)
projhitanim = ifelse(PalNo = 12, 33215, 3215)
projremanim = ifelse(PalNo = 12, 33220, 3220)
projcancelanim = ifelse(PalNo = 12, 33220, 3220)
projscale = 1,1
projremove = 1
projremovetime = -1
velocity = 12,0
projhits = 1
offset = -50,0
postype = back
; HitDef
attr = S,HP
hitflag = MAF
guardflag = MA
animtype = back
priority = 7,Hit
damage = 120,10
pausetime = 18,18
sparkno = S9992
guard.sparkno = 0
sparkxy = 80,-80
hitsound = S10,21
guardsound = S10,21
ground.type = High
ground.slide = 16
ground.hit = 16
air.hittime = 20
ground.velocity = -13,-3
sprpriority = 1
fall = 1
fall.recover = 0
fall.damage = 10
down.bounce = 1
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 1
envshake.time = 50
envshake.freq = 80
envshake.ampl = 15
fall.envshake.time = 10
fall.envshake.freq = 40
fall.envshake.ampl = 10


[State 3200, screenBound]
type = ScreenBound
trigger1 = 1
value = 0

[State 3200, back to normal]
type = null ;ChangeState
trigger1 = AnimTime = 0
trigger2 = ProjHit = 1
value = 3250

[State 3200, 1] ; DCvM dash onscreen
type = ChangeState
triggerall = !AnimTime
trigger1 = BackEdgeBodyDist <= -1 || frontedgebodydist <= -1
value = 7100

[State 3200, ChangeState]
type = ChangeState
triggerall = !AnimTime
trigger1 = BackEdgeBodyDist >= 0 || frontedgebodydist >= 0
value = 0
ctrl = 1



;---------------------------------------------------------------------------
; Knockout (end)
[StateDef 3250]
type = S
movetype = A
physics = S
anim = 3250
ctrl = 0
velset = 0,0

[State 3250, screenBound]
type = ScreenBound
trigger1 = 1
value = 0

[State 3250, ChangeState]
type = ChangeState
triggerall = ScreenPos X = [10,310]
trigger1 = AnimElem = 2
value = 948

[State 3250, PosSet]
type = PosSet
trigger1 = AnimElem = 2
x = -160 * Facing
y = -30

[State 3250, VelAdd]
type = VelAdd
trigger1 = AnimElem = 2
x = 4.6

[State 3250, StateTypeSet]
type = StateTypeSet
trigger1 = AnimElem = 2
statetype = A
movetype = I
physics = A


;---------------------------------------------------------------------------
; Ring Slinging
[StateDef 3300]
type = S
movetype = A
physics = S
anim = 3300
ctrl = 0
velset = 0,0

[State 3300, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 3300, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 3300, superpause]
type = SuperPause
trigger1 = AnimElem = 2
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

[State 3300, superportrait]
type = Explod
trigger1 = AnimElem = 2
anim = 10000 + var(5)
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 3300, portraitBG]
type = Explod
trigger1 = AnimElem = 2
anim = 10020
ID = 10020
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -2
ownpal = 1

[State 3300, superBG]
type = Helper
trigger1 = AnimElem = 3
name = "Super BG"
ID = 8005
stateno = 8005
postype = back
facing = 1
ownpal = 1
supermovetime = 999999
pausemovetime = 999999
ownpal = 1
; end DCvM stuff
;-------------------

[State 3300, Helper]
type = Helper
trigger1 = AnimElemTime(5) = 0
trigger2 = AnimElemTime(5) = 1
trigger3 = AnimElemTime(5) = 2
trigger4 = AnimElemTime(5) = 3
trigger5 = AnimElemTime(5) = 4
trigger6 = AnimElemTime(5) = 5
helpertype = normal
name = "ringsling"
ID = 3305
stateno = 3305
size.xscale = 0.5
size.yscale = 0.5
pos = 0,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 0

[State 3300, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------------
;(adapted from FlowaGirl's Homing Projectiles tutorial)
; Ring Slinging - construct custom state for beams
[StateDef 3305]
type    = A
movetype= A
physics = N
anim = ifelse((root, PalNo = 12), 33305, 3305)
sprpriority = 6

[State 3305, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,31

[State 3305, PalNo]
type = VarSet
trigger1 = !Time
v = 10
value = parent,PalNo

[State 3305, VelSet]
type = VelSet
trigger1 = !Time
x = (Random / 50) - 10
y = (Random / 100) - 10

[State 3305, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 3305, Turn]
type = Turn
trigger1 = (P2Dist X < 10)

[State 3305, VarSet]
type = VarSet
trigger1 = IsHelper
fv = 2
value = (EnemyNear, Pos Y) + IfElse((EnemyNear, StateType != A), (EnemyNear, Const(size.mid.pos.y)), 0)

[State 3305, VelAdd]
type = VelAdd
trigger1 = (P2Dist X < 0) && (Vel X > -6)
x = -0.2

[State 3305, VelAdd]
type = VelAdd
trigger1 = (P2Dist X > 0) && (Vel X < 6)
x = 0.2

[State 3305, VelAdd]
type = VelAdd
trigger1 = (FVar(2) > Pos Y) && (Vel Y < 6)
y = 0.2 

[State 3305, VelAdd]
type = VelAdd
trigger1 = (FVar(2) < Pos Y) && (Vel Y > -6)
y = -0.2

[State 3305, VelSet]
type = VelSet
trigger1 = (FVar(2) = Pos Y)
y = 0

[State 3520, dcvm hitspark1]
type = helper
triggerall = numhelper(47000) <= hitcount
trigger1 = movehit && enemynear,time = 0
helpertype = normal
stateno = 1006
ID = 1006
name = "hitspark"
postype = p1
pos = ceil(p2dist x),ceil(p2dist y + enemynear,const(size.mid.pos.y))  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = ifelse(vel x > 0, 1,-1)
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 3305, HitDef]
type = HitDef
trigger1 = TimeMod = 4, 0
attr = A,HP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 7,Hit
damage = 16,1
;pausetime = 1,8
sparkno = -1 ;S9992
guard.sparkno = 0
hitsound = S10,13
sparkxy = 0,0
priority = 2,Hit
sprpriority = 6
ground.type = Low
ground.slidetime = 2
ground.hittime = 5
ground.velocity = -0.5
air.velocity = -1, 0.5
fall = 1
fall.recover = 0
down.bounce = 1
kill = 1
;palfx.time = 20
;palfx.add = -104,15,-104
;palfx.mul = 192,384,192
;palfx.sinadd = 0,56,0,10

[State 3305, no shadow]
type = AssertSpecial
trigger1 = Pos Y >= -1
flag = noshadow

[State 3305, AfterImageGreen]
type = AfterImage
triggerall = !Time
trigger1 = var(10) = [1,6]
time = -1
length = 60
palcolor = 85
palbright = 30,60,30
paladd = 10,50,10
palmul = .65,1.25,.65
timegap = 1

[State 3305, AfterImageRed]
type = AfterImage
triggerall = !Time
trigger1 = var(10) = 7
time = -1
length = 60
palcolor = 0
palbright = 60,30,30
paladd = 50,10,10
palmul = 1.25,.65,.65
timegap = 1

[State 3305, AfterImageOrange]
type = AfterImage
triggerall = !Time
trigger1 = var(10) = 8
time = -1
length = 60
palcolor = 0
palbright = 60,45,30
paladd = 50,30,10
palmul = 1.25,.95,.65
timegap = 1

[State 3305, AfterImageYellow]
type = AfterImage
triggerall = !Time
trigger1 = var(10) = 9
time = -1
length = 60
palcolor = 0
palbright = 60,60,30
paladd = 50,50,10
palmul = 1.25,1.25,.65
timegap = 1

[State 3305, AfterImageBlue]
type = AfterImage
triggerall = !Time
trigger1 = var(10) = 10
time = -1
length = 60
palcolor = 0
palbright = 70,70,90
paladd = 10,10,35
palmul = .65,.65,.95
timegap = 1

[State 3305, AfterImageIndigo]
type = AfterImage
triggerall = !Time
trigger1 = var(10) = 11
time = -1
length = 60
palcolor = 0
palbright = 45,45,60
paladd = 30,30,50
palmul = .85,.85,1.25
timegap = 1

[State 3305, ChangeState]
type = ChangeAnim
trigger1 = Time = 80
value = 3306

[State 3305, done]
type = DestroySelf
trigger1 = Time = 110


;---------------------------------------------------------------------------
; Ion Force (thanks, Seth. :))
[StateDef 3500]
type = U
movetype = A
physics = U
anim = 3500
ctrl = 0
velset = 0,0
facep2 = 1
sprpriority = 1

[State 3500, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1
persistent = 1

[State 3500, VarSet]
type = VarSet
trigger1 = !time
fvar(25) = 0
ignorehitpause = 1
persistent = 0

[State 3500, VarAdd]
type = VarAdd
triggerall = time >= 5
triggerall = fvar(25) <= 10
trigger1 = command = "x"
trigger2 = command = "y"
trigger3 = command = "z"
fvar(25) = 3
ignorehitpause = 1
persistent = 1

[State 3500, StateTypeSet]
type = StateTypeSet
triggerall = !time
trigger1 = pos y >= 0
statetype = S
movetype = A
physics = S

[State 3500, StateTypeSet]
type = StateTypeSet
trigger1 = statetype != S
statetype = A
movetype = A
physics = N

[State 3500, VelMul]
type = VelMul
trigger1 = statetype = A
x = 0.8
y = 0.8

[State 3500, ]
type = VarSet
trigger1 = !Time
sysvar(3) = 1

[State 3500, ]
type = VarSet
trigger1 = Time >= 10
sysvar(3) = 0

[State 3500, 1]
type = SuperPause
trigger1 = !Time
movetime = 34
time = 40
pos = -38, -100
anim = 2001
poweradd = -1000
sound = S10,1
darken = 1

[State 3500, PlaySnd] ; "plenty more..."
type = PlaySnd
trigger1 = !time
value = S10,35
channel = 0
ignorehitpause = 1
persistent = 0

[State 3500, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

;-------------------
; DCvM hyper portrait/BG
[State 3500, superportrait]
type = Explod
trigger1 = AnimElem = 1
anim = 10000 + var(5)
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 3500, portraitBG]
type = Explod
trigger1 = AnimElem = 1
anim = 10020
ID = 10020
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -2
ownpal = 1
; end DCvM stuff
;-------------------

[State 3500, Explod]
type = Explod
triggerall = statetype != A
trigger1 = !time
anim = F61
ID = 61
pos = 0,0
postype = p1
bindtime = 1
removetime = -2
supermovetime = 10
pausemovetime = 10
scale = 0.75,0.5
sprpriority = 10
ownpal = 1
removeongethit = 1
ignorehitpause = 1
persistent = 0

[State 3500, AfterImage]
type = AfterImage
trigger1 = !Time
time = 8
length = 12
framegap = 2
trans = add
ignorehitpause = 1
persistent = 1

[State 3500, AfterImageTime]
type = AfterImageTime
trigger1 = Time >= 0
time = 2
ignorehitpause = 1
persistent = 1

[State 3500, ChangeState]
type = ChangeState
trigger1 = time >= 42
value = 3505
ctrl = 0

; Ion Force - spawn helpers
[StateDef 3505]
type = U
movetype = A
physics = U
anim = 3505
ctrl = 0
velset = 0,0
sprpriority = 1

;-------------------
; DCvM hyper portrait/BG
[State 3500, superBG]
type = Helper
trigger1 = !Time
name = "Super BG"
ID = 8005
stateno = 8005
postype = back
facing = 1
ownpal = 1
supermovetime = 999999
pausemovetime = 999999
ownpal = 1
; end DCvM stuff
;-------------------

[State 3505, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1
persistent = 1

[State 3505, VarAdd]
type = VarAdd
triggerall = fvar(25) <= 10
trigger1 = command = "x"
trigger2 = command = "y"
trigger3 = command = "z"
fvar(25) = 1.5
ignorehitpause = 1
persistent = 1

[State 3505, AfterImageTime]
type = AfterImageTime
trigger1 = 1
time = 2

[State 3505, StateTypeSet]
type = StateTypeSet
triggerall = !time
trigger1 = pos y >= 0
statetype = S
movetype = A
physics = S

[State 3505, StateTypeSet]
type = StateTypeSet
trigger1 = statetype != S
statetype = A
movetype = A
physics = N

[State 3505, VelMul]
type = VelMul
trigger1 = statetype = A
x = 0.8
y = 0.8

[State 3505, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0

[State 3505, Helper]
type = Helper
trigger1 = animelem = 1
helpertype = normal
name = "Ion Blast"
stateno = 3515
ID = 3515
pos = -5,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 1
supermovetime = 2
pausemovetime = 2
ignorehitpause = 1
persistent = 1

[State 3505, sai]
type = ScreenBound
triggerall = numhelper(3515) !=0
triggerall = helper(3515),movecontact
triggerall= time >= 44
trigger1 = P2MoveType = H || (BackEdgeBodyDist < -1 || frontedgebodydist <= -1)
trigger2 = var(4) = 1
value = 0
movecamera = 0,ifelse(BackEdgeBodyDist <= -1 || frontedgebodydist <= -1,0,1)

[State 3505, 1]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 68
trigger1 = BackEdgeBodyDist > -1 && frontedgebodydist > -1
value = 3510
ctrl = 1

[State 3505, 1]
type = ChangeState
triggerall = pos y >= 0
triggerall = !animtime
trigger1 = time >= 68
trigger1 = BackEdgeBodyDist <= -1 || frontedgebodydist <= -1
value = 7100

[State 3505, ChangeState]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 68
value = 3510
ctrl = 0

; Ion Force - active
[StateDef 3510]
type = U
movetype = A
physics = U
anim = 3510
ctrl = 0
velset = 0,0
sprpriority = 1

[State 3510, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1
persistent = 1

[State 3510, Turn]
type = Turn
triggerall = animelem = 10
trigger1 = p2dist x < 0
persistent = 0

[State 3510, sai]
type = ScreenBound
trigger1 = var(4) = 1
value = 0
movecamera = 0,ifelse(BackEdgeBodyDist <= -1 || frontedgebodydist <= -1,0,1)

[State 3510, 1] ; DCvM dash onscreen
type = ChangeState
triggerall = var(4) = 1
trigger1 = BackEdgeBodyDist <= -1 || frontedgebodydist <= -1
value = 7100

[State 3510, ChangeState]
type = ChangeState
triggerall = statetype = A
trigger1 = BackEdgeBodyDist >= 0 || frontedgebodydist >= 0
trigger1 = animelem = 10
value = 50
ctrl = 0

[State 3510, ChangeState]
type = ChangeState
trigger1 = BackEdgeBodyDist >= 0 || frontedgebodydist >= 0
trigger1 = !animtime
value = 0
ctrl = 1

; Ion Force - construct helper
[StateDef 3515]
type = S
movetype = A
physics = S
anim = ifelse((root, PalNo = 12), 33515, 3515)
ctrl = 0
velset = 0,0
sprpriority = 4

[State 3515, PosSet]
type = PosSet
trigger1 = 1
y = 0
x = root,pos x
ignorehitpause = 1
persistent = 1

[State 3515, ParentVarSet]
type = ParentVarSet
trigger1 = movehit
trigger2 = var(4) != 0
var(4) = 1
ignorehitpause = 1
persistent = 0

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

[State 3515, HitDef]
type = HitDef
triggerall = ifelse (time<60,(time%9) = 0, (time%5) = 0)
trigger1 = time = [0,16]
trigger2 = time = [28,38]
trigger3 = time = [40,50]
trigger4 = time > 61
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 6,Hit
damage = 16,2
pausetime = 4,2
guard.pausetime = 2,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S2,11
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 61,-16,5),ifelse(time > 61,-18,0)
air.velocity  = ifelse(time > 61,-16,5),ifelse(time > 61,-18,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
;p2facing = 1
yaccel = 0.7
fall = ifelse(time > 61,1,0)
air.fall = ifelse(time > 61,1,0)
fall.recover = 0
fall.recovertime = 20

[State 3515, HitDef]
type = HitDef
triggerall = ifelse (time<60,(time%9) = 0, (time%5) = 0)
trigger1 = time = [17,27]
trigger2 = time = [29,39]
trigger3 = time = [51,61]
trigger4 = time > 61
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 6,Hit
damage = 16,2
pausetime = 4,2
guard.pausetime = 2,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S2,11
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 61,-16,-5),ifelse(time > 61,-18,0)
air.velocity  = ifelse(time > 61,-16,-5),ifelse(time > 61,-18,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
yaccel = 0.7
fall = ifelse(time > 61,1,0)
air.fall = ifelse(time > 61,1,0)
fall.recover = 0
fall.recovertime = 20

[State 3515, Helper]
type = Helper
trigger1 = animelem = 1
helpertype = normal
name = "Ion Blast"
stateno = 3520
ID = 3515
pos = ceil(-60-root,fvar(25)),0
postype = p1
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = 0.5
size.yscale = 0.75
supermovetime = 2
pausemovetime = 2
ignorehitpause = 1
persistent = 1

[State 3515, Helper]
type = Helper
trigger1 = animelem = 1
helpertype = normal
name = "Ion Blast"
stateno = 3520
ID = 3515
pos = ceil(60+root,fvar(25)),0
postype = p1
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = 0.5
size.yscale = 0.75
supermovetime = 2
pausemovetime = 2
ignorehitpause = 1
persistent = 1

[State 3515, ChangeState]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 64
trigger2 = root,stateno != 3505
value = 3516
ctrl = 0

; Ion Force - construct end
[StateDef 3516]
type = S
movetype = A
physics = S
anim = ifelse((root, PalNo = 12), 33516, 3516)
ctrl = 0
velset = 0,0
sprpriority = 6

[State 3516, PosSet]
type = PosSet
trigger1 = 1
y = 0
ignorehitpause = 1
persistent = 1

[State 3516, AngleDraw]
type = AngleDraw
trigger1 = time >= 1
scale = 1,1+(0.1*time)

[State 3516, Trans]
type = Trans
trigger1 = root, PalNo != 12
trans = add

[State 3516, Trans]
type = Trans
trigger1 = root, PalNo = 12
trans = sub

[State 3516, DestroySelf]
type = DestroySelf
trigger1 = !animtime
ignorehitpause = 1
persistent = 1

; Ion Force - side construct beams
[StateDef 3520]
type = S
movetype = A
physics = N
anim = ifelse((root, PalNo = 12), 33520, 3520)
ctrl = 0
velset = 0,0
sprpriority = 6

[State 3520, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,11
ignorehitpause = 1
persistent = 0

[State 3520, PosSet]
type = PosSet
trigger1 = 1
y = 0
ignorehitpause = 1
persistent = 1

[State 3520, SprPriority]
type = SprPriority
trigger1 = 1
value = floor(vel x)

[State 3520, ParentVarSet]
type = ParentVarSet
trigger1 = movehit
var(4) = 1
ignorehitpause = 1
persistent = 0

[State 3520, VelMul]
type = VelMul
trigger1 = vel x != 0 && root,fvar(25)!=0
x = 1+(root,fvar(25)/10)
ignorehitpause = 1
persistent = 0

[State 3520, ]
type = veladd
triggerall = parentdist X < ceil(40+root,fvar(25))
trigger1 = vel X > ceil(-10-root,fvar(25))
x = -0.5

[State 3520, ]
type = veladd
triggerall = parentdist X >= ceil(-40-root,fvar(25))
trigger1 = vel X < ceil(10+root,fvar(25))
x = 0.5

[State 3520, dcvm hitspark1]
type = helper
triggerall = numhelper(47000) <= hitcount
trigger1 = movehit && enemynear,time = 0
helpertype = normal
stateno = 1006
ID = 1006
name = "hitspark"
postype = p1
pos = ceil(p2dist x),ceil(p2dist y + enemynear,const(size.mid.pos.y))  ;;; put the x,y offset relative to P1 hit box colision "where the move hits"
facing = ifelse(vel x > 0, 1,-1)
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
persistent=1
ownpal = 1

[State 3520, HitDef]
type = HitDef
triggerall = parentdist x < 0
trigger1 = ifelse (time<60,(time%9) = 0, (time%9) = 0)
trigger2 = time > 61
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 6,Hit
damage = 8,2
pausetime = 0,0
guard.pausetime = 0,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S2,11
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 61,-16,8),ifelse(time > 61,-18,0)
air.velocity  = ifelse(time > 61,-16,8),ifelse(time > 61,-18,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
;p2facing = 1
yaccel = 0.7
fall = ifelse(time > 61,1,0)
air.fall = ifelse(time > 61,1,0)
fall.recover = 0
fall.recovertime = 20

[State 3520, HitDef]
type = HitDef
triggerall = parentdist x > 0
trigger1 = ifelse (time<60,(time%9) = 0, (time%9) = 0)
trigger2 = time > 61
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 6,Hit
damage = 16,2
pausetime = 0,0
guard.pausetime = 0,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S2,11
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 61,-16,-8),ifelse(time > 61,-18,0)
air.velocity  = ifelse(time > 61,-16,-8),ifelse(time > 61,-18,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
yaccel = 0.7
fall = ifelse(time > 61,1,0)
air.fall = ifelse(time > 61,1,0)
fall.recover = 0
fall.recovertime = 20

[State 3520, ChangeState]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 64
trigger2 = root,stateno != 3505
value = 3516
ctrl = 0


;---------------------------------------------------------------------------
; Smackdown
[StateDef 4200]
type = S
movetype = A
physics = S
anim = 4200
ctrl = 0
velset = 0,0

[State 4200, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 4200, superpause]
type = SuperPause
trigger1 = AnimElem = 2
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

;-------------------
; DCvM hyper portrait/BG
[State 4200, superportrait]
type = Explod
trigger1 = AnimElem = 1
anim = 10000 + var(5)
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 4200, portraitBG]
type = Explod
trigger1 = AnimElem = 1
anim = 10020
ID = 10020
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -2
ownpal = 1

[State 4200, superBG]
type = Helper
trigger1 = AnimElem = 2
name = "Super BG"
ID = 8005
stateno = 8005
postype = back
facing = 1
ownpal = 1
supermovetime = 999999
pausemovetime = 999999
ownpal = 1
; end DCvM stuff
;-------------------

[State 4200, Helper]
type = Helper
trigger1 = AnimElem = 2
name = "glove"
ID = 4210
stateno = 4210
supermove

[State 4200, back to normal]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Smackdown (glove construct)
[StateDef 4210]
type = S
movetype = A
physics = S
anim = ifelse((root, PalNo = 12), 34210, 4210)

[State 4210, HitDef1]
type = HitDef
trigger1 = AnimElem = 6
attr = S,SP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 6,Hit
damage = 135,15
pausetime = 0,9
;guard.pause,0
sparkno = S9992
;guard.sparkno = 0
;sparkxy = 0,0
hitsound = S10,21
guardsound = S3,0
ground.type = Low
ground.slide = 0
ground.hit = 0
ground.velocity = 0,0
sprpriority = 2
fall = 1
fall.recover = 0
down.bounce = 1
envshake.time = 50
envshake.freq = 80
envshake.ampl = 15

[State 4210, HitDef2]
type = HitDef
trigger1 = AnimElem = 11
attr = S,SP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 6,Hit
damage = 95,15
pausetime = 0,9
;guard.pause,0
sparkno = S9992
;guard.sparkno = 0
;sparkxy = 0,0
hitsound = S10,21
guardsound = S3,0
ground.type = High
ground.slide = 0
ground.hit = 0
ground.velocity = 0,-13
air.velocity = 0,-15
sprpriority = 2
fall = 1
fall.recover = 0

[State 4210, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
trigger2 = parent, StateNo != 4200
value = 4220


;---------------------------------------------------------------------------
; Smackdown (glove construct timeout)
[StateDef 4220]
type = S
movetype = I
physics = S
anim = ifelse((root, PalNo = 12), 34220, 4220)

[State 4220, DestroySelf]
type = DestroySelf
trigger1 = !AnimTime


;WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
; WINKO screen
;WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
[Statedef 12000]
type = S
movetype = I
physics = N
anim = 8787
sprpriority = -20

;Generated by Fighter Factory PalFX Editor
[State 0, PalFXWiz]
type = PalFX
trigger1 = 1
time = 10
add = 0,160,0
mul = 24,132,24
sinadd = 32,116,32,10
invertall = 0
color = 256

[state 12000, a1]
type = assertspecial
trigger1 = 1
flag = NoBarDisplay
flag2 = Noshadow

[state 12000, a1]
type = assertspecial
triggerall = numexplod(12005)
trigger1 = 1
flag = NoBG
flag2 = NoFG

[State 12000, a9] ;bgscreen
type = Explod
trigger1 = !time
anim = 11000
id = 12005
pos = 0,0
postype = back
;facing = 1
bindtime = -1
supermovetime = 9999
pausemovetime = 9999
sprpriority = -16
scale = 1,1
removeongethit = 1
IgnoreHitPause = 1
;ownpal=1

[State 12000, a4]
type = Explod
trigger1 = !time
anim = 12000
id = 12010
pos = 0,0
postype = back
;facing = 1
bindtime = -1
supermovetime =999
pausemovetime =999
sprpriority = -15;-15
removetime = -2
scale = 1,1
removeongethit = 1
IgnoreHitPause = 1

[State 12000, a6]
type = destroyself
trigger1 = time >= 300


