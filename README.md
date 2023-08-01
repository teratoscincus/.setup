# Post OS install setup script

Setup my personal system, and currently only works on voidlinux.

## Usage:

Ensure the current working directory is the root of this repo, as in the same directory
as this file.\
Then:

```bash
./setup.sh
```

## File structure

```bash
./
├── resources/
│   └── distro/
│       └── void/             # Dir named after distro
│           └── packages.txt  # List of packages for the distros package manager
├── src/
│   ├── services/
│   │   └── runit/            # Dir named after init system
│   │       └── services.sh   # Script that enables services
│   └── tools/                # All files in this dir are sourced
│       └── rtx.sh            # Setup script specific to a tool
├── README.md
└── setup.sh*                 # Main script
```

## Setting up additional tools

Simply add a bash script in `./src/tools/` and it will be run by `./setup.sh`
automatically.
