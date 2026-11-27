# Platform support — production baseline

Updated 2026-11-27. Engine: Godot 4.7.2 Standard, GDScript, Compatibility renderer.
This project is an early production prototype. Configured exports do not establish
hardware compatibility or store readiness.

| Target | Prepared now | Required before a runnable/distributable build |
|---|---|---|
| Windows PC | Release export produced at `build/windows/aster.exe`; keyboard/mouse, controller and headless runtime checked | Launch/performance tests on Windows hardware |
| Linux PC | Release export produced at `build/linux/aster.x86_64`; portable GDScript/input | Launch tests on Linux hardware |
| macOS PC | Release package produced at `build/macos/aster.zip`; ETC2/ASTC import enabled | Mac launch tests; signing/notarization for distribution |
| Web | Single-threaded Web release export produced at `build/web/index.html`; Compatibility renderer, touch/gamepad paths | Hosted browser run, actual WebGL2 and persistent-storage tests; browser policy may clear stored data |
| Android | arm64 preset, landscape, multitouch actions, controller fallback aim | Templates, JDK 17, Android SDK packages, debug/release signing, physical-device tests |
| iOS | Preset, landscape/touch input | macOS and Xcode, templates, team ID, bundle ID/signing and physical-device tests |
| Consoles | Shared action input and GDScript architecture only | Platform developer approval, SDK/devkit, an authorized Godot port/provider, native services and certification |

No console export preset is fabricated. A controller working on PC does not certify
any console. Console storage, user identity, suspend/resume, platform UI and achievement
integration must be implemented against the eventual provider's platform API.

## Controls

- Keyboard: A/D movement, Space jump/double jump, Shift dodge, E interact, M map,
  J journal, I inventory, Q heal, F Rewind after acquisition, Escape pause. Mouse aims,
  left click fires (including in the air), right click uses blade.
- Controller: left stick movement, right stick aim, South jump, East dodge, West
  interact, right trigger fire, right shoulder blade, Start pause; D-pad left/up/right
  selects Root/Bell/Stone in the prototype. Standard UI navigation uses Godot actions.
- Touch: landscape multitouch action buttons, including jump/double jump and combat.
  Rifle aims in Aster's facing direction. Dedicated touch aim controls,
  configurable layouts, cutout-safe margins and a device ergonomics pass are still
  needed. Title screen offers a forced touch preview on desktop.
- Frame is 640x360 with aspect retained. Different screen shapes get letterboxing.
  Final pixel integer scaling, HUD localization and safe-area handling need device QA.

## Validation performed

- All game scripts compile in Godot 4.7.2.
- Sandbox tests cover movement/jump/landing, EE debit, overheat lock/cool and duplicate
  pickup rejection.
- Platform tests cover gamepad bindings, aim fallback, touch preview, pause/resume
  and single-threaded web configuration.
- Release exports completed for Windows, Linux, macOS and Web using Godot 4.7.2 Standard
  export templates. The Web export has not yet been run in a hosted browser.
- Android export is configured but cannot run until JDK 17 and Android SDK
  `platform-tools`/`build-tools` are installed and configured.
- iOS export is configured but requires a developer-supplied Apple Team ID and a Mac/Xcode
  signing workflow.
- Browser/mobile/console runtime tests have not been run.

## Sources and setup

- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html
- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html
- https://docs.godotengine.org/en/stable/about/faq.html

Use Editor > Manage Export Templates for version-matched templates, then Project >
Export to review each preset. Package identifiers are development placeholders and
must be chosen/verified for release. Keep signing credentials outside Git. The current
PC-first V2 direction is expanded by the user's new multiplatform request; story and
combat rules remain unchanged.
