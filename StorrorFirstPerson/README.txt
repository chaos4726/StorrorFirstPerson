STORROR FIRST PERSON
====================

A first-person camera for STORROR Parkour Pro (a UE4SS Lua mod). You see through the athlete's eyes; the view
turns with his flips, rolls and vaults, and you can look down at his arms and legs.


INSTALL
-------
1. Install UE4SS for STORROR Parkour Pro if you don't have it (dwmapi.dll and the ue4ss folder go in
   STORRORParkourPRO\Binaries\Win64).
2. Copy the StorrorFirstPerson folder into STORRORParkourPRO\Binaries\Win64\ue4ss\Mods
3. Start the game. Open the menu: there is a new tab with an eye icon, FIRST PERSON, between CONTROLS and SETTINGS.

Works with the vanilla game and your saves. Also reported working on Linux (Proton).


UNINSTALL
---------
Delete this folder:
    STORRORParkourPRO\Binaries\Win64\ue4ss\Mods\StorrorFirstPerson
To remove the mod loader too, also delete these, next to each other in STORRORParkourPRO\Binaries\Win64:
    dwmapi.dll
    the ue4ss folder
Your settings are kept in StorrorFirstPerson\settings.txt and go with the folder.


THE FIRST PERSON TAB
--------------------
On this tab the game is shown behind the menu, so you can see what each setting does as you change it.

[PRESETS]
  PRESET              DEFAULT (everything as it starts), MIRROR'S EDGE (lively: speed, landings, lean, hands in
                      view, a dot, no HUD), STEADY (as still as it goes), BODY CAM (low on the chest, wide, every
                      feel at full, no shirt, no HUD), GOPRO (wide fisheye from up on the head), CINEMATIC (narrower,
                      smoothed, film bars, blur, breathing), COMPETITIVE (no motion or effects, crosshair and
                      speedometer), INTENSE (every speed and landing effect up), GHOST (no body, a crosshair), COMFORT
                      (still, level and upright, for motion sickness) and RANDOM (every setting at random, picked
                      again each time you move onto it). Moving it changes the settings below.

[VIEW]
  FIRST PERSON        On / off. (Also F5, or both sticks clicked: FIRST/THIRD PERSON BUTTON.)
  FIELD OF VIEW       How wide the view is, 60 to 179 degrees.
  WIDEN POV           STORROR's own fisheye (the drone camera's). 50% is the drone's strength; below 0 it bends
                      the other way. Strong fisheye with a very wide field of view blurs the middle of the screen.
  SPEED FOV           The view widens the faster you go, falling included.
  DRONE FISHEYE       Turning it on sets FIELD OF VIEW and WIDEN POV to the drone's and adds its dark edges.
  CROSSHAIR DOT       A small dot in the middle of the screen.
  HIDE HUD            Hides STORROR's on-screen hints, compass and score while in first person.
  CROSSHAIR SIZE / COLOR / SHAPE   The crosshair's size in pixels, its colour, and a dot, a cross, or both.
  SPEEDOMETER         Your speed, falling included, low on the screen: off, km/h or mph.
  SPEED EFFECTS       The faster you go, the darker the screen's edges and the more the colours split at them.
  MOTION BLUR         0% none (the mod's default), 50% the engine's own amount, 100% double.
  JUMP FOV KICK       The view widens for a moment as you jump.
  NEAR CLIP           How close to your eyes things can be before they're cut off (1 to 20 cm).
  FLASHLIGHT          A light shining from your eyes. L turns it on and off too.
  FLASHLIGHT BRIGHTNESS   How bright it is.
  SPRINT SHAKE        A small, quick camera shake as you get up to a full sprint.
  CINEMATIC BARS      Black bars at the top and bottom; 100% is a widescreen film frame.

[HEAD]
  MOTION              0% the camera sits still on your body (no head bob), 100% it follows your head exactly.
                      Flips, rolls and climbs always follow your body.
  LANDING IMPACT      The camera dips and shakes when you land, harder from higher.
  LEAN                The view tilts into turns.
  LOOK DOWN IN AIR    The view tips down while you're in the air, so you see where you'll land.
  SPRINT HANDS        At a sprint the camera moves forward and down so your hands are in view.
  FOLLOW FLIPS        The view turns over with flips, rolls, vaults and pole swings.
  HEAD LOCK           0% you can look all the way up and down; 100% the view stays level.
  WALL RUN TILT       The view leans away from a wall you run along.
  BREATHING           Standing still, the view rises and falls slowly (times MOTION: none at MOTION 0%).
  LOOK SMOOTHING      0% your look is raw; higher eases it, 100% slow and cinematic.

[RUBBERBAND]  (your head pulled back to where your body faces; off while you're in the air, back on landing)
  RUBBERBAND X / Y    Left/right and up/down. 0% free; in between, turning away gets harder the further you go;
                      100% your head can't leave your body's direction.
  RUBBERBAND STRENGTH How hard it resists.
  CENTER SPEED        How fast it comes back to the middle after you let go of the right stick (0 never, 100 at once).
  CENTER DELAY        Wait a moment before coming back.

[CAMERA POSITION]
  CAMERA X / Y / Z    Move the camera from your eyes: forward/back, right/left, up/down, up to 100 cm.

[CONTROLS]
  STICK TURN RATE     How fast the controller's right stick turns the view (the mouse isn't changed).
  RIGHT STICK TURNS BODY   On: standing, your body turns with your view. Off: you turn your head only.
  LEFT STICK STEERS   On: STORROR's own steering - point the stick straight back and you turn around, the camera
                      swinging round with you. Off: your body keeps
                      facing where you look, you strafe, and pulling back backs you up facing forward.
  LOOK UP/DOWN SPEED  How fast you look up and down, apart from left and right (mouse and stick).
  INVERT LOOK UP/DOWN Up is down, in first person only.
  FIRST/THIRD PERSON BUTTON   F5, or click both sticks together: first person on and off without the menu.
  THIRD PERSON IN BAILS   STORROR's own camera while you bail and get back up.

[BODY]  (hidden from your own view only; your shadow and other players still see all of you)
  HIDE HEAD, ARMS, STOMACH, SHIRT, PANTS, SHOES
  HIDE BODY IN FLIPS  All of you disappears while you flip in the air, and comes back as you come out of it.
  HIDE BODY IN ROLLS  All of you disappears while you roll.
  HIDE BODY IN VAULTS All of you disappears while you vault.
  HIDE BODY WHEN RUNNING   All of you disappears while you run along the ground (faster than a walk).
  HIDE BODY WHEN STANDING  All of you disappears while you stand still.


[HELP]
  WHAT EACH SETTING DOES   Opens a panel on the right listing every setting and what it does (scroll with the
                           mouse wheel or the right stick). Switch it off, or leave the tab, to close it.

NOTES
-----
- STORROR has no running backwards or sideways animations, so when you strafe or back up your legs play the forward run.
- With the Super STORROR 64 mashup installed and on, this mod stays off (the mashup has its own first person).
