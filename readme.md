nix-cage
--------------

fork of [this repo](https://github.com/corpix/nix-cage) that is not compatible with original one any more.

Simple Sandboxed environments with `bwrap`.

## Requirements

- Python
- Bubblewrap
- Nix

## Basics

Unlike the original repo, this fork is more about creating ad-hoc sandboxes and is not revolving around `shell.nix`

You can just run

`nix-cage -- bash`

With this you will enter a bash shell in a simple sandbox environment, where among other things, your home will be a tmpfs,
and current directory, in where you ran the comand above, will be binded to `~/workspace` inside the sandbox.

Sometimes you don't want the sandbox home to be tmpfs, in that case you can create an empty directory `nixcage_home` in your current directory,
then this dir will be instead binded to user home inside the sandbox, and all changes to the contents of home dir inside the sandbox will be
persistant and available in that `nixcage_home` dir from outside of the sandbox.

### Commonly helpful flags

Default sandbox is not very permissive, including that it does not allow running of any kind of graphical or audio apps.

If you want to enable that - you can provide one or more of the following flags to the command line

- `--x11` Allow x11 apps. Will bind `/tmp/.x11-unix` and whatever `XAUTHORITY` env var is pointing to
- `--wayland` Allow wayland apps. Will bind wayland socket in /run
- `--pulseaudio` Allow pulseaudio. Will bind pulseaudio socket in /run
- `--dri` Allow access to gpu for hardware acceleration. Will bind `/dev/dri` dir into the sandbox

## Advanced use

You can specify additional file bindings and custom commands to run using configuration file (`nix-cage.json`)

This way you can easily implement simple sandboxing for any particular project.

Running just `nix-cage` will look for the config file in current directory and all dirs above and do whatever thise configurations say.
Passing arguments can still override any of the config values.

## License

[Unlicense](https://unlicense.org/)
