call ..\..\SetEnv.bat
call cclean4ecl.cmd


rem pause

rem set
pause

rem cmake -S src -B . -G "Eclipse CDT4 - Ninja" -D CMAKE_BUILD_TYPE=Debug
cmake -B . -G "Eclipse CDT4 - Ninja" -D CMAKE_BUILD_TYPE=Debug

pause


