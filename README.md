# STORROR First Person

A first-person camera for **STORROR Parkour Pro**, as a UE4SS Lua mod. The view sits at the athlete's eyes and follows his flips, rolls, vaults and climbs. Look down and you see your own body.

**Download:** grab `StorrorFirstPerson_v2.0.zip` from [Releases](../../releases). It includes UE4SS, ready to drop in.

## What's in 2.0

A **FIRST PERSON** tab in the game's own menu, between CONTROLS and SETTINGS, with over 50 settings:

- **View:** field of view (to 179°), fisheye (WIDEN POV), the drone's fisheye, near clip, a flashlight (L key)
- **Effects:** speed FOV, speed effects, motion blur, jump FOV kick, landing impact, lean, wall run tilt, breathing, look down in air, sprint hands, sprint shake
- **Head:** motion (0% rock steady to 100% following the head), follow flips, head lock, look smoothing
- **Rubberband:** your head pulled back toward where your body faces (left/right and up/down, strength, centring speed and delay); it lets go in the air
- **Camera position:** move the camera up to 100 cm from the eyes
- **HUD:** crosshair (size, colour, shape), speedometer, cinematic bars, hide STORROR's HUD
- **Controls:** stick turn rate, look up/down speed, invert, right stick turns body, left stick steers (point it straight back to turn around), F5 or both sticks clicked to switch first person, third person in bails
- **Body:** hide your head, arms, stomach, shirt, pants or shoes, or all of you in flips, rolls, vaults, while running or while standing
- **Presets:** DEFAULT, MIRROR'S EDGE, STEADY, BODY CAM, GOPRO, CINEMATIC, COMPETITIVE, INTENSE, GHOST, COMFORT, and RANDOM (everything at random each time you pick it)

The tab's last row, **WHAT EACH SETTING DOES**, opens a panel in the game explaining every setting. They're also listed in [`StorrorFirstPerson/README.txt`](StorrorFirstPerson/README.txt).

## Install

1. In Steam, right-click STORROR Parkour Pro > Manage > Browse local files.
2. Copy the `STORRORParkourPRO` folder from the release zip into that folder (merge / replace files).
3. Start the game. First person starts on: switch it with the FIRST PERSON tab or F5.

Already using UE4SS for other mods? Copy only `StorrorFirstPerson` into your `ue4ss\Mods` folder and add `StorrorFirstPerson : 1` to `Mods\mods.txt`.

**Uninstall:** delete `STORRORParkourPRO\Binaries\Win64\ue4ss\Mods\StorrorFirstPerson` (and `dwmapi.dll` plus the `ue4ss` folder next to it to remove the loader too).

## This repository

`StorrorFirstPerson/` is the mod folder as it goes in `ue4ss\Mods`: `Scripts\main.lua` loads `fp.lua` (the camera), `fpsettings.lua` and `fpmenu.lua` (the menu tab and its rows), `fpconfig.lua` (settings and presets), `fphud.lua` (crosshair, speedometer, bars), `fphelp.lua` (the help panel), `fpkeys.lua` (F5 and L) and `lib.lua`.

The release zip also contains [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) (MIT licence), the build that runs with STORROR's Unreal Engine 5.7. A game update may need a newer UE4SS.
