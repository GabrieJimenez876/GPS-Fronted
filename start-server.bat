@echo off
echo.
echo ========================================
echo GPS Transporte - Servidor
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

REM Verificar si npm está instalado
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: npm no está instalado
    pause
    exit /b 1
)

REM Instalar dependencias si no existen
if not exist "node_modules" (
    echo Instalando dependencias...
    call npm install
    echo.
)

REM Iniciar el servidor
echo Iniciando servidor...
echo.
call npm start

pause
