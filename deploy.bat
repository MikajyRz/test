@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%
set TOMCAT_HOME=C:\tomcat\apache-tomcat-10.1.28
set APP_NAME=Sprint1
set FRAMEWORK_DIR=..\framework

echo Création du dossier build...
mkdir build 2>nul
mkdir build\WEB-INF 2>nul
mkdir build\WEB-INF\classes 2>nul
mkdir build\WEB-INF\lib 2>nul

echo Copie des fichiers webapp depuis framework et test...
xcopy %FRAMEWORK_DIR%\src\main\webapp\*.jsp build /Y
xcopy %FRAMEWORK_DIR%\src\main\webapp\*.css build /Y
xcopy src\main\webapp\WEB-INF build\WEB-INF /E /Y
rem Copier aussi les fichiers statiques du projet test (html, css, js, images)
xcopy src\main\webapp\*.html build /Y
xcopy src\main\webapp\*.css build /Y
xcopy src\main\webapp\*.js build /Y
xcopy src\main\webapp\images build\images /E /Y
xcopy src\main\webapp\assets build\assets /E /Y

echo Copie des bibliothèques dans build\WEB-INF\lib...
copy lib\*.jar build\WEB-INF\lib
if %ERRORLEVEL% neq 0 (
    echo Erreur : Échec de la copie des bibliothèques vers build\WEB-INF\lib
    exit /b 1
)

echo Compilation des sources Java du projet test (pour générer les .class)...
if exist src\main\java (
    rem Compiler tous les .java sous src\main\java avec le classpath des libs locales
    for /R src\main\java %%f in (*.java) do (
        echo Compilation: %%f
        javac -cp lib\* -d build\WEB-INF\classes "%%f"
        if %ERRORLEVEL% neq 0 (
            echo Erreur : Échec de la compilation de %%f
            exit /b 1
        )
    )
) else (
    echo Aucun dossier src\main\java détecté, étape de compilation ignorée.
)

echo Création du fichier WAR...
cd build
jar cvf %APP_NAME%.war .
if %ERRORLEVEL% neq 0 (
    echo Erreur : Échec de la création du fichier WAR
    cd ..
    exit /b 1
)
cd ..

echo Déploiement du WAR dans Tomcat...
copy build\%APP_NAME%.war "%TOMCAT_HOME%\webapps"
if %ERRORLEVEL% neq 0 (
    echo Erreur : Échec du déploiement du WAR dans Tomcat
    exit /b 1
)

echo Déploiement terminé.