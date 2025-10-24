REM ...existing code...
@echo off
setlocal

echo === Compilation et execution de Main ===
echo.

REM Créer le répertoire de sortie
if not exist "build\classes" mkdir build\classes

REM Détecter le framework (jar ou classes) et préparer le classpath des bibliothèques
set "FRAMEWORK_CLASSES=..\Framework\build\classes"
set "FRAMEWORK_JAR=%FRAMEWORK_CLASSES%\FrontServlet.jar"

if exist "%FRAMEWORK_JAR%" (
    set "FRAMEWORK_CP=%FRAMEWORK_JAR%"
) else (
    set "FRAMEWORK_CP=%FRAMEWORK_CLASSES%"
)

REM Inclure toutes les bibliothèques présentes dans test\lib et Framework\lib
set "TEST_LIBS=lib\*;..\Framework\lib\*"

echo Framework classpath: %FRAMEWORK_CP%
echo Libs classpath: %TEST_LIBS%
echo.

REM Compiler Teste.java (nécessite le framework dans le classpath)
echo Compilation de Teste.java...
javac -cp "%FRAMEWORK_CP%;%TEST_LIBS%" -d build\classes src\main\java\Teste.java
if %ERRORLEVEL% NEQ 0 (
    echo Erreur de compilation de Teste.java!
    pause
    exit /b 1
)

REM Compiler Main.java (ajouter les classes compilées locales au classpath)
echo Compilation de Main.java...
javac -cp "%FRAMEWORK_CP%;%TEST_LIBS%;build\classes" -d build\classes src\main\java\Main.java
if %ERRORLEVEL% NEQ 0 (
    echo Erreur de compilation de Main.java!
    pause
    exit /b 1
)

echo Compilation reussie!
echo.
echo === Execution ===
echo.

REM Exécuter Main avec framework et bibliothèques dans le classpath
java -cp "build\classes;%FRAMEWORK_CP%;%TEST_LIBS%" Main

echo.
pause
REM ...existing code...