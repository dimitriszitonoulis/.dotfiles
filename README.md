# dotfiles

This repository contains all my dotfiles.

Dotfiles are configuration files for applications.
They can be used to replicate the configuration of an app between machines.

## How to use

Install `stow`, a utility for creating symlinks.

Clone the repo with the command:

```bash
git clone https://github.com/dimitriszitonoulis/.dotfiles.git
```

Enter the `.dotfiles` directory and use stow to create symlinks

```bash
cd .dotfiles
stow .
```

This will create symbolic links for the files inside `.dotfiles`
in the parent directory using the same file structure of the `.dotfiles` directory.

For example, let's say that we have the following file structure:

```bash

/home/dim
├── .config
└── .dotfiles
    └── .config
        └── nvim
```

Running `stow .` inside the `.dotfiles` directory will result in a symlink
being create in `~/.config` pointing to `~/.dotfiles/.config/nvim`

```bash
~
├── .config
│   └── nvim -> ../.dotfiles/.config/nvim
└── .dotfiles
    └── .config
        └── nvim
```

If the directory already existed in `~/.config/nvim`

```bash
~
├── .config
│   └── nvim
└── .dotfiles
    └── .config
```

You can place it inside `~/.dotfiles/.config` and create the symlink
by running the following command in `~/.dotfiles`:

```bash
stow --adopt .
```

If the directory `~/.dotfiles/.config/nvim` already existed
it will be replaced with the one under `~/.config`.

For more info on how stow works read: [stow](https://www.gnu.org/software/stow/manual/stow.html)
