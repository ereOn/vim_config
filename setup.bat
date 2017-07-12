@echo off
setlocal enableextensions
echo Installing Neovim configuration.

set NVIMDATA="%LOCALAPPDATA%\nvim"
if not exist "%NVIMDATA%" md "%NVIMDATA%"
set VIMDATA="%USERPROFILE%\vim"
if not exist "%VIMDATA%" md "%VIMDATA%"

echo Copying init.vim to %NVIMDATA%...
copy init.vim "%NVIMDATA%\init.vim"

echo Copying ginit.vim to %NVIMDATA%...
copy ginit.vim "%NVIMDATA%\ginit.vim"

echo Copying _vimrc to %USERPROFILE%...
copy init.vim "%USERPROFILE%\_vimrc"

echo Installing vim-plug...
powershell -File windows\vim-plug-setup.ps1

REM echo Installing fonts...
REM powershell -File windows\fonts-setup.ps1

echo Setup complete. Enjoy !
endlocal
