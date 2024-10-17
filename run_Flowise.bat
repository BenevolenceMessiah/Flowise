@echo off
setlocal

:::  ________  _______   ________   _______   ___      ___ ________  ___       _______   ________   ________  _______      
::: |\   __  \|\  ___ \ |\   ___  \|\  ___ \ |\  \    /  /|\   __  \|\  \     |\  ___ \ |\   ___  \|\   ____\|\  ___ \     
::: \ \  \|\ /\ \   __/|\ \  \\ \  \ \   __/|\ \  \  /  / | \  \|\  \ \  \    \ \   __/|\ \  \\ \  \ \  \___|\ \   __/|    
:::  \ \   __  \ \  \_|/_\ \  \\ \  \ \  \_|/_\ \  \/  / / \ \  \\\  \ \  \    \ \  \_|/_\ \  \\ \  \ \  \    \ \  \_|/__  
:::   \ \  \|\  \ \  \_|\ \ \  \\ \  \ \  \_|\ \ \    / /   \ \  \\\  \ \  \____\ \  \_|\ \ \  \\ \  \ \  \____\ \  \_|\ \ 
:::    \ \_______\ \_______\ \__\\ \__\ \_______\ \__/ /     \ \_______\ \_______\ \_______\ \__\\ \__\ \_______\ \_______\
:::     \|_______|\|_______|\|__| \|__|\|_______|\|__|/       \|_______|\|_______|\|_______|\|__| \|__|\|_______|\|_______|
::: 
:::  _____ ______   _______   ________   ________  ___  ________  ___  ___     
::: |\   _ \  _   \|\  ___ \ |\   ____\ |\   ____\|\  \|\   __  \|\  \|\  \    
::: \ \  \\\__\ \  \ \   __/|\ \  \___|_\ \  \___|\ \  \ \  \|\  \ \  \\\  \   
:::  \ \  \\|__| \  \ \  \_|/_\ \_____  \\ \_____  \ \  \ \   __  \ \   __  \  
:::   \ \  \    \ \  \ \  \_|\ \|____|\  \\|____|\  \ \  \ \  \ \  \ \  \ \  \ 
:::    \ \__\    \ \__\ \_______\____\_\  \ ____\_\  \ \__\ \__\ \__\ \__\ \__\
:::     \|__|     \|__|\|_______|\_________\\_________\|__|\|__|\|__|\|__|\|__|
:::                             \|_________\|_________|
::: ___  ________   ________  _________  ________  ___       ___       _______   ________     
::: |\  \|\   ___  \|\   ____\|\___   ___\\   __  \|\  \     |\  \     |\  ___ \ |\   __  \    
::: \ \  \ \  \\ \  \ \  \___|\|___ \  \_\ \  \|\  \ \  \    \ \  \    \ \   __/|\ \  \|\  \   
:::  \ \  \ \  \\ \  \ \_____  \   \ \  \ \ \   __  \ \  \    \ \  \    \ \  \_|/_\ \   _  _\  
:::   \ \  \ \  \\ \  \|____|\  \   \ \  \ \ \  \ \  \ \  \____\ \  \____\ \  \_|\ \ \  \\  \| 
:::    \ \__\ \__\\ \__\____\_\  \   \ \__\ \ \__\ \__\ \_______\ \_______\ \_______\ \__\\ _\ 
:::     \|__|\|__| \|__|\_________\   \|__|  \|__|\|__|\|_______|\|_______|\|_______|\|__|\|__|
:::                    \|_________|

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

timeout /t 3

:Menu1
echo ---------------------------------------------------------------
echo Please choose from the following options:
echo Note:
echo - These options are all case sensitive.
echo - Make sure Docker Desktop is up and running on your system
echo   if you want to use Docker.
echo - NodeJS >= 18.15.0 is required.
echo - Press Ctrl+c to exit at any time!
echo ---------------------------------------------------------------
echo 1) Install
echo 2) Run
echo 3) Run via Docker
echo X) Install Python, Git, Docker, and/or NodeJS.
echo C) Exit
:: echo U) Update repo.
echo ---------------------------------------------------------------

set /P option=Enter your choice:
if %option% == 1 goto Install
if %option% == 2 goto Run
if %option% == 2 goto RunDocker
if %option% == X goto Python/GitInstall
if %option% == C goto End
:: if %option% == U goto Updater

:Install
echo ---------------------------------------------------------------
echo Creating virtual environment
echo ---------------------------------------------------------------
if not exist venv (
    py -3.10 -m venv .venv
) else (
    echo Existing venv detected. Activating.
)
echo Activating virtual environment
call .venv\Scripts\activate
echo --------------------------------------------------------------
echo DO NOT PROCEED UNLESS YOU HAVE: NodeJS >= 18.15.0
echo --------------------------------------------------------------
timeout /t -1
python.exe -m pip install --upgrade pip
npm install -g flowise
docker build --no-cache -t flowise .
echo Installation Complete!
echo --------------------------------------------------------------
timeout /t -1
goto Menu1

:Run
echo ---------------------------------------------------------------
echo Firing up the server...
echo ---------------------------------------------------------------
if not exist venv (
    py -3.10 -m venv .venv
) else (
    echo Existing venv detected. Activating.
)
echo Activating virtual environment
call .venv\Scripts\activate
echo ---------------------------------------------------------------
start call npx flowise start
goto Menu1

:RunDocker
echo ---------------------------------------------------------------
echo Firing up the server...
echo ---------------------------------------------------------------
if not exist venv (
    py -3.10 -m venv .venv
) else (
    echo Existing venv detected. Activating.
)
echo Activating virtual environment
call .venv\Scripts\activate
echo ---------------------------------------------------------------
start call docker run -d --name flowise -p 3000:3000 flowise
goto Menu1

:Python/GitInstall
echo ---------------------------------------------------------------
echo As-salamu alaykum!!
echo What do you need to install?
echo ---------------------------------------------------------------
echo 4) Install Docker Desktop
echo 9) Install Git.
echo 10) Install Python 3.10. (Make sure to enable PATH)!
echo M) Main Menu
echo R) Restart the .bat file (do this after installing any or all of these).
echo C) Exit
echo ---------------------------------------------------------------

set /P option=Enter your choice:
if %option% == 4 goto DockerDesktop
if %option% == 5 goto NodeJS
if %option% == 9 goto GitInstall
if %option% == 10 goto PythonInstall
if %option% == R goto RestartCMD
if %option% == M goto Menu1
if %option% == C goto End

:DockerDesktop
echo Installing Docker Desktop
echo ---------------------------------------------------------------
cd /d %~dp0
call curl "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module" -o docker-desktop-installer.exe
start call docker-desktop-installer.exe
echo Once the install is complete, continue.
echo ---------------------------------------------------------------
timeout /t -1
echo Restarting...
echo Deleting installer .exe file if it exists...
echo ---------------------------------------------------------------
if exist docker-desktop-installer.exe del docker-desktop-installer.exe
start call run_Flowise.bat
exit

:NodeJS
echo Installing NodeJS
echo ---------------------------------------------------------------
cd /d %~dp0
call curl "https://nodejs.org/dist/v20.18.0/node-v20.18.0-x64.msi" -o node-v20.18.0-x64.msi
start call node-v20.18.0-x64.msi
echo Once the install is complete, continue.
echo ---------------------------------------------------------------
timeout /t -1
echo Restarting...
echo Deleting installer .exe file if it exists...
echo ---------------------------------------------------------------
if exist node-v20.18.0-x64.msi del node-v20.18.0-x64.msi
start call run_Flowise.bat
exit

:GitInstall
echo Installing Git...
echo ---------------------------------------------------------------
cd /d %~dp0
call curl "https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe" -o Git-2.46.0-64-bit.exe
start call Git-2.46.0-64-bit.exe
goto Python/GitInstall

:PythonInstall
echo Installing Python 3.10...
echo ---------------------------------------------------------------
cd /d %~dp0
call curl "https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe" -o python-3.10.6-amd64.exe
start call python-3.10.6-amd64.exe
goto Python/GitInstall

:RestartCMD
echo Restarting...
echo Deleting installer .exe files if they exist...
echo ---------------------------------------------------------------
if exist Git-2.46.0-64-bit.exe del Git-2.46.0-64-bit.exe
if exist python-3.10.6-amd64.exe del python-3.10.6-amd64.exe
start call AI-Web-UI.bat
exit

:End 
echo ---------------------------------------------------------------
echo As-salamu alaykum!!
echo ---------------------------------------------------------------
pause
