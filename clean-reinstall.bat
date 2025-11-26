@echo off
echo.
echo ========================================
echo Limpiar y Reinstalar Dependencias
echo ========================================
echo.

echo Este script eliminará node_modules y reinstalará todo.
echo.
set /p confirm="¿Estás seguro? (s/n): "
if /i NOT "%confirm%"=="s" (
    echo Cancelado.
    pause
    exit /b 0
)

echo.
echo Eliminando node_modules...
if exist "node_modules" (
    rmdir /s /q "node_modules"
    echo ✅ node_modules eliminado
) else (
    echo ℹ️  node_modules no existe
)

echo.
echo Eliminando package-lock.json...
if exist "package-lock.json" (
    del "package-lock.json"
    echo ✅ package-lock.json eliminado
) else (
    echo ℹ️  package-lock.json no existe
)

echo.
echo Reinstalando dependencias...
call npm install

echo.
echo ✅ Limpiareza completada
echo.
pause
