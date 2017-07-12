@echo off
setlocal enableextensions
echo Installing Neovim configuration.

set NVIMDATA="%LOCALAPPDATA%\nvim"
if not exist "%NVIMDATA%" md "%NVIMDATA%"

echo Copying init.vim to %NVIMDATA%...
copy init.vim "%NVIMDATA%\init.vim"

echo Copying ginit.vim to %NVIMDATA%...
copy ginit.vim "%NVIMDATA%\ginit.vim"

echo Installing vim-plug...
powershell -File windows\vim-plug-setup.ps1

REM echo Installing fonts...
REM powershell -File windows\fonts-setup.ps1

echo Setup complete. Enjoy !
endlocal
