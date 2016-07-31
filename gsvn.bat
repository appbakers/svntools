REM simple gradle subversion

REM below codes are not tested on windows environment yet !!!

IF NOT EXIST ".\gradle\wrapper\gradle-wrapper.jar" (
	set DOWNURL=https://raw.githubusercontent.com/appbakers/gradlew.zip/master/gradlew.zip
	@powershell -command "& { (New-Object Net.WebClient).DownloadFile(%DOWNURL%, './') }"
)
gradlew.bat -b .\svntools.gradle %*
