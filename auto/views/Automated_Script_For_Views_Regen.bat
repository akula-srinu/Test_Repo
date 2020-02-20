:: Title
::   Automated_Script_For_Views_Regen.bat
:: Function
::   Batch file for noetix views and rpd generation in auto mode.
::
:: History
::   16-Dec-18 Srinivas Created
::

:: ----------------------------------------------------------------------------
:: **************** Storing the current date and time into varibles ***********
:: ----------------------------------------------------------------------------

set VIEWS_DIR=D:\Noetix\NoetixViews\Installs
set PACKAGE_DIR=D:\Noetix_Automation\Views_Regen_Automation\Viasat_Noetix_Pkg
set VIEW_AUTO_DIR=D:\Noetix_Automation\Views_Regen_Automation
set SCHEMA=NOETIX_VIEWS
set PASSWORD=QvVE_OWqi3D5
set INSTANCE=EBSPJD1

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
::echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
::echo min=%min%

::set curTimestamp=%date:~10,4%_%date:~4,2%_%date:~7,2%_%hour%_%min%


:: ------------------------------------------------------------------------------
:: **************** Creating the install directory backup folder ****************
:: ------------------------------------------------------------------------------

set mydir="%date:~10,4%_%date:~4,2%_%date:~7,2%_%hour%_%min%"

mkdir %VIEWS_DIR%\backup\ebspjd1_%mydir%

copy %VIEWS_DIR%\NOETIX_VIEWS_ebspjd1 %VIEWS_DIR%\backup\ebspjd1_%mydir%

:: -------------------------------------------------------------------------------------
:: **************** Copying the latest package into the install folder  ****************
:: -------------------------------------------------------------------------------------

copy %PACKAGE_DIR%\NOETIX_VIEWS_CURRENT_PKG %VIEWS_DIR%\NOETIX_VIEWS_ebspjd1

cd %VIEW_AUTO_DIR%\View_Generation_Logs

rename Views_Regen_Log2.txt Views_Regen_Log_%mydir%.txt

cd %VIEWS_DIR%\NOETIX_VIEWS_ebspjd1

d:

:: --------------------------------------------------------------------
:: **************** Initiating the Views Regeneration  ****************
:: --------------------------------------------------------------------


sqlplus %SCHEMA%/%PASSWORD%@%INSTANCE% @%VIEWS_DIR%\NOETIX_VIEWS_ebspjd1\inst4ua_vsat.sql 'STANDARD' 'File' 'D:\Noetix\NoetixViews\Installs\NOETIX_VIEWS_ebspjd1' 'NOETIX_VIEWS' 'QvVE_OWqi3D5' 'EBSPJD1' 'NOETIX_VIEWS' 'APPS' 'US' 'Y' 'N' 'N' 'N' 'Y' 'N' 'N' 'N' 'N' 'N' 'Y' 'Y' 'N' 'A' >> %VIEW_AUTO_DIR%\View_Generation_Logs\Views_Regen_log2.txt

powershell.exe -noexit %VIEW_AUTO_DIR%\Views_Regen_Email_Auto2.ps1

