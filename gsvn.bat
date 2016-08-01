REM simple gradle subversion

REM below codes are not tested on windows environment yet !!!

REM ###==> create wget.vbs file

echo strUrl = WScript.Arguments.Item(0) > wget.vbs
echo StrFile = WScript.Arguments.Item(1) >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wget.vbs
echo Dim http,varByteArray,strData,strBuffer,lngCounter,fs,ts >> wget.vbs
echo Err.Clear >> wget.vbs
echo Set http = Nothing >> wget.vbs
echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wget.vbs
echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wget.vbs
echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wget.vbs
echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP") >> wget.vbs
echo http.Open "GET",strURL,False >> wget.vbs
echo http.Send >> wget.vbs
echo varByteArray = http.ResponseBody >> wget.vbs
echo Set http = Nothing >> wget.vbs
echo Set fs = CreateObject("Scripting.FileSystemObject") >> wget.vbs
echo Set ts = fs.CreateTextFile(StrFile,True) >> wget.vbs
echo strData = "" >> wget.vbs
echo strBuffer = "" >> wget.vbs
echo For lngCounter = 0 to UBound(varByteArray) >> wget.vbs
echo ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1,1))) >> wget.vbs
echo Next >> wget.vbs
echo ts.Close >> wget.vbs

REM ###==> create wget.vbs file done

where /q jar
IF ERRORLEVEL 1 (
	ECHO The jar.exe is not reachable. Please check java is installed.
	EXIT /B
)


IF NOT EXIST ".\svntools.gradle" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/svntools/master/svntools.gradle
	echo "svntools.gradle not exists. downloading..."

	REM run powershell from cmd.exe. (Not Working sometimes so use wget.vbs)
	REM @powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"

	REM ~dp0 : current directory
	REM @call cscript "~dp0wget.vbs" %DOWNURL% svntools.gradle

	cmd.exe /c cscript wget.vbs %DOWNURL% svntools.gradle && echo svntools.gradle downloaded.
)
IF NOT EXIST ".\gradle\wrapper\gradle-wrapper.jar" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/gradlew.zip/master/gradlew.zip
	echo "gradle-wrapper.jar not exists. downloading..."
	REM run powershell from cmd.exe. (Not Working sometimes so use wget.vbs)
	REM @powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"

	REM ~dp0 : current directory
	REM @call cscript "~dp0wget.vbs" %DOWNURL% gradlew.zip

	cmd.exe /c cscript wget.vbs %DOWNURL% gradlew.zip && jar xfM gradlew.zip && delete gradlew.zip && echo gsvn setup is done.
)


gradlew.bat --daemon -b .\svntools.gradle %*
