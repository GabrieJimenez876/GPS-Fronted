@echo off
echo.
echo ========================================
echo Verificador de Configuración
echo GPS Transporte - La Paz
echo ========================================
echo.

setlocal enabledelayedexpansion

REM Verificar Node.js
echo Verificando Node.js...
where node >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Node.js instalado
    node --version
) else (
    echo ❌ Node.js NO instalado - Descárgalo desde https://nodejs.org/
)
echo.

REM Verificar npm
echo Verificando npm...
where npm >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ npm instalado
    npm --version
) else (
    echo ❌ npm NO instalado
)
echo.

REM Verificar si node_modules existe
echo Verificando dependencias instaladas...
if exist "node_modules" (
    echo ✅ Dependencias instaladas (carpeta node_modules existe)
) else (
    echo ⚠️  Dependencias NO instaladas
    echo Ejecuta: install-dependencies.bat
)
echo.

REM Verificar archivos principales
echo Verificando archivos principales...
if exist "server.js" (
    echo ✅ server.js encontrado
) else (
    echo ❌ server.js NO encontrado
)

if exist "index.html" (
    echo ✅ index.html encontrado
) else (
    echo ❌ index.html NO encontrado
)

if exist "package.json" (
    echo ✅ package.json encontrado
) else (
    echo ❌ package.json NO encontrado
)
echo.

REM Verificar Flutter (opcional)
echo Verificando Flutter (opcional)...
where flutter >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Flutter instalado
    flutter --version
) else (
    echo ℹ️  Flutter NO instalado (solo necesario para la app móvil)
)
echo.

echo ========================================
echo Resumen:
echo ========================================
echo Si todos los checks pasaron, estás listo para:
echo   1. Ejecutar: npm install (si no lo has hecho)
echo   2. Ejecutar: npm start
echo   3. Abre: http://localhost:3000
echo.
pause
