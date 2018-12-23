# Nix Tools

This is an experiment for running tools via containers (So I do not have to install anything).
Ideally scripts/tools (in `bin`) are callable from my IDE (in place of the real binaries).

## Shortcut

```nano ~/.bashrc```

and add something like:

```bash
# Nix Tools
export PATH=~/repos/gitlab.com/jeremy-sells/nix-tools/bin:$PATH
```

## Updating

Call `nix-tools-update.sh` to update everything.

## Running

All tools in the "bin" folder are 
