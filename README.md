## DEPENDENCIES

- Haxe (version 4 preview 5)
- HashLink (version 1.8)
- `haxelib install heaps`
- `haxelib install hlsdl`

## COMPILE

Run `./run` to compile a .hl file and run it in a HashLink VM.

Run `./compile` to compile an executable. Make sure links in the `compile` file are correctly pointing to HashLink's .hdll files and a libhl.dylib.

## NOTES

- Heaps 1.5.0 has a bug preventing h2d.Text from rendering to texture. For now it can be fixed by removing `, false` in `h2d/Text.h:103`
