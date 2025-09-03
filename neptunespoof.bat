@echo off
setlocal EnableDelayedExpansion

:: Define the character set
set "charset=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
set "charsetLen=62"

:: Loop through keys 0 to 11
for /L %%k in (0,1,11) do (
    set "randStr="
    
    :: Generate a 20-character random string
    for /L %%i in (1,1,20) do (
        set /a "randIndex=!random! %% charsetLen"
        call set "char=%%charset:~!randIndex!,1%%"
        set "randStr=!randStr!!char!"
    )

    :: Set the ProcessorNameString for this key
    reg add "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\%%k" /v ProcessorNameString /t REG_SZ /d "!randStr!" /f

    echo [+] ProcessorNameString in key %%k set to: !randStr!
)

:: Delete the C:\WindowsProperties folder if it exists
if exist "C:\WindowsProperties" (
    echo [!] Deleting C:\WindowsProperties...
    rmdir /s /q "C:\WindowsProperties"
    echo [+] Folder deleted.
) else (
    echo [i] C:\WindowsProperties does not exist.
)

pause