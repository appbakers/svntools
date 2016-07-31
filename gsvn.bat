REM simple gradle subversion

REM below codes are not tested on windows environment yet !!!

IF NOT EXIST ".\svntools.gradle" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/svntools/master/svntools.gradle
	echo "svntools.gradle not exists. downloading..."
	@powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"
)
IF NOT EXIST ".\gradle\wrapper\gradle-wrapper.jar" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/gradlew.zip/master/gradlew.zip
	echo "gradle-wrapper.jar not exists. downloading..."
	@powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"
)


gradlew.bat --daemon -b .\svntools.gradle %*
