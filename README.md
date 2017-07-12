Neovim configuration
====================

Installation
------------

### Windows

1. Install Neovim by following [these
   instructions](https://github.com/neovim/neovim/wiki/Installing-Neovim).
2. Update Neovim Qt by installing (and overriding) with the [latest
   release](https://github.com/equalsraf/neovim-qt/releases).
3. Put those in your `PATH`.
3. Run `setup.bat`.
4. Enjoy !

### Python support

The default `init.vim` relies on `PYTHON2` and `PYTHON3` environment variables
to be point to respectively a Python 2 and Python 3 installation. Those can be
virtualenvs.

The `neovim` package **MUST** be installed in those virtualenvs.
