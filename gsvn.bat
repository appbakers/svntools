@echo off

REM simple gradle subversion


REM ###==> create wgets.vbs file done
REM

SET JAVA_HOME | Findstr "JAVA_HOME"
IF ERRORLEVEL 1 (
	ECHO The JAVA_HOME is not defined. Please check java is installed correctly.
	EXIT /B
)

REM where /q jar
REM IF ERRORLEVEL 1 (
REM 	ECHO The jar.exe is not reachable. Please check java is installed.
REM 	EXIT /B
REM )

CALL :getwgets
IF NOT EXIST ".\wgets.vbs" (
	CALL :getwgets
)

IF NOT EXIST ".\svntools.gradle" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/svntools/master/svntools.gradle
	echo "svntools.gradle not exists. downloading..."

	REM run powershell from cmd.exe. (Not Working sometimes so use wget.vbs)
	REM @powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"

	REM ~dp0 : current directory
	REM @call cscript "~dp0wget.vbs" %DOWNURL% svntools.gradle
where wget.exe | Findstr "wget"
IF ERRORLEVEL 0 (
	wget.exe -O svntools.gradle %DOWNURL%  
) ELSE (
	cscript wgets.vbs %DOWNURL% svntools.gradle 
)
	dir svntools.gradle
	IF ERRORLEVEL 1 (
		echo svntools.gradle download failed.
		EXIT /B
		) else (
			echo svntools.gradle downloaded.
		       )
)
IF NOT EXIST ".\gradle\wrapper\gradle-wrapper.jar" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/gradlew.zip/master/gradlew.zip
	echo "gradle-wrapper.jar not exists. downloading..."
	REM run powershell from cmd.exe. (Not Working sometimes so use wget.vbs)
	REM @powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"

	REM ~dp0 : current directory
	REM @call cscript "~dp0wget.vbs" %DOWNURL% gradlew.zip

where wget.exe | Findstr "wget"
IF ERRORLEVEL 0 (
	wget.exe -O gradlew.zip %DOWNURL% && "%JAVA_HOME%\bin\jar" xf gradlew.zip && del gradlew.zip && echo gsvn download is done.
) ELSE (
	cscript wgets.vbs %DOWNURL% gradlew.zip && "%JAVA_HOME%\bin\jar" xf gradlew.zip && del gradlew.zip && echo gsvn download is done.
)

)

GOTO End
:getwgets
echo strUrl = WScript.Arguments.Item(0) > wgets.vbs
echo StrFile = WScript.Arguments.Item(1) >> wgets.vbs
echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wgets.vbs
echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wgets.vbs
echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wgets.vbs
echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wgets.vbs
echo Dim http,varByteArray,strData,strBuffer,lngCounter,fs,ts >> wgets.vbs
echo Err.Clear >> wgets.vbs
echo Set http = Nothing >> wgets.vbs
echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wgets.vbs
echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wgets.vbs
echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wgets.vbs
echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP") >> wgets.vbs
echo http.Open "GET",strURL,False >> wgets.vbs
echo http.Send >> wgets.vbs
echo varByteArray = http.ResponseBody >> wgets.vbs
echo Set http = Nothing >> wgets.vbs
echo Set fs = CreateObject("Scripting.FileSystemObject") >> wgets.vbs
echo Set ts = fs.CreateTextFile(StrFile,True) >> wgets.vbs
echo strData = "" >> wgets.vbs
echo strBuffer = "" >> wgets.vbs
echo For lngCounter = 0 to UBound(varByteArray) >> wgets.vbs
echo ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1,1))) >> wgets.vbs
echo Next >> wgets.vbs
echo ts.Close >> wgets.vbs

:End
IF NOT EXIST ".\gradlew.bat" (
echo gsvn setup failed.
) ELSE (
gradlew.bat --daemon -b .\svntools.gradle %*
)
