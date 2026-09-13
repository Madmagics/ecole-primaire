@echo off
setlocal enabledelayedexpansion

rem Se place dans le dossier ou se trouve ce fichier .bat (donc la racine du projet,
rem si tu le laisses a cote de project.godot), peu importe d'ou tu le lances.
cd /d "%~dp0"

echo ================================================
echo   Envoi des modifications vers GitHub
echo ================================================
echo Dossier : %cd%
echo.

echo [1/4] Preparation des fichiers modifies...
git add -A

echo.
set "msg="
set /p "msg=Message du commit (laisse vide pour un message par defaut) : "
if "!msg!"=="" set "msg=Mise a jour du jeu"

echo.
echo [2/4] Creation du commit...
git commit -m "!msg!"
if errorlevel 1 (
    echo   ^(Rien de nouveau a valider - ou le commit a echoue. On continue quand meme,
    echo    au cas ou d'anciens commits locaux ne seraient pas encore envoyes.^)
)

echo.
echo [3/4] Recuperation des dernieres modifications du serveur...
git pull --no-edit
if errorlevel 1 (
    echo.
    echo ================================================
    echo   ATTENTION : le "git pull" a echoue - probablement un conflit.
    echo   Le script s'arrete ici. Ouvre PowerShell dans ce dossier et
    echo   demande de l'aide pour resoudre la situation avant de reessayer.
    echo ================================================
    pause
    exit /b 1
)

echo.
echo [4/4] Envoi vers GitHub...
git push

echo.
echo ================================================
if errorlevel 1 (
    echo   Le push a echoue - regarde le message d'erreur ci-dessus.
) else (
    echo   Termine ! Le site va se reconstruire automatiquement dans
    echo   quelques minutes ^(regarde l'onglet "Actions" sur GitHub si tu
    echo   veux confirmer que ca s'est bien passe^).
)
echo ================================================
echo.
pause
