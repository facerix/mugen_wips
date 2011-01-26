; States file for Hal Jordan -- Custom Modes
;
;-[Red Lantern Mode (pal-07)]-----------------------------------------------
; Winpose: 17180
; Intro:   17190
; Special Attacks:
;   Plasma Vomit (QCF + P) -- 17700-17710
;   Jet Rush (QCF + K) -- 17800
;
; Hyper Attacks:
;   Flames of Rage (QCB + PK) -- 17900-17921
;
;-[Orange Lantern Mode (pal-08)]--------------------------------------------
; Winpose: 18180
; Intro: 18190
; Special Attacks
;   Selfish Grab (QCB + K) -- 18700-18716
;   Go Away! (QCF + P in the air) -- 18800-18810
;
; Hyper Attacks:
;   Construct Corps (QCB + PK) -- 18900-?
;
;-[Yellow Lantern Mode (pal-09)]--------------------------------------------
; Winpose: 19180
; Intro: 19190
; Special Attacks:
;   Sinister Spike (QCB + P) -- 19700
;   Cruel Grip (QCB + K) -- 19800-?
;
; Hyper Attacks:
;   Parallax Lives! (QCF + PP) -- 19900-?
;
;-[Blue/Green Lantern Mode (pal-10)]----------------------------------------
; Winpose: 20180
; Intro: 20190
; Special Attacks:
;   Ring Blast (QCF + P) -- 20700-20710
;   Massive Discharge (QCF + P in the air) -- 20800-?
;
; Hyper Attacks:
;   Ion Wave (QCB + PP) -- 20900-?
;
;-[Indigo Lantern Mode (pal-11)]--------------------------------------------
; Winpose: 21180
; Intro: 21190
; Special Attacks:
;   Teleport (QCF + K) -- 21700
;   Nek Ler Klok (Energy Redirect) (QCB + K) -- 21800-21830
;
; Hyper Attacks:
;   Enforced Empathy (QCF + KK) -- 21900-21940
;
;-[Black Lantern Mode (pal-12)]---------------------------------------------
; Winpose: 22180
; Intro: 22190
; Special Attacks:
;   Piercing Strike (QCF + P) -- 22700-22710
;   Deadly Embrace (QCB + P) -- 22800-22811
;
; Hyper Attacks:
;   Nekron Rising (QCB + KK) -- 22900-?
;
;---------------------------------------------------------------------------


;====================RED LANTERN====================

;-----------------------
; [Red Lantern] Custom Winpose
[Statedef 17180]
type = S
ctrl = 0
anim = 17180
velset = 0,0

[State 17180,0]
type = PlaySnd
trigger1 = AnimElem = 4
value = 11,0

[State 17180,1]
type = AssertSpecial
trigger1 = Time = [0,80]
flag = RoundNotOver


;-----------------------
; [Red Lantern] Custom Intro
[Statedef 17190]
type = S
ctrl = 0
anim = 17190
velset = 0,0

[State 17190, no_evil]
type = PlaySnd
trigger1 = !Time
value = 5,70
channel = 0

[State 17190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S9,31

[State 17190, ring trail]
type = Explod
trigger1 = Time = 50
anim = 17191
ID = 17191
sprpriority = 2
ontop = 1

[State 17190, light flash]
type = EnvColor
trigger1 = AnimElem = 2
value = 255,0,0
time = 2

[State 17190, ring speech bubble]
type = Explod
trigger1 = AnimElem = 2
anim = 960
ID = 960
pos = -50,-120
facing = 1
bindtime = 1
removetime = -2
sprpriority = 1
ontop = 1
shadow = 0,0,0
ownpal = 0
removeongethit = 0

[State 17190, ring speech text]
type = Explod
trigger1 = AnimElem = 2
anim = 17192
ID = 17192
pos = -50,-120
facing = facing
bindtime = 1
removetime = -2
sprpriority = 2
ontop = 1
shadow = 0,0,0
ownpal = 0
removeongethit = 0

[State 17190, particle sparks]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
facing = -1
pos = 0,-80

[State 17190, particle sparks 2]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
pos = 0,-80

[State 17190, scream]
type = PlaySnd
trigger1 = AnimElemTime(2) = 4
value = 11,0
channel = 0

[State 17190, blood]
type = PlaySnd
trigger1 = AnimElem = 4
value = 9,72

[State 17190, Explod]
type = Explod
trigger1 = AnimElem = 4
anim = 17195
ID = 17195
pos = -37,-90
postype = p1
facing = 1
vfacing = 1
bindtime = 60
sprpriority = 1
ownpalette = 1

[State 17190, 2]             
type = AssertSpecial
trigger1 = Time = [0,100]
flag = Intro

[State 17190, 3]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 0


;---------------------------------------------------------------------------
; [Red Lantern] Plasma Vomit special (alternate Ring Strike)
[StateDef 17700]
type = S
movetype = A
physics = S
ctrl = 0
anim = 17700

[State 17700, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -125

[State 17700, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S1,10
volume = 0
channel = 0
freqmul = 1.0
loop = 0
pan = 0

[State 17700, VarSet]
type = VarSet
trigger1 = !Time
v = 2
value = IfElse(command = "qcf_x", 0, IfElse(command = "qcf_y", 1, 2))

[State 17700, ChangeAnim]
type = ChangeAnim
trigger1 = Time = 1
value = Anim + var(2)

[State 17700, SprPriority]
type = SprPriority
trigger1 = var(2) = 1
value = 3

[State 17700, blood stream]
type = Helper
triggerall = NumHelper(17710) = 0
trigger1 = AnimElem = 2 && var(2) = 0
trigger2 = AnimElem = 4 && var(2) = 1
trigger3 = AnimElem = 2 && var(2) = 2
helpertype = normal
name = "blood"
ID = 17710
pos = 0,0
postype = p1
stateno = 17710
ownpal = 1

[State 17700, changestate]
type = ChangeState
trigger1 = AnimTime = 0 & NumHelper(9710) = 0
value = 0
ctrl = 1

;--------
; Plasma Vomit -- helper state
[StateDef 17710]
type = A
movetype = A
physics = C
anim = 17705+root,var(2)
ctrl = 0
sprpriority = 2

[State 17710, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,72
volume = 0

[State 17710, PosSet]
type = BindToParent
trigger1 = 1
time = 2
pos = 0,0

[State 17710, noreversal]
type = NotHitBy
trigger1 = 1
time = 1
value = SCA, NA, SA, HA, NT, ST, HT
ignorehitpause = 1

[State 17710, noreversal2]
type = NotHitBy
trigger1 = 1
time = 1
value = SCA, NP, SP, HP
ignorehitpause = 1

[State 17710, hitdef1]
type = HitDef
triggerall = root, var(2) != 1
trigger1 = AnimElem = 3
trigger2 = AnimElem = 4
trigger3 = AnimElem = 5
trigger4 = AnimElem = 6
trigger5 = AnimElem = 7
trigger6 = AnimElem = 8
trigger7 = AnimElem = 9
trigger8 = AnimElem = 10
trigger9 = AnimElem = 11
trigger10 = AnimElem = 12
attr = S,SP
hitflag = MAF
guardflag = MA
animtype = Heavy
damage = 18,3
pausetime = 0,12
hitsound = S9,73
guardsound = S3,0
sparkxy = 0,-100
sparkno = S9992
animtype = Heavy
ground.type = High
ground.slidetime = 10
ground.hittime  = 20
ground.velocity = -8
guard.velocity = -5
air.velocity = -4,8
palfx.time = 25
palfx.add = 64,0,0

[State 17710, hitdef2]
type = HitDef
triggerall = root, var(2) = 1
trigger1 = AnimElem = 1
trigger2 = AnimElem = 2
trigger3 = AnimElem = 3
trigger4 = AnimElem = 4
trigger5 = AnimElem = 5
trigger6 = AnimElem = 6
attr = A,SP
hitflag = MAF
guardflag = MA
animtype = Heavy
damage = 19,4
pausetime = 0,2
hitsound = S9,73
guardsound = S3,0
sparkno = S9992
sparkxy = -35,-130
;snap = HitCount * 2, HitCount * -1
animtype = DiagUp
ground.type = High
ground.slidetime = 2
ground.hittime = 5
ground.velocity = -5,-4
guard.velocity = -3
air.velocity = -4,-7
palfx.time = 25
palfx.add = 64,0,0

[State 17710, TargetBind]
type = null ;TargetBind
trigger1 = root, var(2) = 1 && HitCount = 1
time = 1
pos = 20,-10


[State 17710, DestroySelf]
type = DestroySelf
trigger1 = !AnimTime


;------------------------------
; [Red Lantern] Jet Rush special (alternate to Battering Ram)
[StateDef 17800]
type    = A
movetype = A
physics = N
ctrl = 0
anim = 17800

[State 17800, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -150

; air or ground version?
[State 17800, VarSet]
type = VarSet
trigger1 = !Time
v = 3
value = IfElse(Pos Y > -10, 0, 1)

[State 17800, noGravity in air]
type = VelSet
trigger1 = var(3) = 1
y = 0

[State 17800, dust Explod]
type = Explod
triggerall = var(3) = 0
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

[State 17800, voice]
type = PlaySnd
trigger1 = !Time
value = 9,70

[State 17800, sfx]
type = PlaySnd
trigger1 = !Time
value = 9,71

[State 17800, velset]
type = VelSet
trigger1 = !Time
x = -15
y = -3

[State 17800, 3] ;Gravity
type = VelAdd
trigger1 = AnimElemTime(5) < 0
y = GetHitVar(yaccel)

[State 17800, PosSet]
type = PosSet
triggerall = var(3) = 0
trigger1 = AnimElem = 5
y = -10

[State 17800, velset]
type = VelSet
trigger1 = AnimElem = 5
x = 12
y = 0

[State 17800, ScreenBound]
type = ScreenBound
trigger1 = var(3) = 0 ;AnimElemTime(5) < 0
value = 0
movecamera = 0,0

[State 17800, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0

[State 17800, lines]
type = Explod
trigger1 = AnimElemTime(5) >= 0
anim = 113
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

[State 17800, spark]
type = Explod
trigger1 = AnimElem = 5
ID = 17810
anim = 17810
bindtime = -1
facing = 1
removetime = -1
sprpriority = 2
removeongethit = 1

[State 17800, HitDef]
type = HitDef
trigger1 = Time % 4 = 0
attr = S, SA
damage = 14
guardflag = MA
pausetime = 0,8
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

[State 17800, sparkBegone]
type = RemoveExplod
trigger1 = AnimElem = 6
ID = 17810

[State 17800, ChangeState]
type = ChangeState
trigger1 = !AnimTime
trigger2 = P2Dist X < -100
trigger3 = Time > 100
value = 948
ctrl = 1


;---------------------------------------------------------------------------
; [Red Lantern] Flames of Rage hyper (replaces Soldier of Oa)
[StateDef 17900]
type = S
movetype = A
physics = S
anim = 17900
ctrl = 0
velset = 0,0

[State 17900, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

[State 17900, vox]
type = PlaySnd
trigger1 = AnimElem = 1
value = S5,71
channel = 0

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 17900, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 17900, superpause]
type = SuperPause
trigger1 = AnimElem = 3
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

[State 17900, superportrait]
type = Explod
trigger1 = AnimElem = 3
anim = 10001
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 17900, portraitBG]
type = Explod
trigger1 = AnimElem = 3
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

[State 17900, superBG]
type = Helper
trigger1 = AnimElem = 4
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

[State 17900, Helper]
type = Helper
trigger1 = AnimElem = 4
name = "flames"
ID = 17920
stateno = 17920
supermove

[State 17900, Helper]
type = Helper
trigger1 = AnimElem = 4
name = "flames"
ID = 17921
stateno = 17921
supermove

[State 17900, ChangeState]
type = ChangeState
trigger1 = !AnimTime && NumHelper(17920) = 0
value = 17910
ctrl = 0


;---------
; Flames of Rage - end
[StateDef 17910]
type = S
movetype = A
physics = S
anim = 17910

[State 17910, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------------
; Flames of Rage - flames construct state
[StateDef 17920]
type    = A
movetype= A
physics = N
anim = 17920
sprpriority = 6

[State 17920, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,73

[State 17920, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 17920, HitDef]
type = HitDef
trigger1 = TimeMod = 4, 0
attr = A,HP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 7,Hit
damage = 30,6
sparkno = S9992
guard.sparkno = 0
hitsound = S10,71
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
palfx.time = 20
palfx.add = 240,50,0
palfx.mul = 250,224,120
palfx.sinadd = 110,55,85,10

[State 17920, no shadow]
type = AssertSpecial
trigger1 = Pos Y >= -1
flag = noshadow

[State 17920, done]
type = DestroySelf
trigger1 = !AnimTime


;-----------------
; Flames of Rage - flames construct state 2
[StateDef 17921]
type    = A
movetype= A
physics = N
anim = 17921
sprpriority = 6

[State 17921, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,73

[State 17921, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 17921, HitDef]
type = HitDef
trigger1 = TimeMod = 4, 1
attr = A,HP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 7,Hit
damage = 30,6
sparkno = S9992
guard.sparkno = 0
hitsound = S10,71
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
palfx.time = 20
palfx.add = 240,50,0
palfx.mul = 250,224,120
palfx.sinadd = 110,55,85,10

[State 17921, no shadow]
type = AssertSpecial
trigger1 = Pos Y >= -1
flag = noshadow

[State 17921, done]
type = DestroySelf
trigger1 = !AnimTime


;====================ORANGE LANTERN====================

;-----------------------
; [Orange Lantern] Custom Winpose
[Statedef 18180]
type = S
ctrl = 0
anim = 18180
velset = 0,0

[State 18180, PlaySnd]
type = PlaySnd
trigger1 = Time = 16
value = S9,2

[State 18180, spark1]
type = Explod
trigger1 = Time = 16
anim = 935
ID = 935
pos = -40,-86
postype = p1
removetime = 44
sprpriority = 4

[State 18180, spark2]
type = Explod
trigger1 = AnimElem = 3
anim = 936
ID = 936
pos = 69,-102
postype = p1
removetime = -1
sprpriority = 0

[State 18180, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S6,80
volumn = 150
channel = 0

[State 18180,1]
type = AssertSpecial
trigger1 = Time = [0,160]
flag = RoundNotOver


;-----------------------
; [Orange Lantern] Custom Intro
[Statedef 18190]
type = S
ctrl = 0
anim = 18190
velset = 0,0

[State 18190, PlaySnd]
type = PlaySnd
trigger1 = Time = 6
value = S5,80
volumn = 150
channel = 0

[State 18190, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,73

[State 18190, glow spark]
type = Explod
trigger1 = !Time
anim = 1911
ID = 1910
pos = 30,-80
scale = 1,1
postype = p1
facing = -1
vfacing = 1
bindtime = 1
removetime = 122
scale = 1.25,0.75
sprpriority = 2

[State 18190, Explod]
type = Explod
trigger1 = !Time
anim = 18191
ID = 18191
sprpriority = 2
ontop = 1
ownpal = 1

[State 18190, particle sparks]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
facing = -1
pos = 30,-80

[State 18190, particle sparks 2]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
pos = 30,-80

[State 18190, RemoveExplod]
type = RemoveExplod
trigger1 = AnimElem = 2
id = 1910

[State 18190, light flash]
type = EnvColor
trigger1 = AnimElem = 2
value = 255,192,48
time = 2

[State 18190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S9,31

[State 18190, delay]             
type = AssertSpecial
trigger1 = Time = [0,100]
flag = Intro

[State 18190, to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 0


;---------------------------------------------------------------------------
; [Orange Lantern] Selfish Grab special (replaces Plasma Sphere)
[StateDef 18700]
type = S
movetype = A
physics = S
anim = 2300
ctrl = 0

[State 18700, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -100

[State 18700, VarSet]
type = VarSet
trigger1 = !Time
v = 2
value = IfElse(command = "qcb_a", 0, IfElse(command = "qcb_b", 1, 2))

[State 18700, Helper]
type = Helper
trigger1 = AnimElem = 4
helpertype = normal
name = "Plasma Sphere"
ID = 18710
stateno = 18710
pos = 120 + 40*var(2),-100
size.xscale = 0.3
size.yscale = 0.6
postype = p1
facing = 1

[State 18700, Explod]
type = Explod
trigger1 = AnimElem = 4
anim = 936
pos = 47,-107
ID = 936
bindtime = 24
removetime = 24
sprpriority = 3

[State 18700, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 2350

; Selfish Grab - construct
[StateDef 18710]
type = S
movetype = A
physics = S
anim = 2310
ctrl = 0

[State 18710, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,31

[State 18710, HitDef]
type = HitDef
trigger1 = IsHelper
attr = S,ST
hitflag = MAF
guardflag = MA
animtype = hard
priority = 5,Hit
damage = 80,25
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
p1stateno = 18715
p2stateno = 18716
kill = 1
guard.kill = 1
numhits = 1

[State 18710, DestroySelf]
type = DestroySelf
trigger1 = !AnimTime


; Selfish Grab - P1 throw action
[StateDef 18715]
anim = 2320
ctrl = 0
type = A
movetype = A
physics = N
velset = -1.6,0

[State 18715, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S10,2
volume = 0
channel = 0
freqmul = 1.0
loop = 0
pan = 0

[State 18715, 0]
type = PlaySnd
trigger1 = !Time
persistent = 0
value = S9,32

[State 18715, Bind 1]
type = TargetBind
trigger1 = AnimElem = 1
pos = 0,0

[State 18715, targetdrop]
type = TargetDrop
trigger1 = AnimTime = -1

[State 18715, turn]
type = Turn
trigger1 = AnimTime = -1

[State 18715, destroySelf]
type = DestroySelf
trigger1 = !AnimTime


;-------------------------------------------
; Selfish Grab - P2 being grabbed (custom hit state)
[StateDef 18716]
type = A
movetype = H
physics = N
ctrl = 0
velset = 1.6,0

;Generated by Fighter Factory PalFX Editor
[State 18716, PalFXWiz]
type = PalFX
trigger1 = 1
time = 1
add = 0,128,0
mul = 256,256,256
sinadd = 64,32,0,32
invertall = 0
color = 256

[State 18716, ChangeAnim2]
type = ChangeAnim2
Trigger1 = !Time
value = 2330

; drained
[State 18716, LifeAdd]
type = LifeAdd
trigger1 = Time % 2
value = -2
kill = 1
absolute = 1

[State 18716, screenbound]  ; don't move the camera to follow P2
type = ScreenBound
trigger1 = Alive
movecamera = 0,0

[State 18716, 2] ;dropped
type = SelfState
trigger1 = !AnimTime
value = 5050


;-----------------------
; [Orange Lantern] "Go Away!" special (replaces Emerald Swordsman)
[Statedef 18800]
type = A
movetype = A
physics = A
anim = 18800
ctrl = 0

[State 18800, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -125

[State 18800, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,80
channel = 0

[State 18880, VarSet]
type = VarSet
trigger1 = !Time
v = 2
value = IfElse(command = "qcf_x", 0, IfElse(command = "qcf_y", 1, 2))

[State 18800, noGravity]
type = VelSet
trigger1 = TimeMod = 2,1
y = 0

[State 18810, Helper]
type = Helper
trigger1 = AnimElem = 3
name = "blast wave"
ID = 18810
stateno = 18810 ;+ var(2)
pos = 65,-70
facing = 1
persistent = 0

[State 18800, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1

;---------
; Go Away! - construct custom state for blast wave
[StateDef 18810]
type    = A
movetype= A
physics = N
anim = 18810
sprpriority = 4

[State 18810, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,31

[State 18810, VelSet]
type = VelSet
trigger1 = !Time
x = 12 ;(Random / 50)
y = 12 ;(Random / 50)

[State 18810, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 18810, HitDef]
type = HitDef
trigger1 = TimeMod = 3, 0
attr = A,HP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 7,Hit
damage = 16,1
;pausetime = 1,8
sparkno = S9992
guard.sparkno = 0
hitsound = S10,13
sparkxy = 0,0
priority = 2,Hit
sprpriority = 6
ground.type = Low
ground.slidetime = 18
ground.hittime = 12
ground.velocity = -6.5
air.velocity = -7, 3.8
fall = 1
fall.recover = 0
down.bounce = 1
kill = 1
palfx.time = 20
palfx.add = 32,15,-104
palfx.mul = 384,192,32
palfx.sinadd = 56,24,0,10

[State 18810, no shadow]
type = AssertSpecial
trigger1 = 1
flag = noshadow

[State 18810, done]
type = DestroySelf
trigger1 = Time = 110


;-----------------------
; [Orange Lantern] Construct Corps hyper (replaces Soldier of Oa)
[Statedef 18900]
type = S
movetype = A
physics = S
anim = 18900
ctrl = 0
velset = 0,0

[State 18900, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

[State 18900, vox]
type = PlaySnd
trigger1 = AnimElem = 1
value = S10,80
channel = 0

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 18900, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 18900, superpause]
type = SuperPause
trigger1 = AnimElem = 3
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

[State 18900, superportrait]
type = Explod
trigger1 = AnimElem = 3
anim = 10002
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 18900, portraitBG]
type = Explod
trigger1 = AnimElem = 3
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

[State 18900, superBG]
type = Helper
trigger1 = AnimElem = 4
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

[State 18900, Helper]
type = Helper
trigger1 = AnimElem = 4
name = "kilowog"
ID = 18910
stateno = 18910
pos = Pos X, Pos Y - 240
supermove

[State 18900, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 18940
ctrl = 0


;---------
; Construct Corps - end
[StateDef 18940]
type = S
movetype = A
physics = S
anim = 17910

[State 18940, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


; Construct Corps - Kilowog enter
[StateDef 18910]
type    = A
movetype= A
physics = N
anim = 18910
sprpriority = 1

[State 18910, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 18910, VelAdd]
type = VelAdd
trigger1 = 1
y = 2.2

[State 18910, VarSet]
type = VarSet
trigger1 = !Time
v = 59
value = 1

[State 18910, no shadow]
type = AssertSpecial
trigger1 = Pos Y >= -1
flag = noshadow

[State 18910, attack!]
type = ChangeState
trigger1 = Pos Y >= 0
value = 0
ctrl = 1


;====================YELLOW LANTERN====================

;-----------------------
; [Yellow Lantern] Custom Winpose
[Statedef 19180]
type = S
ctrl = 0
anim = 19180
velset = 0,0

[State 19180, PlaySnd]
type = PlaySnd
trigger1 = AnimELem = 3
value = S6,90
;volume = 0
channel = 0

[State 19180, delay]
type = AssertSpecial
trigger1 = Time = [0,80]
flag = RoundNotOver


;-----------------------
; [Yellow Lantern] Custom Intro
[Statedef 19190]
type = S
ctrl = 0
anim = 19190
velset = 0,0

; Parallax-as-Hal voice: "Show me what ya got..."
[State 19190, 0]
type = PlaySnd
trigger1 = !Time
value = S5,100
channel = 0

[State 19190, Parallax head]
type = Explod
trigger1 = !Time
anim = 19195
ID = 19195
removetime = -2
sprpriority = 3
ontop = 1
ownpal = 1

[State 19190, ring spark]
type = Explod
trigger1 = !Time
anim = 935
ID = 935
pos = -25,-55
postype = p1
removetime = 90
sprpriority = 4

[State 19190, light flash]
type = EnvColor
trigger1 = AnimElem = 2
value = 192,192,0
time = 2

[State 19190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S9,31

[State 19190, Explod]
type = Explod
trigger1 = AnimElem = 2
anim = 950
ID = 950
pos = 15,-90
removetime = -2
sprpriority = 2
ontop = 1

[State 19190, delay]
type = AssertSpecial
trigger1 = Time = [0,100]
flag = Intro

[State 19190, to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 0


;-----------------------
; [Yellow Lantern] Sinister Sabres special (replaces Buzzcut)
[Statedef 19700]
type = S
movetype = A
physics = S
anim = 19700
ctrl = 0
velset = 0,0

[State 19700, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -75

; voice
[State 19700, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 1
value = S1,3
channel = 0

; woosh
[State 19700, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 4
value = S0,2

; sfx
[State 19700, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 5
value = S9,40

[State 19700, spear]
type = Projectile
trigger1 = AnimElem = 4
trigger2 = AnimElemTime(4) = 5
trigger3 = AnimElemTime(4) = 10
ProjID = 19710
projanim = 19710
projhitanim = 19711
projremanim = 19711
projcancelanim = 19711
velocity = 0,-7
offset = 10 + (Time*5),0
; HitDef
attr = A,SP
hitflag = MAFD
guardflag = MA
animtype = DiagUp
priority = 3,Miss
damage = 30,5
pausetime = 7,7
sparkno = S950 ;S9992
guard.sparkno = 0
hitsound = S2,2
guardsound = S3,0
ground.type = High
ground.slidetime = 8
ground.hittime  = 8
ground.velocity = -1,-13
air.velocity = -1,-15
fall = 1

[State 19700, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------------------
; [Yellow Lantern] Cruel Grip special (replaces Plasma Sphere)
;[Statedef 19800]
; power requirement: 100

;-----------------------
; [Yellow Lantern] Golden Dragons hyper (replaces KO/Smackdown)
[Statedef 19900]
type = S
movetype = A
physics = S
anim = 19900
ctrl = 0
velset = 0,0

[State 19900, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

[State 19900, vox]
type = PlaySnd
trigger1 = AnimElem = 4
value = S9,72

[State 19900, vox]
type = PlaySnd
trigger1 = AnimElem = 5
value = S10,90
channel = 0

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 19900, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 19900, superpause]
type = SuperPause
trigger1 = AnimElem = 4
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

[State 19900, superportrait]
type = Explod
trigger1 = AnimElem = 4
anim = 10003
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 19900, portraitBG]
type = Explod
trigger1 = AnimElem = 4
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

[State 19900, superBG]
type = Helper
trigger1 = AnimElem = 5
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

[State 19900, Helper]
type = Helper
trigger1 = AnimElem = 6
name = "dragon1"
ID = 19910
stateno = 19910
ownpal = 1
supermove = 1

[State 19900, Helper]
type = Helper
trigger1 = AnimElem = 8
name = "dragon2"
ID = 19911
stateno = 19911
ownpal = 1
supermove = 1

[State 19900, Helper]
type = Helper
trigger1 = AnimElem = 10
name = "dragon3"
ID = 19912
stateno = 19912
ownpal = 1
supermove = 1

[State 19900, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


; Golden Dragons - construct #1
[Statedef 19910]
type = S
movetype = A
physics = S
anim = 19910
ctrl = 0
velset = 0,0
sprpriority = 4

[State 19910, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S9,73
ignorehitpause = 1
persistent = 0

[State 19910, dcvm hitspark1]
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

[State 19910, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0

[State 19910, HitDef]
type = HitDef
trigger1 = TimeMod = 5,0
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 7,Hit
damage = 25,2
pausetime = 3,1
guard.pausetime = 2,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S10,71
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 59,-5,-3),ifelse(time > 61,-2,0)
air.velocity  = ifelse(time > 59,-5,-3),ifelse(time > 61,-2,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
yaccel = 0.7
fall = 0
air.fall = 0
fall.recover = 0
fall.recovertime = 20

[State 19910, DestroySelf]
type = DestroySelf
triggerall = !animtime
trigger1 = time >= 64
trigger2 = root,stateno != 19900


; Golden Dragons - construct #2
[Statedef 19911]
type = S
movetype = A
physics = S
anim = 19911
ctrl = 0
velset = 0,0
sprpriority = 4

[State 19911, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S9,73
ignorehitpause = 1
persistent = 0

[State 19911, dcvm hitspark1]
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

[State 19911, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0

[State 19911, HitDef]
type = HitDef
trigger1 = TimeMod = 4,0
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 7,Hit
damage = 30,5
pausetime = 3,1
guard.pausetime = 2,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S10,71
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 59,-7,-5),ifelse(time > 61,-2,0)
air.velocity  = ifelse(time > 59,-7,-5),ifelse(time > 61,-2,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
yaccel = 0.7
fall = 0
air.fall = 0
fall.recover = 0
fall.recovertime = 20

[State 19911, DestroySelf]
type = DestroySelf
triggerall = !animtime
trigger1 = time >= 64
trigger2 = root,stateno != 19900


; Golden Dragons - construct #3
[Statedef 19912]
type = S
movetype = A
physics = S
anim = 19912
ctrl = 0
velset = 0,0
sprpriority = 4

[State 19912, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S9,73
ignorehitpause = 1
persistent = 0

[State 19912, dcvm hitspark1]
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

[State 19912, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0

[State 19912, HitDef]
type = HitDef
trigger1 = TimeMod = 3,0
attr = S,HP
hitflag = MAFP
guardflag = MA
animtype = Hard
air.animtype = UP
ground.type = High
air.type = Low
getpower = 0,0
priority = 7,Hit
damage = 35,5
pausetime = 3,1
guard.pausetime = 2,0
sparkno = -1
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S10,71
guardsound = F6,0
ground.slidetime = 20
ground.hittime = 20
guard.slidetime = 6
guard.hittime = 6
air.hittime = 20
ground.velocity = ifelse(time > 59,-16,-5),ifelse(time > 61,-18,0)
air.velocity  = ifelse(time > 59,-16,-5),ifelse(time > 61,-18,-2)
guard.velocity = -6
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
down.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
sprpriority = 4
yaccel = 0.7
fall = ifelse(time > 59,1,0)
air.fall = ifelse(time > 59,1,0)
fall.recover = 0
fall.recovertime = 20

[State 19912, DestroySelf]
type = DestroySelf
triggerall = !animtime
trigger1 = time >= 64
trigger2 = root,stateno != 19900


;====================BLUE/GREEN (HYBRID) LANTERN====================

;-----------------------
; [Blue/Green Lantern] Custom Winpose
[Statedef 20180]
type = S
ctrl = 0
anim = 20180
velset = 0,0

[State 20180, delay]
type = AssertSpecial
trigger1 = Time = [0,80]
flag = RoundNotOver


;-----------------------
; [Blue/Green Lantern] Custom Intro
[Statedef 20190]
type = S
ctrl = 0
anim = 20190
velset = 0,0

[State 20190, delay]             
type = AssertSpecial
trigger1 = Time = [0,100]
flag = Intro

[State 20190, energy aura]
type = Explod
trigger1 = !Time
anim = 20195
ID = 20195
removetime = 100
sprpriority = -1

[State 20190, costume change]
type = ChangeAnim
trigger1 = Time = 85
value = 20191

[State 20190, light flash]
type = EnvColor
trigger1 = Time = 100
value = 32,0,192
time = 2

[State 20190, particle sparks]
type = Helper
trigger1 = Time = 100
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
facing = -1
pos = 0,-90

[State 20190, particle sparks 2]
type = Helper
trigger1 = Time = 100
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
pos = 0,-90

[State 20190, to stance]
type = ChangeState
trigger1 = Anim = 20191 && !AnimTime
value = 0
ctrl = 0


;------------------------------
; [Blue/Green Lantern] Ring Blast (replaces Ring Strike)
[StateDef 20700]
type = S
movetype = A
physics = S
anim = 1000
ctrl = 0

[State 20700, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -200

[State 20700, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 1
value = S9,0
volume = 0
channel = 0
freqmul = 1.0
loop = 0
pan = 0

[State 20700, Explod]
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

[State 20700, beam]
type = Helper
trigger1 = Time = 6
helpertype = normal
name = "beam"
ID = 20710
pos = 90,-90
postype = p1
stateno = 20710
ownpal = 1

[State 20700, changestate]
type = ChangeState
trigger1 = !AnimTime && NumHelper(20710) = 0
value = 1009


;--------
; Ring Blast -- giga beam helper state
[StateDef 20710]
type = A
movetype = A
physics = C
anim = 20710
ctrl = 0

[State 20710, ontop]
type = SprPriority
trigger1 = 1
value = 2

[State 20710, PosSet]
type = PosSet
trigger1 = 1
x = parent, Pos X + (90 * parent, facing)
y = parent, Pos Y - 90

[State 20710, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,1
volume = 0
channel = -1
freqmul = 1.0
loop = 0
pan = 0

[State 20710, hitdef]
type = HitDef
trigger1 = TimeMod = 6,0
attr = S,SP
hitflag = MAF
guardflag = MAF
animtype = Medium
air.animtype = Medium
fall.animtype = Medium
damage = 22,3
guardflag = MA
pausetime = 6,12
hitsound = S9,1
guardsound = S3,0
sparkno = S9992
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
palfx.add = 64,0,0

[State 20710, DestroySelf]
type = DestroySelf
trigger1 = !AnimTime
trigger2 = parent, Anim != 1000


;-----------------------
; [Blue/Green Lantern] Massive Discharge special (replaces Emerald Swordsman)
[Statedef 20800]
type = A
movetype = A
physics = A
anim = 20800
ctrl = 0

[State 20800, PowerAdd]
type = PowerAdd
trigger1 = !Time
value = -175

[State 20800, noGravity]
type = VelSet
trigger1 = TimeMod = 2,1
y = 0

[State 20800, Helper]
type = Helper
trigger1 = AnimElem = 3
name = "blast wave"
ID = 20810
stateno = 20810
pos = 65,10
facing = 1
persistent = 0

[State 20800, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1

;---------
; Massive Discharge - construct custom state for blast wave
[StateDef 20810]
type    = A
movetype= A
physics = N
anim = 20810
sprpriority = 4

[State 20810, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,31

[State 20810, VelSet]
type = VelSet
trigger1 = !Time
x = 12
y = 0

[State 20810, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 19910, dcvm hitspark1]
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

[State 20810, HitDef]
type = HitDef
trigger1 = TimeMod = 3, 0
attr = A,HP
hitflag = MAFD
guardflag = MA
animtype = hard
priority = 7,Hit
damage = 12,1
sparkno = -1 ;S9992
guard.sparkno = 0
hitsound = S10,13
sparkxy = 0,0
priority = 2,Hit
sprpriority = 6
ground.type = Low
ground.slidetime = 18
ground.hittime = 12
ground.velocity = -7.1
air.velocity = -7.6
fall = 1
fall.recover = 0
down.bounce = 1
kill = 1
palfx.time = 20
palfx.add = -104,-104,32
palfx.mul = 192,192,384
palfx.sinadd = 16,16,60,10

[State 20810, no shadow]
type = AssertSpecial
trigger1 = 1
flag = noshadow

[State 20810, done]
type = DestroySelf
trigger1 = Time = 110


;-----------------------
; [Blue/Green Lantern] Ion Wave Hyper (replaces Ion Force)
[StateDef 20900]
type = U
movetype = A
physics = U
anim = 3500
ctrl = 0
velset = 0,0
facep2 = 1
sprpriority = 1

[State 20900, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1
persistent = 1

[State 20900, StateTypeSet]
type = StateTypeSet
triggerall = !time
trigger1 = pos y >= 0
statetype = S
movetype = A
physics = S

[State 20900, StateTypeSet]
type = StateTypeSet
trigger1 = statetype != S
statetype = A
movetype = A
physics = N

[State 20900, VelMul]
type = VelMul
trigger1 = statetype = A
x = 0.8
y = 0.8

[State 20900, 1]
type = SuperPause
trigger1 = !Time
movetime = 34
time = 40
pos = -38, -100
anim = 2001
poweradd = -1000
sound = S10,1
darken = 1

[State 20900, PlaySnd] ; "plenty more..."
type = PlaySnd
trigger1 = !time
value = S10,35
channel = 0
ignorehitpause = 1
persistent = 0

[State 20900, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

;-------------------
; DCvM hyper portrait/BG
[State 20900, superportrait]
type = Explod
trigger1 = AnimElem = 1
anim = 10004
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 20900, portraitBG]
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

[State 20900, Explod]
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

[State 20900, AfterImage]
type = AfterImage
trigger1 = !Time
time = 8
length = 12
framegap = 2
trans = add
ignorehitpause = 1
persistent = 1

[State 20900, AfterImageTime]
type = AfterImageTime
trigger1 = Time >= 0
time = 2
ignorehitpause = 1
persistent = 1

[State 20900, ChangeState]
type = ChangeState
trigger1 = time >= 42
value = 20905
ctrl = 0

; Ion Wave - spawn pillars
[StateDef 20905]
type = U
movetype = A
physics = U
anim = 3505
ctrl = 0
velset = 0,0
sprpriority = 1

;-------------------
; DCvM hyper portrait/BG
[State 20905, superBG]
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

[State 20905, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1
persistent = 1

[State 20905, AfterImageTime]
type = AfterImageTime
trigger1 = 1
time = 2

[State 20905, StateTypeSet]
type = StateTypeSet
triggerall = !time
trigger1 = pos y >= 0
statetype = S
movetype = A
physics = S

[State 20905, StateTypeSet]
type = StateTypeSet
trigger1 = statetype != S
statetype = A
movetype = A
physics = N

[State 20905, VelMul]
type = VelMul
trigger1 = statetype = A
x = 0.8
y = 0.8

[State 20905, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0

[State 20905, Helper]
type = Helper
trigger1 = TimeMod = 15,0
helpertype = normal
name = "Ion Wave"
stateno = 20915
ID = 20915
pos = (Time * 3), 0
postype = p1
facing = 1
keyctrl = 0
ownpal = 1
supermovetime = 2
pausemovetime = 2
ignorehitpause = 1
persistent = 1

[State 20905, 1]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 68
trigger1 = BackEdgeBodyDist > -1 && frontedgebodydist > -1
value = 20910
ctrl = 1

[State 20905, 1]
type = ChangeState
triggerall = pos y >= 0
triggerall = !animtime
trigger1 = time >= 68
trigger1 = BackEdgeBodyDist <= -1 || frontedgebodydist <= -1
value = 7100

[State 20905, ChangeState]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 68
value = 20910
ctrl = 0

; Ion Wave - active
[StateDef 20910]
type = U
movetype = A
physics = U
anim = 3510
ctrl = 0
velset = 0,0
sprpriority = 1

[State 20910, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1
persistent = 1

[State 20910, Turn]
type = Turn
triggerall = animelem = 10
trigger1 = p2dist x < 0
persistent = 0

[State 20910, sai]
type = ScreenBound
trigger1 = var(4) = 1
value = 0
movecamera = 0,ifelse(BackEdgeBodyDist <= -1 || frontedgebodydist <= -1,0,1)

[State 20910, 1] ; DCvM dash onscreen
type = ChangeState
triggerall = var(4) = 1
trigger1 = BackEdgeBodyDist <= -1 || frontedgebodydist <= -1
value = 7100

[State 20910, ChangeState]
type = ChangeState
triggerall = statetype = A
trigger1 = BackEdgeBodyDist >= 0 || frontedgebodydist >= 0
trigger1 = animelem = 10
value = 948
ctrl = 0

[State 20910, ChangeState]
type = ChangeState
trigger1 = BackEdgeBodyDist >= 0 || frontedgebodydist >= 0
trigger1 = !animtime
value = 0
ctrl = 1

; Ion Wave - construct helper
[StateDef 20915]
type = S
movetype = A
physics = S
anim = 20915
ctrl = 0
velset = 0,0
sprpriority = 4

[State 20915, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S10,101
ignorehitpause = 1
persistent = 0

[State 20915, dcvm hitspark1]
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

[State 20915, HitDef]
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
sparkno = -1;S1006
guard.sparkno = 40
sparkxy = 0,ceil(p2dist y + enemynear,const(size.mid.pos.y))
hitsound = S1005,5
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

[State 20915, HitDef]
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
hitsound = S1005,5
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

[State 20915, ChangeState]
type = ChangeState
triggerall = !animtime
trigger1 = time >= 64
trigger2 = root,stateno != 20905
value = 20916
ctrl = 0

; Ion Force - construct end
[StateDef 20916]
type = S
movetype = A
physics = S
anim = 20916
ctrl = 0
velset = 0,0
sprpriority = 6

[State 20916, PosSet]
type = PosSet
trigger1 = 1
y = 0
ignorehitpause = 1
persistent = 1

[State 20916, AngleDraw]
type = AngleDraw
trigger1 = time >= 1
scale = 1,1+(0.1*time)

[State 20916, Trans]
type = Trans
trigger1 = 1
trans = add

[State 20916, DestroySelf]
type = DestroySelf
trigger1 = !animtime
ignorehitpause = 1
persistent = 1


;====================INDIGO LANTERN====================

;-----------------------
; [Indigo Lantern] Custom Winpose
[Statedef 21180]
type = S
ctrl = 0
anim = 21180
velset = 0,0

[State 21190, bubble]
type = Explod
trigger1 = AnimElem = 3
anim = 21185
ID = 21185
bindtime = 99
removetime = -2
sprpriority = 2
pos = 0,const(size.mid.pos.y)

[State 21190, Explod]
type = Explod
trigger1 = AnimElem = 3
anim = 940
ID = 940
pos = 57,-125
removetime = -2
sprpriority = 2
ontop = 1

[State 21180, staff]
type = Explod
trigger1 = AnimElem = 2
anim = 21181
ID = 21181
bindtime = 99
removetime = -2
sprpriority = 2
pos = 0,0

[State 21180, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S9,2

[State 21180, delay]
type = AssertSpecial
trigger1 = Time = [0,80]
flag = RoundNotOver


;-----------------------
; [Indigo Lantern] Custom Intro
[Statedef 21190]
type = S
ctrl = 0
anim = 21190
velset = 0,0

[State 21190, delay]             
type = AssertSpecial
trigger1 = Time = [0,80]
flag = Intro

[State 21190, bubble]
type = Explod
trigger1 = !Time
anim = 21195
ID = 21195
bindtime = 99
removetime = -2
sprpriority = 2
pos = 0,const(size.mid.pos.y)

[State 21190, Explod]
type = Explod
trigger1 = AnimElem = 2
anim = 940
ID = 940
pos = 57,-125
removetime = -2
sprpriority = 2
ontop = 1

[State 21190, staff]
type = Explod
trigger1 = AnimElem = 3
anim = 21191
ID = 21191
bindtime = 99
removetime = -2
sprpriority = 2
pos = 0,0

[State 21190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S9,2

[State 21190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 4
value = S5,110
channel = 0

[State 21190, to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 0


;---------------------------------------------------------------------------
; [Indigo Lantern] Teleport special (replaces Charging Ram)
[StateDef 21700]
anim = 21700
ctrl = 0
type = S
movetype = I
physics = S
velset = 0,0
sprpriority = 2

[State 21700, VarSet]
type = PowerAdd
trigger1 = !Time
value = -150

[State 21700, VarSet]
type = VarSet
trigger1 = !Time
v = 2
value = IfElse(command = "qcf_a", 0, IfElse(command = "qcf_b", 1, 2))

[State 21700, PlaySnd]
type = PlaySnd
trigger1 = !Time
trigger2 = AnimElem = 3
value = S9,2

[State 21700, bubble]
type = Explod
trigger1 = !Time
anim = 21710
ID = 21710
bindtime = 99
removetime = -2
sprpriority = 2
pos = 0,const(size.mid.pos.y)
ontop = 1
ownpal = 1
removeongethit = 1

[State 21700, Explod]
type = Explod
trigger1 = Time = 1
anim = 940
ID = 940
pos = 57,-125
removetime = -2
sprpriority = 2
ontop = 1

; reappear 120 pixels backward
[State 21700, strength 1]
type = PosSet
triggerall = animelem = 3
trigger1 = var(2) = 0 ; weak kick
x = Pos X - 80 * Facing

; reappear directly over P2
[State 21700, strength 2]
type = PosAdd
triggerall = AnimElem = 3
trigger1 = var(2) = 1 ; medium kick
x = P2Dist X - 120
y = -120

; reappear 90 pixels behind P2
[State 21700, strength 3]
type = PosAdd
triggerall = AnimElem = 3
trigger1 = var(2) = 2 ; hard kick
x = P2Dist X + 90

[State 21700, 3] ; fwd momentum
type = VelAdd
trigger1 = AnimElem = 4 && Var(2) = 1
x = 2.5
y = -2

[State 21700, turn]
type = Turn
trigger1 = AnimElem = 3 && var(2) = 2

[State 21700, air]
type = StateTypeSet
trigger1 = AnimElem = 4 && var(2) = 1
physics = A

[state 21700, safe fall]
type = ChangeState
trigger1 = AnimElem = 4 && Var(2) = 1
value = 948
ctrl = 1

[state 21700, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------------------
; [Indigo Lantern] Nek Ler Klok special (replaces Plasma Sphere)
[Statedef 21800]
type    = S
MoveType= I
physics = S
ctrl = 0
anim = 21800
VelSet = 0,0

[State 21800, VarSet]
type = PowerAdd
trigger1 = !Time
value = -100

[State 21800, dust]
type = Explod
trigger1 = !Time
anim = 918
ID = 918
bindtime = 1
removetime = -2
sprpriority = 3
removeongethit = 1

[State 21800, Explod]
type = Explod
trigger1 = !Time
anim = 21801
ID = 21801
sprpriority = 1
ownpal = 1
removeongethit = 1

[State 21800, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,110
channel = 0
persistent = 1

[State 21800, HitOverride]
type = HitOverride
trigger1 = 1
slot = 2
attr = SCA,NP,SP
stateno = 21810
time = 80

[State 21800, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 21830

;----------------
; Nek Ler Klok active state
[StateDef 21810]
type    = S
MoveType= I
physics = S
anim = 21810
VelSet = 0,0
sprpriority = 2

[State 21810, HitOverride]
type = HitOverride
trigger1 = 1
slot = 2
attr = SCA,NP,SP
stateno = 21810
time = 1

[State 21810, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NT,ST,HT
time = 1

[State 2220, Projectile]
type = Projectile
trigger1 = !Time
ProjID = 21820
projanim = 21820
velocity = 9,0
offset = 65,-65
; HitDef
attr = S,SP
hitflag = MAF
guardflag = MA
animtype = hard
priority = 6,Dodge
damage = 65,5
guardflag = MA
pausetime = 6,6
hitsound = S2,2
guardsound = S3,0
;sparkxy = -10,-75
animtype = Heavy
ground.type = High
ground.slidetime = 8
ground.hittime  = 20
ground.velocity = -4
guard.velocity = -3
air.velocity = -4
sprpriority = 2
palfx.time = 1
palfx.mul = 255,255,255
;palfx.add = 0,0,0
persistent = 0

[State 21810, Explod]
type = Explod
trigger1 = !Time
anim = 940
ID = 940
pos = 76,-132
removetime = -2
sprpriority = 2
ontop = 1
shadow = 0,0,0
ownpal = 1
removeongethit = 1

[State 21810, PalFXWiz]
type = PalFX
trigger1 = !Time
time = 30
add = -100,-100,0
mul = 256,256,256
sinadd = 40,40,80,10
invertall = 1
color = 0

[State 21810, PowerAdd]
type = PowerAdd
trigger1 = 1
value = 7

[State 21810, LifeAdd]
type = LifeAdd
trigger1 = 1
value = 2

[State 21810, Explod]
type = Explod
trigger1 = AnimElem = 2
anim = 21831
ID = 21831
sprpriority = 1
ownpal = 1
removeongethit = 1

[State 21810, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 21830

;-------------
; Nek Ler Klok - p2 reflected projectile
[Statedef 21820]
type = A
physics = N
movetype = A
sprpriority = 3
ctrl = 0

[State 21820, unbind];prevent bind projectiles like thor's thunderstrike
type = BindToParent
trigger1 = !Time
time = 0

[State 21820, velset]
type = VelSet
trigger1 = !Time && Vel X >0
x = -(Vel X) ;8.5

[State 21820, turn]
type = Turn
trigger1 = !Time

[State 21820, posset]
type = PosSet
trigger1 = !Time
x = enemy, Pos X + 50

[State 21820, nothitby]
type = nothitby
trigger1 = 1
time = -1
value = SCA,AA,AT
ignorehitpause = 1

[State 21820, hitdef]
type = hitdef
trigger1 = !Time
priority = 6,Hit
attr = A,SP
damage = ifelse(p2movetype = H,10,100),7
animtype = Hard
hitflag = MAF
guardflag = MA
pausetime = 3,3
sparkno = -1
sparkxy = 0,0
guard.sparkno = ifelse(!var(55),-1,40)
hitsound = -1
guardsound = -1
ground.type = High
ground.slidetime = 15
ground.hittime  = 25
ground.velocity = -5
airguard.velocity = -1
air.type = High
air.velocity = -4, -2
air.hittime = 25
ground.cornerpush.veloff=0
air.fall = 1
p2facing = 1
affectteam = F
fall.recover = 0

[State 21820, noshadow]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 21820, destroyself]
type = destroyself
trigger1 = MoveContact || FrontEdgeDist < -45 ||  BackEdgeDist < -45
Trigger2 = vel x = 0  ;for helpers like thor bifrost break
Trigger3 = time >= 130 ;safety
Trigger4 = prevstateno = 21820 ;safety stuck on colisions

[State 21820, Safety]
type = SelfState
trigger1 = !IsHelper
value = 5050

;-------------
; Nek Ler Klok - end
[Statedef 21830]
type = S
movetype = I
physics = S
anim = 21830

[State 21830, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------------------
; [Indigo Lantern] Enforced Empathy Hyper (replaces Emerald Knight)
[Statedef 21900]
anim = 21900
ctrl = 0
type = S
movetype = A
physics = S

[State 21900, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

[State 21900, vox]
type = PlaySnd
trigger1 = AnimElem = 1
value = S10,110
channel = 0

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 17900, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 21900, superpause]
type = SuperPause
trigger1 = animelem = 1
time = 40
sound = S10,1
pos = 0,-76
darken = 1
poweradd = -1000

[State 21900, orb]
type = Explod
trigger1 = animelem = 1
name = "Orb"
pos = 10,-85
postype = p1
anim = 8000
supermove = 40
pausemovetime = 1
scale = .35, .35
ownpal = 1
sprpriority = 2

[State 21900, super portrait]
type = Explod
trigger1 = animelem = 1
anim = 10005
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermove = 40
pausemovetime = 40
sprpriority = -1
ownpal = 1

[State 21900, super bg]
type = Explod
trigger1 = animelem = 1
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

[State 21900, superBG]
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

[State 21900, VelSet]
type = VelSet
trigger1 = AnimElem = 2
x = 16

[State 21900, 0]
type = HitDef
trigger1 = AnimElem = 2
attr = S, NT          ;Attributes: Standing, Normal Throw
hitflag = M-          ;Affect only ground people who are not being hit
guardflag = M
priority = 1, Miss    ;Throw has low priority, must be miss or dodge type.
sparkno = -1          ;No spark
sprpriority = 1       ;Draw in front of p2
guard.dist = 0        ;This prevents p2 from going into a guard state if close
fall = 0              ;Force p2 into falling down
sprpriority = 1
p2facing = 1
p1stateno = 21920
p2stateno = 21930

[State 21900, missed]
type = ChangeState
trigger1 = !AnimTime
value = 21910
ctrl = 1


;-----------
; Enforced Empathy - missed / blocked
[StateDef 21910]
anim = 21910
ctrl = 0
type = S
movetype = I
physics = S
velset = 0,0

[State 21910, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------
; Enforced Empathy - successfully grabbed P2
[StateDef 21920]
anim = 21920
ctrl = 0
type = S
movetype = A
physics = S
velset = 0,0
sprpriority = 2

[State 21920, grab snd]
type = PlaySnd
trigger1 = !Time
persistent = 0
value = 3,1

[State 21920, spooks snd]
type = PlaySnd
trigger1 = Time = 30
persistent = 0
value = S10,111

[State 21920, Explod]
type = Explod
trigger1 = AnimElem = 2
anim = 935
ID = 935
pos = 85,-145
removetime = -2
sprpriority = 1
ontop = 1

[State 21920, Explod]
type = Explod
trigger1 = Time = 30
anim = 21925
ID = 21925
pos = 85,-145
removetime = 60
supermove
sprpriority = 3
removeongethit = 1

[State 21920, Bind 1]
type = TargetBind
trigger1 = AnimElem = 1
pos = 85,-145

[State 21920, Bind 2]
type = TargetBind
trigger1 = AnimElem = 2
pos = 0,-120

[State 21920, Bind 3]
type = TargetBind
trigger1 = AnimElem = 3
pos = -30,-110

[State 21920, targetdrop]
type = TargetDrop
trigger1 = AnimElem = 4

[State 21920, turn]
type = Turn
trigger1 = !AnimTime

[State 21920, back to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------
; Enforced Empathy - P2 being grappled
[StateDef 21930]
type = A
movetype = H
physics = N
ctrl = 0
velset = 0,0

[State 21930, ChangeAnim2]
type = ChangeAnim2
Trigger1 = !Time
value = 21930

[State 21930, scream]
type = PlaySnd
trigger1 = Time = 50
persistent = 1
value = S11,0
channel = 0

;Generated by Fighter Factory PalFX Editor
[State 21930, PalFXWiz]
type = PalFX
trigger1 = Time = 50
time = 40
add = -70,-70,69
mul = 256,256,256
sinadd = 10,10,40,10
invertall = 1
color = 256

[State 21930, poweradd]
type = PowerAdd
trigger1 = Time >= 50
value = -20
kill = 1

[State 21930, SprPriority]
type = SprPriority
trigger1 = AnimElem = 2
value = 2

[State 21930, screenbound]  ; don't move the camera to follow P2
type = ScreenBound
trigger1 = Alive
movecamera = 0,0

[State 21930, 2] ; tossed
type = ChangeState
trigger1 = !AnimTime
value = 21940


;-------------------------------------------
; Enforced Empathy - P2 being dropped
[StateDef 21940]
type = A
movetype = H
physics = A
ctrl = 0
velset = 9,-2
sprpriority = 2

[State 21940, 2]
type = SelfState
trigger1 = !Time
value = 5050



;====================BLACK LANTERN====================
;
;-----------------------
; [Black Lantern] Custom Winpose
[Statedef 22180]
type = S
ctrl = 0
anim = 22180
velset = 0,0

[State 22180, ring speech bubble]
type = Explod
trigger1 = AnimElem = 6
anim = 22191
ID = 22191
pos = -50,-120
facing = 1
bindtime = 1
removetime = -1
sprpriority = 1
ontop = 1
shadow = 0,0,0
ownpal = 0
removeongethit = 0

[State 22180, ring speech text]
type = Explod
trigger1 = AnimElem = 6
anim = 22182
ID = 22182
pos = -50,-120
facing = facing
bindtime = 1
removetime = -1
sprpriority = 2
ontop = 1
shadow = 0,0,0
ownpal = 0
removeongethit = 0

[State 22180, Vox]
type = PlaySnd
trigger1 = AnimElem = 2
value = S6,121
volume = 120
channel = 0

[State 22180, RingSnd]
type = PlaySnd
trigger1 = AnimElem = 5
value = S6,120
volume = 100

; increment win count, so we can boost BL's power next round
[State 22180, powerup]
type = VarAdd
trigger1 = !Time
v = 58
value = 1

[State 22180, delay]
type = AssertSpecial
trigger1 = Time = [0,150]
flag = RoundNotOver


;-----------------------
; [Black Lantern] Custom Intro
[Statedef 22190]
type = S
ctrl = 0
anim = 22190
velset = 0,0

[State 22190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S9,31

[State 22190, ring trail]
type = Explod
trigger1 = !Time
anim = 30191
ID = 30191
sprpriority = 2
pos = 14, 32
ontop = 1

[State 22190, ring spark]
type = Explod
trigger1 = Time = 57
anim = 30935
ID = 30935
pos = 21,-54
postype = p1
sprpriority = 4

[State 22190, PlaySnd]
type = PlaySnd
trigger1 = AnimElemTime(2) = 4
value = S5,121
volume = 150
persistent = 0

[State 22190, ring speech bubble]
type = Explod
trigger1 = AnimElemTime(2) = 4
anim = 22191
ID = 22191
pos = -50,-120
facing = 1
bindtime = 1
removetime = -2
sprpriority = 1
ontop = 1
shadow = 0,0,0
ownpal = 0
removeongethit = 0

[State 22190, ring speech text]
type = Explod
trigger1 = AnimElemTime(2) = 4
anim = 22192
ID = 22192
pos = -50,-120
facing = facing
bindtime = 1
removetime = -2
sprpriority = 2
ontop = 1
shadow = 0,0,0
ownpal = 0
removeongethit = 0

[State 22190, light flash]
type = EnvColor
trigger1 = AnimElem = 2
value = 0,0,0
invertall = 0
time = 2

[State 22190, particle sparks]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
facing = -1
pos = 0,-80

[State 22190, particle sparks 2]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
pos = 0,-80

[State 22190, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 27
value = S5,120
channel = 0

[State 22190, delay]
type = AssertSpecial
trigger1 = Time = [0,240]
flag = Intro

[State 22190, to stance]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 0


;-----------------------
; [Black Lantern] Piercing Strike special (replaces Ring Strike)
[Statedef 22700]
type = S
movetype = A
physics = S
anim = 1000
ctrl = 0

[State 22700, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,0
volume = 0
channel = 0

[State 22700, Explod]
type = Explod
trigger1 = !Time
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

[State 22700, beam]
type = Helper
trigger1 = AnimElem = 2
helpertype = normal
name = "drill"
ID = 22710
pos = 52,-93
postype = p1
stateno = 22710
size.xscale = 0.5
size.yscale = 0.5

[State 22700, changestate]
type = ChangeState
trigger1 = !AnimTime & NumHelper(22710) = 0
value = 1009


;--------
; Piercing Strike -- drill helper state
[StateDef 22710]
type = A
movetype = A
physics = C
anim = 22710
ctrl = 0

[State 22710, ontop]
type = SprPriority
trigger1 = 1
value = 2

[State 22710, PosSet]
type = PosSet
trigger1 = 1
x = parent, Pos X + (52 * parent, facing)
y = parent, Pos Y - 93

[State 22710, sfx]
type = PlaySnd
trigger1 = !Time
value = 9,21

[State 22710, hitdef]
type = HitDef
trigger1 = TimeMod = 10,0
attr = S,SP
hitflag = MAF
guardflag = MAF
animtype = Medium
air.animtype = Medium
fall.animtype = Medium
damage = 18,3
guardflag = MA
pausetime = 6,12
hitsound = S2,10
guardsound = S3,0
sparkno = S9992		; TODO: replace with bloodsquirt
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

[State 22710, DestroySelf]
type = DestroySelf
trigger1 = Time >= 50
trigger2 = parent, Anim != 1000


;-----------------------
; [Black Lantern] Deadly Embrace special (replaces Buzzcut)
[Statedef 22800]
anim = 22800
type = S
movetype = A
physics = S
ctrl = 0
velset = 0,0

[State 22800, vox]
type = PlaySnd
trigger1 = !Time
value = 9,20
channel = 0
removeongethit = 1

[State 22800, VarSet] ; get a random scale
type = VarSet
trigger1 = TimeMod = 25,0
fv = 2
value = (Random / 3000.0) + 0.2

; ring flash
[State 22800, ring spark]
type = Explod
trigger1 = AnimElemTime(2) >= 0
trigger1 = AnimElemTime(3) < 0
trigger1 = TimeMod = 25,1
anim = ifelse(PalNo = 12, 30935, 935)
ID = 935
pos = 64,-88
postype = p1
removetime = 90
sprpriority = 4

[State 22800, sparkBegone]
type = RemoveExplod
trigger1 = AnimElem = 3
ID = 935

[State 22800, Helper]
type = Helper
trigger1 = AnimElemTime(2) >= 0
trigger1 = AnimElemTime(3) < 0
trigger1 = TimeMod = 25,5
name = "skull"
ID = 22810
stateno = 22810
pos = 64,-88
ownpal = 1
size.xscale = FVar(2)
size.yscale = FVar(2)

[State 22800, 1]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;-----------------------
; [Black Lantern] Deadly Embrace special - air version
[Statedef 22805]
anim = 22805
type = S
movetype = A
physics = S
ctrl = 0
velset = 0,0

[State 22805, vox]
type = PlaySnd
trigger1 = !Time
value = 9,20
channel = 0
removeongethit = 1

[State 22805, VarSet] ; get a random scale
type = VarSet
trigger1 = TimeMod = 25,0
fv = 2
value = (Random / 3000.0) + 0.2

; ring flash
[State 22805, ring spark]
type = Explod
trigger1 = AnimElem = 2
anim = ifelse(PalNo = 12, 30935, 935)
ID = 935
pos = 54,-18
postype = p1
removetime = -2
sprpriority = 4

[State 22805, Helper]
type = Helper
trigger1 = AnimElem = 2
name = "skull"
ID = 22810
stateno = 22810
pos = 54,-18
ownpal = 1
size.xscale = FVar(2)
size.yscale = FVar(2)

[State 22805, safe fall]
type = ChangeState
trigger1 = !AnimTime
value = 948
ctrl = 1


; Deadly Embrace -- helper state
[StateDef 22810]
type    = A
movetype= A
physics = N
anim = 22810
sprpriority = 6

[State 22810, PlaySnd]
type = PlaySnd
trigger1 = !Time
value = S9,72

[State 22810, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 22810, VelSet]
type = VelSet
trigger1 = (!Time)
x = 2

[State 22810, VarSet]
type = VarSet
trigger1 = IsHelper
fv = 2
value = Random * (EnemyNear, Const(size.mid.pos.y)) / 950

[State 22810, VelAdd]
type = VelAdd
trigger1 = (P2Dist X < 0) && (Vel X > -3)
x = -(Random/2500.0)

[State 22810, VelAdd]
type = VelAdd
trigger1 = (P2Dist X > 0) && (Vel X < 3)
x = (Random/2500.0)

[State 22810, VelAdd]
type = VelAdd
trigger1 = (FVar(2) > Pos Y) && (Vel Y < 3)
y = (Random/2500.0)

[State 22810, VelAdd]
type = VelAdd
trigger1 = (FVar(2) < Pos Y) && (Vel Y > -3)
y = -(Random/2500.0)

[State 22810, no shadow]
type = AssertSpecial
trigger1 = 1
flag = noshadow

[State 22810, hit flash]
type = EnvColor
trigger1 = movecontact = 1
value = 64,64,64
time = 4
ignorehitpause = 1
persistent = 0

[State 22810, hit]
type = HitDef
trigger1 = TimeMod = 15,0
attr = A,SP
hitflag = MAF
guardflag = MAF
pausetime = 0,0
hitsound = S9,72 ;-1
guardsound = -1
sparkno = -1
sparkxy = 0,75
animtype = Heavy
ground.type = Low
ground.slidetime = 0
ground.hittime  = 0
ground.velocity = 2
guard.velocity = 2
air.velocity = 2,-2
kill = 1
guard.kill = 1
fall.kill = 1
palfx.time = 25
palfx.add = 64,64,64
palfx.invertall = 1
p1stateno = 22811
p2stateno = 22812

[State 22810, end]
type = DestroySelf
trigger1 = Time = 500


; Deadly Embrace -- helper state (active)
[StateDef 22811]
type    = A
movetype= A
physics = N
ctrl = 0
sprpriority = 6

[State 22811, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

; lazily follow P2 (homing projectiles code from FlowaGirl's tutorial)
[State 22810, VarSet]
type = VarSet
trigger1 = IsHelper
fv = 2
value = Random * (EnemyNear, Const(size.mid.pos.y)) / 900

[State 22810, VelAdd]
type = VelAdd
trigger1 = (P2Dist X < 0) && (Vel X > -3)
x = -(Random/2500.0)

[State 22810, VelAdd]
type = VelAdd
trigger1 = (P2Dist X > 0) && (Vel X < 3)
x = (Random/2500.0)

[State 22810, VelAdd]
type = VelAdd
trigger1 = (FVar(2) > Pos Y) && (Vel Y < 3)
y = (Random/2500.0)

[State 22810, VelAdd]
type = VelAdd
trigger1 = (FVar(2) < Pos Y) && (Vel Y > -3)
y = -(Random/2500.0)
; end P2-following code

[State 22811, hit]
type = HitDef
trigger1 = TimeMod = 50,0
attr = S,HA
hitflag = MAF
guardflag = MAF
;damage = 25,3
pausetime = 0,0
hitsound = -1
guardsound = -1
sparkno = -1
sparkxy = -1
animtype = Heavy
ground.type = Low
ground.slidetime = 0
ground.hittime  = 0
ground.velocity = 2
guard.velocity = 2
air.velocity = 2,-2
kill = 0
guard.kill = 0
palfx.time = 25
palfx.add = 64,64,64
palfx.invertall = 1
;p1stateno = 22811
p2stateno = 22812

[State 22811, end]
type = DestroySelf
trigger1 = !AnimTime
trigger2 = EnemyNear,Alive = 0


; P2 custom hitstate - hampered by a Deadly Embrace skull
[Statedef 22812]
type = U
movetype = H
ctrl = 0
velset = 0,0

[State 22812, PalFXWiz]
type = PalFX
trigger1 = !Time
time = 5
add = -100,-100,-100
mul = 256,256,256
sinadd = -10,-10,-10,10
invertall = 1
color = 0

[State 22812, LifeAdd]
type = LifeAdd
trigger1 = !Time
value = -1
kill = 0

; am I dead?
[State 22812, ChangeState]
type = SelfState
trigger1 = Life <= 0
value = IfElse(StateType = A, 5020,5000)

[State 22812, End]
type = SelfState
trigger1 = Time >= 3
value = IfElse(StateType = A, 50,0)
ctrl = 1


;-----------------------
; [Black Lantern] Nekron Rising hyper (replaces Ring Slinging)
[Statedef 22900]
type = S
movetype = A
physics = S
anim = 22900
ctrl = 0
velset = 0,0

[State 22900, dust]
type = Explod
trigger1 = !Time
anim = 918
supermove = 1
ontop = 1
removeongethit = 1

[State 22900, vox]
type = PlaySnd
trigger1 = !Time
value = S10,120
channel = 0

;-------------------
; DCvM superpause, hyper portrait, hyper BG
[State 22900, noBars]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
ignorehitpause = 1

[State 22900, superpause]
type = SuperPause
trigger1 = AnimElem = 3
time = 40
sound = S10,1
pos = 20,-70
darken = 1
poweradd = -1000

[State 22900, superportrait]
type = Explod
trigger1 = AnimElem = 3
anim = 10006
ID = 10000
pos = 0,0
postype = back
bindtime = 999
removetime = 40
supermovetime = 40
pausemovetime = 40
sprpriority = 3
ownpal = 1

[State 22900, portraitBG]
type = Explod
trigger1 = AnimElem = 3
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

[State 22900, superBG]
type = Helper
trigger1 = AnimElem = 4
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

[State 22900, ChangeState]
type = ChangeState
trigger1 = Time = 120
value = 22910
ctrl = 0


;---------
; Nekron Rising - end
[StateDef 22910]
type = S
movetype = A
physics = S
anim = 22910

[State 22910, changestate]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1

