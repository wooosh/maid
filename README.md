# maid
Maid is a declarative config manager used to provide one config language for all of your config files using jsonnet. 

Warning: Maid **WILL** overwrite your config files if you tell it to. I recommend backing up your configs before using maid.

## Installation
> Eventually maid will switch to a proper install

Maid only requires the golang compiler to be installed.
```
git clone https://github.com/wooosh/maid ~/.config/maid
cd ~/.config/maid
go build
```

## Usage
1. Edit config.jsonnet (not maid.jsonnet!) and/or any of the modules present in modules/
2. Install the new configuration:
```
~/.config/maid
```

## config.jsonnet
TODO

## Making modules
TODO
