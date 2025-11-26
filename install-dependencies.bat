@echo off
echo.
echo ========================================
echo Instalando Dependencias
echo ========================================
echo.

REM Verificar si Node.js está instalado
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js no está instalado
    echo Descárgalo desde: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo Node.js versión:
node --version

echo npm versión:
npm --version
echo.

echo Instalando paquetes npm...
call npm install

echo.
echo ✅ Dependencias instaladas correctamente
echo.
pause
