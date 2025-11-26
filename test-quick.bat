@echo off
REM Test rápido de que todo funciona
cls
echo.
echo ========================================
echo PRUEBA RÁPIDA - GPS Transporte
echo ========================================
echo.

setlocal enabledelayedexpansion

REM Test 1: Node.js
echo [1/5] Probando Node.js...
node --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✅ Node.js OK
) else (
    echo ❌ Node.js FALLA
    goto error
)

REM Test 2: npm
echo [2/5] Probando npm...
npm --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✅ npm OK
) else (
    echo ❌ npm FALLA
    goto error
)

REM Test 3: server.js existe
echo [3/5] Verificando server.js...
if exist "server.js" (
    echo ✅ server.js OK
) else (
    echo ❌ server.js NO ENCONTRADO
    goto error
)

REM Test 4: package.json existe
echo [4/5] Verificando package.json...
if exist "package.json" (
    echo ✅ package.json OK
) else (
    echo ❌ package.json NO ENCONTRADO
    goto error
)

REM Test 5: node_modules existe
echo [5/5] Verificando dependencias...
if exist "node_modules" (
    echo ✅ node_modules OK
) else (
    echo ⚠️  node_modules NO ENCONTRADO
    echo    Ejecuta: install-dependencies.bat
    goto warning
)

echo.
echo ========================================
echo ✅ TODO OK - Listo para iniciar
echo ========================================
echo.
echo Ejecuta: start-server.bat
echo.
pause
exit /b 0

:warning
echo.
echo ⚠️  Advertencia: Se recomienda instalar dependencias
echo.
pause
exit /b 1

:error
echo.
echo ❌ ERROR: Hay problemas de configuración
echo Consulta SETUP.md para más detalles
echo.
pause
exit /b 1
