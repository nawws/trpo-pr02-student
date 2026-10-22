@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo === Practical work 2: commit and push ===

if not exist "..\dataset\catalog.csv" (
  echo ERROR: folder ..\dataset not found. Put this project folder next to "dataset".
  pause
  exit /b 1
)

echo Copying dataset...
xcopy "..\dataset" "dataset\" /E /I /Y >nul
copy /Y "..\dataset\assets\product-0*.svg" "images\" >nul
copy /Y "..\dataset\catalog.csv" "data\" >nul
copy /Y "..\dataset\theme.json" "data\" >nul

if exist ".git" rmdir /s /q ".git"
git init -q
git config user.name "nawws"
git config user.email "batyrbekov387@gmail.com"
git config http.sslBackend openssl

git add .gitignore package.json dataset push.bat
git commit -q -m "chore: add project structure, dataset and sass build config"
git add index.html data images
git commit -q -m "feat: add catalog markup with 18 cards from catalog.csv"
git add css
git commit -q -m "feat: add grid/flexbox catalog layout and breakpoints (compiled css)"
git add scss
git commit -q -m "refactor: move styles to SCSS partials with variables, mixins and functions"
git add README.md
git commit -q -m "docs: add README with build commands, structure and SCSS notes"
git log --oneline

git branch -M main
git remote add origin https://github.com/nawws/trpo-pr02-student.git
echo.
echo Pushing to GitHub (sign in as nawws if asked)...
git push -u origin main --force
if errorlevel 1 (
  echo.
  echo PUSH FAILED. Check internet/VPN and run push.bat again.
) else (
  echo.
  echo DONE: https://github.com/nawws/trpo-pr02-student
)
pause
