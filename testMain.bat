@echo off
setlocal enabledelayedexpansion

echo ======================================
echo Test de Main.java
echo ======================================

REM Configuration
set FRAMEWORK_SRC=..\framework\src
set FRAMEWORK_BUILD=framework_build
set FRAMEWORK_JAR=framework.jar
set TEST_JAVA=java
set SERVLET_API_JAR=..\framework\lib\servlet-api.jar
set TEST_BUILD=test_build

REM Créer le dossier de build
if exist "%TEST_BUILD%" rmdir /s /q "%TEST_BUILD%"
mkdir "%TEST_BUILD%"

echo.
echo 1) Compilation du framework...
if exist "%FRAMEWORK_BUILD%" rmdir /s /q "%FRAMEWORK_BUILD%"
mkdir "%FRAMEWORK_BUILD%"

dir /s /b "%FRAMEWORK_SRC%\*.java" > sources_framework.txt 2>nul
if exist sources_framework.txt (
    javac -cp "%SERVLET_API_JAR%" -d "%FRAMEWORK_BUILD%" @sources_framework.txt
    if !errorlevel! equ 0 (
        echo ✅ Framework compilé
        jar -cvf "%FRAMEWORK_JAR%" -C "%FRAMEWORK_BUILD%" . >nul
    ) else (
        echo ❌ Erreur de compilation du framework
        del sources_framework.txt
        goto :error
    )
    del sources_framework.txt
) else (
    echo ❌ Aucun fichier Java trouvé dans %FRAMEWORK_SRC%
    goto :error
)

echo.
echo 2) Compilation des fichiers de test...
dir /s /b "%TEST_JAVA%\*.java" > sources_test.txt 2>nul
if exist sources_test.txt (
    findstr /r "." sources_test.txt >nul 2>&1
    if !errorlevel! equ 0 (
        javac -cp "%SERVLET_API_JAR%;%FRAMEWORK_JAR%" -d "%TEST_BUILD%" @sources_test.txt
        if !errorlevel! equ 0 (
            echo ✅ Fichiers de test compilés
        ) else (
            echo ❌ Erreur lors de la compilation des test
            del sources_test.txt
            goto :error
        )
    ) else (
        echo ❌ Aucun fichier Java trouvé dans %TEST_JAVA%\
        del sources_test.txt
        goto :error
    )
    del sources_test.txt
) else (
    echo ❌ Aucun fichier de test trouvé dans %TEST_JAVA%\
    goto :error
)

echo.
echo 3) Exécution de Main...
echo ======================================
echo Résultat attendu : affichage des URLs des méthodes annotées avec @HandleUrl
echo.
java -cp "%TEST_BUILD%;%FRAMEWORK_JAR%" test.java.Main
echo.
echo ======================================
echo.

if !errorlevel! equ 0 (
    echo ✅ Test terminé avec succès
) else (
    echo ❌ Erreur lors de l'exécution
)

goto :end

:error
echo.
echo ❌ Le test a échoué
echo.

:end
echo.
pause

