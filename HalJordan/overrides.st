; States file for Hal Jordan -- Overrides and Common states
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
; Override common states (use same number to override) :
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; Stand (overridden to allow for custom corps modes)
[Statedef 0]
type = S
physics = S
sprpriority = 0

[State 0, 1] ; default stance
type = ChangeAnim
triggerall = PalNo != [7,12]
trigger1 = Anim != 0 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 0

;------------------------------------
; custom mode stances
[State 0, 1a] ; Red Lantern stance
type = ChangeAnim
triggerall = PalNo = 7
trigger1 = Anim != 17000 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 17000

[State 0, 1b] ; Orange Lantern stance
type = ChangeAnim
triggerall = PalNo = 8
trigger1 = Anim != 18000 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 18000

[State 0, 1c] ; Yellow Lantern stance
type = ChangeAnim
triggerall = PalNo = 9
trigger1 = Anim != 19000 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 19000

[State 0, 1d] ; Green/Blue Lantern stance
type = ChangeAnim
triggerall = PalNo = 10
trigger1 = Anim != 20000 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 20000

[State 0, 1e] ; Indigo Lantern stance
type = ChangeAnim
triggerall = PalNo = 11
trigger1 = Anim != 21000 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 21000

[State 0, 1f] ; Black Lantern stance
type = ChangeAnim
triggerall = PalNo = 12
trigger1 = Anim != 22000 && Anim != 5
trigger2 = Anim = 5 && AnimTime = 0 ;Turn anim over
value = 22000
; end of custom mode stances
;------------------------------------

;------------------------------------
; Blue+Green / Black customizations:
;   Blue+Green: power supercharger
;   Black: very, very hard to kill >:-}

[State 0, blue flash]
type = EnvColor
trigger1 = PalNo = 10 && Time = 50 && Power < 3000
value = 24,8,192
time = 2

[State 0, black flash]
type = EnvColor
trigger1 = PalNo = 12 && Time = 50 && Life < 1000
value = 0,0,0
time = 2

[State 0, sfx]
type = PlaySnd
triggerall = Time = 50
trigger1 = PalNo = 10 && Power < 3000
value = S9,2

[State 0, particle sparks]
type = Helper
triggerall = Time = 50
trigger1 = PalNo = 10 && Power < 3000
trigger2 = PalNo = 12 && Life < 1000
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
facing = -1
pos = 0,-80

[State 0, particle sparks 2]
type = Helper
triggerall = Time = 50
trigger1 = PalNo = 10 && Power < 3000
trigger2 = PalNo = 12 && Life < 1000
helpertype = normal
name = "Explod"
stateno = 1006
ID = 1006
pos = 0,-80

[State 0, BLCharge] ; recharge BlueGreen Lantern's battery whenever he stands still
type = PowerSet
trigger1 = PalNo = 10 && Time = 50
value = 3000

[State 0, BkRegen] ; regenerate Black Lantern's health whenever he stands still
type = LifeSet
trigger1 = PalNo = 12 && Time = 50
value = 1000
; end of Blue+Green/Black customizations
;------------------------------------


[State 0, 2]
type = VelSet
trigger1 = Time = 0
y = 0

[State 0, 3] ;Stop moving if low velocity or 4 ticks pass
type = VelSet
trigger1 = abs(vel x) < 2
trigger2 = Time = 4
x = 0

[State 0, 4] ;Are you dead?
type = ChangeState
trigger1 = !alive
value = 5050

;---------------------------------------------------------------------------
; Jump Land
[Statedef 52]
type    = S
physics = S
ctrl = 0
anim = 47

[State 52, RemoveExplod]  ;customized to remove any lingering constructs from air attacks
type = RemoveExplod
trigger1 = Time = 0

[State 52, 1]
type = VelSet
trigger1 = Time = 0
y = 0

[State 52, 2]
type = PosSet
trigger1 = Time = 0
y = 0

[State 52, 3]
type = CtrlSet
trigger1 = Time = 3
value = 1

[State 52, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; RUN_FWD
[Statedef 100]
type    = A
movetype = I
physics = N
anim = 100
sprpriority = 1
velset = const(velocity.run.fwd.x), 0

[State 100, PlaySnd]
type = PlaySnd
trigger1 = Time = 0
value = S8,0

[State 100, lines]
type = Explod
trigger1 = timemod = 3,1
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

[State 100, 2] ;Prevent run from canceling into walk
type = AssertSpecial
trigger1 = 1
flag = NoWalk

[State 100, 3] ;Prevent from turning
type = AssertSpecial
trigger1 = 1
flag = NoAutoTurn

[State 100, 4]
type = ChangeState
trigger1 = Time = 35
value = IfElse(Pos Y < 0, 948, 0)
ctrl = 1

;---------------------------------------------------------------------------
; GUARD (end)
[Statedef 140]
type = U    ;Leave state type unchanged
physics = U ;Leave physics unchanged
ctrl = 1

[State 140, 1]
type = ChangeAnim
trigger1 = Time = 0
value = 140 + (statetype = C) + (statetype = A)*2

; customize starts here
[State 140, RemoveExplod]
type = RemoveExplod
trigger1 = Time = 0
id = 138
; customize ends here

[State 140, 2]
type = StateTypeSet
trigger1 = Time = 0 && statetype = S
physics = S

[State 140, 3]
type = StateTypeSet
trigger1 = Time = 0 && statetype = C
physics = C

[State 140, 4]
type = StateTypeSet
trigger1 = Time = 0 && statetype = A
physics = A

[State 140, Hi to Lo]
type = StateTypeSet
trigger1 = statetype = S && command = "holddown"
statetype = C
physics = C

[State 140, Lo to Hi]
type = StateTypeSet
trigger1 = statetype = C && command != "holddown"
statetype = S
physics = S

; shield construct helper state
[Statedef 820]
type = A
physics = N
movetype = I
ctrl = 0
anim = 138

[State 820, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA, NA, SA, HA, NP, SP, HA
slot = 1
stateno = 820
time = 1
forceair = 0

[State 820, PosSet]
type = PosSet
trigger1 = parent, statetype = S
x = parent, pos x
y = parent, pos y

[State 820, PosSet]
type = PosSet
trigger1 = parent, statetype = C
x = parent, pos x
y = parent, pos y - 100



;---------------------------------------------------------------------------
; HITG_SHAKE  -- customized to take power away from Indigo Hal when hit
[Statedef 5000]
type    = S
movetype= H
physics = N
velset = 0,0

[State 5000, PowerAdd]	;-- Indigo mode customization
type = PowerAdd
trigger1 = PalNo = 11
value = -8

[State 5000, 1] ;Anim for HIT_LIGHT to HIT_HARD
type = ChangeAnim
trigger1 = Time = 0
trigger1 = GetHitVar(animtype) != [3,5]
value = ifelse((GetHitVar(groundtype) = 1),5000,5010) + GetHitVar(animtype)

[State 5000, 2] ;Anim for HIT_BACK
type = ChangeAnim
trigger1 = Time = 0
trigger1 = GetHitVar(animtype) = [3,5]
value = 5030

[State 5000, 3] ;Anim for HIT_UP/HIT_DIAGUP (only if it exists)
type = ChangeAnim
trigger1 = Time = 0
trigger1 = (GetHitVar(animtype) = [4,5]) && (SelfAnimExist(5047 + GetHitVar(animtype)))
value = 5047 + GetHitVar(animtype) ;5051 - 4 + type

[State 5000, 4] ;Freeze anim
type = ChangeAnim
trigger1 = Time > 0
value = anim

[State 5000, 5] ;State type gets set to aerial if getting hit up
type = StateTypeSet
trigger1 = Time = 0
trigger1 = GetHitVar(yvel) != 0 && GetHitVar(fall)
trigger2 = Pos Y != 0
type = a

[State 5000, 6]
type = ChangeState
trigger1 = HitShakeOver
trigger1 = GetHitVar(yvel) = 0
value = 5001 ;HITG_SLIDE

[State 5000, 7]
type = ChangeState
trigger1 = HitShakeOver
value = 5030

[State 5000, FFB Light]
type = ForceFeedback
trigger1 = anim = 5000
trigger2 = anim = 5010
persistent = 0
time = 6
waveform = square

[State 5000, FFB Medium]
type = ForceFeedback
trigger1 = anim = 5001
trigger2 = anim = 5011
persistent = 0
time = 8
waveform = sinesquare
ampl = 110,-1,-.3

[State 5000, FFB Hard]
type = ForceFeedback
trigger1 = anim = 5012
trigger2 = anim = 5002
trigger3 = anim = 5030
persistent = 0
time = 15
waveform = sinesquare
ampl = 140



;============= END OF STATE OVERRIDES =============


;---------------------------------------------------------------------------
; Initialize (at the start of the round) - overridden to use custom stances
[Statedef 5900]
type = S

[State 5900, 1] ;Clear all int variables
type = VarRangeSet
trigger1 = roundsexisted = 0
last = 57   ; allow vars 58/59 to persist for round-to-round counts (# of wins, AI state)
value = 0

[State 5900, 2] ;Clear all float variables
type = VarRangeSet
trigger1 = roundsexisted = 0
fvalue = 0

; keep track of my custom mode, if any (for hyper portraits, etc)
[State 5900, VarSet]
type = VarSet
trigger1 = PalNo = [1,6]
v = 5
value = 0

[State 5900, VarSet]
type = VarSet
trigger1 = PalNo = [7,12]
v = 5
value = PalNo - 6

[State 0, 1a] ; Red Lantern stance
type = ChangeAnim
triggerall = PalNo = 7
trigger1 = roundno > 1 && Anim=0
value = 17000

[State 0, 1b] ; Orange Lantern stance
type = ChangeAnim
triggerall = PalNo = 8
trigger1 = roundno > 1 && Anim=0
value = 18000

[State 0, 1c] ; Yellow Lantern stance
type = ChangeAnim
triggerall = PalNo = 9
trigger1 = roundno > 1 && Anim=0
value = 19000

[State 0, 1d] ; Green/Blue Lantern stance
type = ChangeAnim
triggerall = PalNo = 10
trigger1 = roundno > 1 && Anim=0
value = 20000

[State 0, 1e] ; Indigo Lantern stance
type = ChangeAnim
triggerall = PalNo = 11
trigger1 = roundno > 1 && Anim=0
value = 21000

[State 0, 1f] ; Black Lantern stance
type = ChangeAnim
triggerall = PalNo = 12
trigger1 = roundno > 1 && Anim=0
value = 22000

[State 5900, OLCharge] ; recharge Orange/BlueGreen Lantern's battery every round 1
type = PowerSet
trigger1 = roundno = 1 && (PalNo = 8 || PalNo = 10)
value = 3000

[State 5900, BlkCharge] ; charge up Black Lantern's battery based on how many wins he's had
type = PowerSet
trigger1 = PalNo = 12
value = var(58) * 1000

[State 5900, 3] ;Intro for round 1
type = ChangeState
trigger1 = roundno = 1
value = 190


;---------------------------------------------------------------------------
; States that are always executed (use statedef -2)
;---------------------------------------------------------------------------
[Statedef -2]

[State -2, debug]       ; (debug clipboard)
type = DisplayToClipboard
trigger1 = 1 ;Alive
text = "Var(58): %d - Power: %d - GameTime: %d"
params = var(58), Power, GameTime

[State -2, PosSet]
type = PosSet
trigger1 = Alive
z = 0.9

[State -2, RL_Ouchie]  ; Red mode has a slow lifeforce burn
type = LifeAdd
triggerall = RoundState = 2 && PalNo = 7
trigger1 = (GameTime%100)=0 
value = -10

[State -2, RL_heartbeat]
type = PlaySnd
triggerall = RoundState = 2 && PalNo = 7
trigger1 = (GameTime%100)=0
value = 7,70
channel = 2

[State -2, RL_redFlash]
type = PalFX
triggerall = RoundState = 2 && PalNo = 7
trigger1 = (GameTime%100)=0
add = 215, 0, 0
mul = 256, 64, 0
sinadd = 256, IfElse(var(10)=7, 10, IfElse(var(10)=8, 128, 256)), 10, 50
time = 3

[State -2, YL_AttackMul]  -- Yellow mode is a little more powerful than normal
type = AttackMulSet
trigger1 = PalNo = 9
value = 1.5

[State -2, IL_DefenseMul]  -- Indigo mode is a little tougher than normal
type = DefenceMulSet
trigger1 = PalNo = 11
value = 1.5

[State -2, power_aura]; aura's helper, helps to maintain its definitions
type = Helper
triggerall = RoundState > 1
triggerall = numhelper(10050) <= 1 && Alive
trigger1 = TimeMod = 4,2
helpertype = normal
ID = 10050
stateno = 10050
name = "PowerAura"
postype = right
facing = -1
pos = -9999999999999999999, -9999999999999999999
keyctrl = 0
size.xscale = 1
size.yscale = 1
size.shadowoffset = -99999
ownpal = 1
persistent = 1
ignorehitpause = 1

[State -2, jump landing sound]   ; custom jump-landing sound
triggerall = Time = 1
trigger1 = stateno = 52
trigger2 = stateno = 106
type = PlaySnd
persistent = 0
value = 8,1

; remove shield construct if no longer guarding
[State -2, RemoveExplod]
type = RemoveExplod
trigger1 = Anim != [120,152]
id = 138

[State -2, gethits]         ; custom gethit sounds
type = PlaySnd
triggerall = (stateno = [5000,5210]) && (Time = 0) && (!IsHelper)
trigger1 = anim = 5002  ; standing hard hit high
trigger2 = anim = 5012  ; stand hard hit low
trigger3 = anim = 5022  ; crouching hard hit
trigger4 = anim = 5030  ; air hit
trigger5 = anim = 5070  ; tripped
persistent = 0
value = 4,0

[State -2, superjump opponent locator]
type = Helper
triggerall = (NumHelper(0) = 0)
trigger1 = (Pos Y < -200) && (P2Dist Y > 50)
ID = 0
pos = 0,-120
postype = p2
stateno = 910
facing = 1


;---------------------------------------------------------------------------
; States that are executed when in self's state file (use statedef -3)
;---------------------------------------------------------------------------
[Statedef -3]

; desperation quote ("Getting hot in here")
[State -3, PlaySnd]
type = PlaySnd
triggerall = PalNo != 7
trigger1 = (Life <= 150) && (var(50) = 0)
value = S12,1

[State -3, VarSet]
type = VarSet
trigger1 = Life <= 150
v = 50
value = 1

; more shield stuff
[State -3, shield]
type = Explod
triggerall = NumExplod(138) = 0
trigger1 = Anim = [120,159]
anim = ifelse(palno=12, 30138, 138)
ID = 138
pos = 0, ifelse(statetype = C, 30, 0)
bindtime = 999
removetime = -2
sprpriority = 3
ontop = 1
ownpal = 0
removeongethit = 1

; reposition shield if crouching
[State -3, ModifyExplod]
type = ModifyExplod
triggerall = NumExplod(138) = 1
trigger1 = StateType = C
ID = 138
pos = 0,30

; reposition shield if not crouching
[State -3, ModifyExplod]
type = ModifyExplod
triggerall = NumExplod(138) = 1
trigger1 = StateType != C
ID = 138
pos = 0,0


;------------------------------------------------------------------
;Finishers (code taken with permission from Magus's Mongul)
;------------------------------------------------------------------
;--------------------------------
; based on FlowaGirl and Ethan Lives codes
; taken with permission from McCready's Guido char
[State -3, Finish Hit Explod - Helper]
type = Helper
triggerall = WinKO && NumHelper(8900) = 0
trigger1 = RoundState = 3
helpertype = Normal
name = "Finish Hit Explod"
id = 8900
pos = 0, 0
postype = p1
facing = 0
stateno = 8900
keyctrl = 0
ownpal = 1
supermovetime = 1000
pausemovetime = 1000
ignorehitpause = 1

[State -3, WinByHyper]
type = Helper
triggerall = (WinKO) && (!NumHelper(12000)) && (enemy,time=1)
triggerall = PalNo = [1,6]
trigger1 = (StateNo = [3000,4900])
helpertype = Normal
name = "WinKO"
id = 12000
pos = 0,-1500
postype = back
bindtime = -1
facing = 0
stateno = 12000
keyctrl = 0
ownpal = 1
supermovetime = 9999
pausemovetime = 9999
ignorehitpause = 1


