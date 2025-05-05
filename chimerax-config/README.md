# ChimeraX dotfiles
Add these to ChimeraX by adding `open ~/.chimerax-config/init.cxc` to the Startup pane of ChimeraX's preferences (`Cmd` + `,` on Mac).

## `init.cxc`
Mostly loads the other `cxc` scripts.
If you want to turn "modules" on/off, add/remove their `open {script}` lines from `init.cxc`.

## `color.cxc`
Defines several color schemes. Check the cxc file for more info.

## `custom-commands.cxc`
Runs python scripts and ChimeraX code to create a few commands you can't do with base ChimeraX:

 * imsave: saves a transparent image to the desktop
 * openser: wrapper to open a volume series from CryoSPARC, assuming it's still in Downloads
 * vplay / vstop: rational defaults for volume series animation
 * locres: color a map by local resolution
 * rot_all: rotate all (or selected) models in a scene around their own center of mass
 * opensep: open volumes in a glob as separate objects, not submodels or a vseries
 * classiter: perframe switching of model and label

## `flex.cxc`

Aliases to play 3D Flex Mesh animations made with the flex mesh Jupyter notebook

## `ui.cxc`

Mostly just that I hate the default select color and width

## `function-keys.cxc`

Set actions for function keys. See the script for bindings.
