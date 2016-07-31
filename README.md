
# simple gradle-svntools-plugin's build file

### When to use.

 - is java & gradle based environment
 - cannot install subversion client tool( TortoiseSvn, subversion etc )

### download gsvn( gsvn.bat for windows ) to workspace directory

```
mkdir ~/workspace ; cd ~/workspace && wget https://raw.githubusercontent.com/appbakers/svntools/master/gsvn
```

```
mkdir D:\workspace & cd D:\workspace && @powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/appbakers/svntools/master/gsvn.bat', './') }"
```


### use

```
cd ~/workspace
./gsvn checkout -PsvnUrl=some-great-svn-repository-url -PworkspaceDir=~/workspace/some-great-svn-project
./gsvn update -PworkspaceDir=~/workspace/some-great-svn-project
./gsvn export -PsvnUrl=som-great-repository-url-with-path -PtargetDir=~/workspace/some-great-folder
```



