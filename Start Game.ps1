param([switch]$Editor)
$enginePath = 'C:\Users\ashek\Documents\Godot_v4.7.2-stable_win64.exe\Godot_v4.7.2-stable_win64.exe'
if (-not (Test-Path -LiteralPath $enginePath)) { throw 'Godot not found. Open project.godot in Godot 4.7.2.' }
$arguments = @('--path', $PSScriptRoot)
if ($Editor) { $arguments += '--editor' }
& $enginePath @arguments
