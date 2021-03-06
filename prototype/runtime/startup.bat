@echo off
set PORT=8080
set CONTEXT=prototype
set WAR=prototype-1.0.0-simplified.war
set JAVA_OPT=-Xms256m -Xmx1024m -XX:MaxPermSize=128m -Dport=%PORT% -Dcontext=%CONTEXT%
if not exist h2 (set JAVA_OPT=%JAVA_OPT% -Djdbc.initialize.database.enable=true) else (set JAVA_OPT=%JAVA_OPT% -Djdbc.initialize.database.enable=false)
echo ---------------------------------------------------------------
echo Prepare to clean temp work dir and restore files...
echo ---------------------------------------------------------------
rm -fr work
mkdir work\webapp
unzip %WAR% -d work\webapp
copy lib\* work\webapp\WEB-INF\lib
echo ---------------------------------------------------------------
echo [INFO] JAVA_OPT=%JAVA_OPT%
echo [INFO] Please wait a moment for startup finish, when you see:
echo [INFO]   ...Started SelectChannelConnector@0.0.0.0:%PORT%...
echo [INFO] then use Firefox to visit the following URL:
echo [INFO] http://localhost:%PORT%/%CONTEXT%
echo ---------------------------------------------------------------
java %JAVA_OPT% -jar %WAR%
