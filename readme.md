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

```
nix-cage
```

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

You can specify additional file bindings and custom commands to run using configuration file (`nix-cage.json`).
You can generate a `nix-cage.json` using the following command:

```
nix-cage --write-default-config
```

This way you can easily implement simple sandboxing for any particular project.

Running just `nix-cage` will look for the config file in current directory and all dirs above and do whatever thise configurations say.
Passing arguments can still override any of the config values.

## TODOs

- Minimize inherited environment variables.
- Allow failure option for mounts
- Option to copy instead of mount (but don't overwrite)
- BUG: when inside a `nix-shell`, running `nix-shell` in the cage results in `error: creating directory '/tmp/nix-shell.0a8nM7/nix-shell-2-0': No such file or directory`. This is probably due to the temporary directory env vars:
    ```
    env |grep tmp
    TEMPDIR=/tmp/nix-shell.v6TFSv
    TMPDIR=/tmp/nix-shell.v6TFSv
    TEMP=/tmp/nix-shell.v6TFSv
    NIX_BUILD_TOP=/tmp/nix-shell.v6TFSv
    TMP=/tmp/nix-shell.v6TFSv
    ```
    One fix could be to not inherit TMPDIR variables.

## License

[Unlicense](https://unlicense.org/)
