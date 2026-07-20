@echo off
setlocal

cd /d "%~dp0\.."

echo [1/4] Verificando herramientas...
where patrol >nul 2>nul
if errorlevel 1 (
  echo ERROR: No se encontro 'patrol' en PATH.
  exit /b 1
)

where adb >nul 2>nul
if errorlevel 1 (
  echo ERROR: No se encontro 'adb' en PATH.
  exit /b 1
)

where allure >nul 2>nul
if errorlevel 1 (
  echo ERROR: No se encontro 'allure' en PATH.
  exit /b 1
)

echo [2/4] Ejecutando tests Patrol...
patrol test %*
if errorlevel 1 (
  echo ERROR: Patrol test fallo. No se genera reporte.
  exit /b 1
)

echo [3/4] Extrayendo resultados Allure del dispositivo...
if exist allure-results rmdir /s /q allure-results
mkdir allure-results

adb pull /sdcard/allure-results/ .\allure-results\
if errorlevel 1 (
  echo ERROR: No se pudieron extraer resultados desde /sdcard/allure-results/.
  echo Verifica que el runner Allure este configurado y que haya un dispositivo conectado.
  exit /b 1
)

echo [4/4] Generando y abriendo reporte...
allure generate .\allure-results --clean -o .\allure-report
if errorlevel 1 (
  echo ERROR: Fallo la generacion del reporte Allure.
  exit /b 1
)

allure open .\allure-report
if errorlevel 1 (
  echo WARN: No se pudo abrir automaticamente el reporte.
  echo Puedes abrir manualmente allure-report\index.html
)

echo OK: Reporte generado en allure-report\index.html
exit /b 0
