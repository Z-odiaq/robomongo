@echo off 
setlocal enableextensions enabledelayedexpansion

rem Path to bin and project folder
set BIN_DIR_WITH_BACKSLASH=%~dp0%
set BIN_DIR=%BIN_DIR_WITH_BACKSLASH:~0,-1%
set PROJECT_DIR=%BIN_DIR%\..

rem Run common setup code
call "%BIN_DIR%\common\setup.bat" %*
if %ERRORLEVEL% neq 0 (exit /b 1)

rem Run CMake configuration step
rem BUILD_TYPE: Release or Debug
cd "%BUILD_DIR%"
cmake -G "Visual Studio 17 2022" -A x64 -D "CMAKE_PREFIX_PATH=%PREFIX_PATH%" -D "OPENSSL_ROOT_DIR=C:/Program Files/OpenSSL-Win64" -D "CMAKE_BUILD_TYPE=%BUILD_TYPE%" -D "CMAKE_INSTALL_PREFIX=%INSTALL_PREFIX%" -D "CMAKE_EXE_LINKER_FLAGS=/LIBPATH:\"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/atlmfc/lib/x64\"" %PROJECT_DIR%

@REM echo ___________________________________________________________________
@REM rem Enable Clang Tidy for Visual Studio 2019 IDE ...
@REM set ROBO_PROJ_FILE=%BUILD_DIR%/src/robomongo/robomongo.vcxproj
@REM python %BIN_DIR%\enable-visual-studio-clang-tidy.py %ROBO_PROJ_FILE% %BIN_DIR%