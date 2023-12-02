@echo off
setlocal

REM Check if an input file is provided
if "%1"=="" (
    echo Usage: build_asm.bat input_file.asm
    exit /b 1
)

REM Set the input file name and output file name
set INPUT_FILE=%1
set OUTPUT_FILE=%~n1.exe

REM Assemble the assembly file with NASM
"C:\Program Files\NASM\nasm.exe" -f win64 "%INPUT_FILE%" -o "%~n1.obj" -g

REM Link the object file with lld-link to produce the executable
"C:\Program Files\LLVM\bin\lld-link.exe" "%~n1.obj" -defaultlib:kernel32.lib -subsystem:console -entry:_start -out:"%OUTPUT_FILE%"

REM Check if the linking process was successful
if not %errorlevel%==0 (
    echo Linking failed!
    exit /b 1
)

echo Build successful. Output: %OUTPUT_FILE%
exit /b 0

