@ECHO OFF

echo ::::: Applying METERTYPE correction :::::
fnr.exe --cl --dir "%~dp0\." --includeSubDirectories --fileMask "*.sm" --find "#METERTYPE:DDR X;" --replace "#METERTYPE:ITG;"

echo ::::: Applying chart ratings for float on flowers [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\float on flowers [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     4" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\float on flowers [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     7" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\float on flowers [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     10" --replace "Medium:\r\n     7"
fnr.exe --cl --dir "%~dp0\float on flowers [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     13" --replace "Hard:\r\n     9"
fnr.exe --cl --dir "%~dp0\float on flowers [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     15" --replace "Challenge:\r\n     10"

echo ::::: Applying chart ratings for Hard Humming [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Hard Humming [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     6" --replace "Easy:\r\n     4"
fnr.exe --cl --dir "%~dp0\Hard Humming [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     7" --replace "Medium:\r\n     5"
fnr.exe --cl --dir "%~dp0\Hard Humming [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     10" --replace "Hard:\r\n     7"

echo ::::: Applying chart ratings for I'll stop this [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\I'll stop this [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     3" --replace "Beginner:\r\n     2"
fnr.exe --cl --dir "%~dp0\I'll stop this [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     6" --replace "Easy:\r\n     4"
fnr.exe --cl --dir "%~dp0\I'll stop this [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     8" --replace "Medium:\r\n     6"
fnr.exe --cl --dir "%~dp0\I'll stop this [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     8"
fnr.exe --cl --dir "%~dp0\I'll stop this [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     14" --replace "Challenge:\r\n     10"

echo ::::: Applying chart ratings for Kiriban Getter [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Kiriban Getter [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     5" --replace "Easy:\r\n     3"
fnr.exe --cl --dir "%~dp0\Kiriban Getter [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     9" --replace "Medium:\r\n     7"
fnr.exe --cl --dir "%~dp0\Kiriban Getter [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     8"
fnr.exe --cl --dir "%~dp0\Kiriban Getter [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     15" --replace "Challenge:\r\n     11"

echo ::::: Applying chart ratings for Lift Me Up [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Lift Me Up [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     6" --replace "Easy:\r\n     4"
fnr.exe --cl --dir "%~dp0\Lift Me Up [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     8" --replace "Medium:\r\n     6"
fnr.exe --cl --dir "%~dp0\Lift Me Up [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     8"
fnr.exe --cl --dir "%~dp0\Lift Me Up [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     12" --replace "Challenge:\r\n     9"

echo ::::: Applying chart ratings for LOOKBACK [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\LOOKBACK [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     4" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\LOOKBACK [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     7" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\LOOKBACK [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     10" --replace "Medium:\r\n     8"
fnr.exe --cl --dir "%~dp0\LOOKBACK [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     14" --replace "Hard:\r\n     10"
fnr.exe --cl --dir "%~dp0\LOOKBACK [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     16" --replace "Challenge:\r\n     11"

echo ::::: Applying chart ratings for My Direction (Squad-E Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\My Direction (Squad-E Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     4" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\My Direction (Squad-E Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     6" --replace "Easy:\r\n     4"
fnr.exe --cl --dir "%~dp0\My Direction (Squad-E Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     9" --replace "Medium:\r\n     7"
fnr.exe --cl --dir "%~dp0\My Direction (Squad-E Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     8"

echo ::::: Applying chart ratings for Statice (XIO Remix) [Thumbsy feat. Nezumi] :::::
fnr.exe --cl --dir "%~dp0\Statice (XIO Remix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     4" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\Statice (XIO Remix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     7" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Statice (XIO Remix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     8" --replace "Medium:\r\n     6"
fnr.exe --cl --dir "%~dp0\Statice (XIO Remix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     8"

echo ::::: Applying chart ratings for Top of The World (nanobii Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Top of The World (nanobii Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     3" --replace "Beginner:\r\n     2"
fnr.exe --cl --dir "%~dp0\Top of The World (nanobii Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     5" --replace "Easy:\r\n     3"
fnr.exe --cl --dir "%~dp0\Top of The World (nanobii Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     8" --replace "Medium:\r\n     5"
fnr.exe --cl --dir "%~dp0\Top of The World (nanobii Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     7"

echo ::::: Applying chart ratings for You're Everything [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\You're Everything [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     3" --replace "Beginner:\r\n     2"
fnr.exe --cl --dir "%~dp0\You're Everything [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     6" --replace "Easy:\r\n     4"
fnr.exe --cl --dir "%~dp0\You're Everything [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     10" --replace "Medium:\r\n     7"
fnr.exe --cl --dir "%~dp0\You're Everything [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     12" --replace "Hard:\r\n     9"
fnr.exe --cl --dir "%~dp0\You're Everything [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     15" --replace "Challenge:\r\n     10"

echo Ratings should now have been changed to ITG scale.
pause