@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ======================================
echo 1) V├®rification de la structure
echo ======================================
set FRAMEWORK_SRC=..\framework
echo Recherche des fichiers framework...
if exist "%FRAMEWORK_SRC%\src\com\framework\FrontServlet.java" (
    echo Ô£à Fichiers framework trouv├®s dans: %FRAMEWORK_SRC%
) else (
    echo ÔÜá´©Å Fichiers framework introuvables
    exit /b 1
)

echo ======================================
echo 2) Compilation du framework
echo ======================================
echo Compilation du framework...
if exist "%FRAMEWORK_SRC%" (
    if not exist framework_build mkdir framework_build
    javac -d framework_build -cp "%FRAMEWORK_SRC%\lib\servlet-api.jar" "%FRAMEWORK_SRC%\src\com\framework\*.java" "%FRAMEWORK_SRC%\src\com\annotations\*.java"
    if errorlevel 1 (
        echo ÔÜá´©Å Erreur lors de la compilation du framework
        exit /b 1
    )
    
    cd framework_build
    jar cf framework.jar com
    move framework.jar ..\
    cd ..
    echo Ô£à Framework compil├® : framework.jar
) else (
    echo ÔÜá´©Å Dossier framework introuvable: %FRAMEWORK_SRC%
    exit /b 1
)

echo ======================================
echo 3) Compilation des fichiers de test
echo ======================================
echo Nettoyage des anciennes classes...
if exist webapp\WEB-INF\classes rmdir /s /q webapp\WEB-INF\classes 2>nul
mkdir webapp\WEB-INF\classes
echo Compilation des classes Java de test...
dir /s /b java\*.java > sources_test.txt 2>nul
if exist sources_test.txt (
    findstr /r "." sources_test.txt >nul 2>&1
    if !errorlevel! equ 0 (
        javac -cp "..\framework\lib\servlet-api.jar;framework.jar" -d webapp\WEB-INF\classes @sources_test.txt
        if !errorlevel! equ 0 (
            echo Ô£à Fichiers de test compilés
        ) else (
            echo ÔÜá´©Å Erreur lors de la compilation des test
            del sources_test.txt
            exit /b 1
        )
    ) else (
        echo ÔÜá´©Å Aucun fichier Java trouvé dans java\
        del sources_test.txt
        exit /b 1
    )
    del sources_test.txt
) else (
    echo ÔÜá´©Å Aucun fichier de test trouvé dans java\
    exit /b 1
)

echo ======================================
echo 4) Pr├®paration du projet test
echo ======================================
echo Cr├®ation de la structure WEB-INF...
if not exist webapp\WEB-INF\lib mkdir webapp\WEB-INF\lib

echo Copie du framework dans WEB-INF\lib...
copy framework.jar webapp\WEB-INF\lib\ >nul
del webapp\WEB-INF\lib\servlet-api.jar 2>nul
echo Ô£à Framework JAR copi├® dans WEB-INF\lib

echo ======================================
echo 5) G├®n├®ration du WAR
echo ======================================
if not exist build mkdir build
cd webapp
jar cf ..\build\Vraiappli.war *
cd ..
echo Ô£à WAR g├®n├®r├® : build\Vraiappli.war

echo ======================================
echo 6) V├®rification du contenu
echo ======================================
if exist "framework_build\com\framework\FrontServlet.class" (
    echo Ô£à FrontServlet.class trouv├®
) else (
    echo ÔÜá´©Å FrontServlet.class introuvable
    echo Classes trouv├®es dans framework_build:
    dir framework_build /s /b
)

echo ======================================
echo 7) D├®ploiement dans Tomcat
echo ======================================
set TOMCAT_HOME=C:\tomcat\apache-tomcat-10.1.28
if exist "%TOMCAT_HOME%\webapps\Vraiappli.war" (
    echo Suppression de l'ancienne version...
    del "%TOMCAT_HOME%\webapps\Vraiappli.war"
    rmdir /s /q "%TOMCAT_HOME%\webapps\Vraiappli" 2>nul
)

copy build\Vraiappli.war "%TOMCAT_HOME%\webapps\"
echo Ô£à Application d├®ploy├®e dans Tomcat
echo.
echo Ô£à Application disponible sur : http://localhost:8080/Vraiappli/
echo.

pause