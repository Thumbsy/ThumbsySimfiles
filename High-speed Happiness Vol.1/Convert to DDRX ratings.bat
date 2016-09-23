@ECHO OFF

echo ::::: Applying METERTYPE correction :::::
fnr.exe --cl --dir "%~dp0\." --includeSubDirectories --fileMask "*.sm" --find "#METERTYPE:ITG;" --replace "#METERTYPE:DDR X;"

echo ::::: Applying chart ratings for Candy Crack Curtain Call [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Candy Crack Curtain Call [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     3" --replace "Beginner:\r\n     6"
fnr.exe --cl --dir "%~dp0\Candy Crack Curtain Call [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     5" --replace "Easy:\r\n     8"
fnr.exe --cl --dir "%~dp0\Candy Crack Curtain Call [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     7" --replace "Medium:\r\n     11"
fnr.exe --cl --dir "%~dp0\Candy Crack Curtain Call [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     11" --replace "Hard:\r\n     15"
fnr.exe --cl --dir "%~dp0\Candy Crack Curtain Call [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     12" --replace "Challenge:\r\n     17"

echo ::::: Applying chart ratings for Drop The Bass Now (Hommarju Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Drop The Bass Now (Hommarju Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     2" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\Drop The Bass Now (Hommarju Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     4" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Drop The Bass Now (Hommarju Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     6" --replace "Medium:\r\n     9"
fnr.exe --cl --dir "%~dp0\Drop The Bass Now (Hommarju Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     9" --replace "Hard:\r\n     12"

echo ::::: Applying chart ratings for Everywhere I Turn (Orbit1 Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Everywhere I Turn (Orbit1 Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     2" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\Everywhere I Turn (Orbit1 Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     3" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Everywhere I Turn (Orbit1 Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     5" --replace "Medium:\r\n     8"
fnr.exe --cl --dir "%~dp0\Everywhere I Turn (Orbit1 Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     8" --replace "Hard:\r\n     11"
fnr.exe --cl --dir "%~dp0\Everywhere I Turn (Orbit1 Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     10" --replace "Challenge:\r\n     13"

echo ::::: Applying chart ratings for HAPPYMAKER (Junk Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\HAPPYMAKER (Junk Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     2" --replace "Beginner:\r\n     3"
fnr.exe --cl --dir "%~dp0\HAPPYMAKER (Junk Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     4" --replace "Easy:\r\n     6"
fnr.exe --cl --dir "%~dp0\HAPPYMAKER (Junk Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     6" --replace "Medium:\r\n     8"
fnr.exe --cl --dir "%~dp0\HAPPYMAKER (Junk Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     7" --replace "Hard:\r\n     11"
fnr.exe --cl --dir "%~dp0\HAPPYMAKER (Junk Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     9" --replace "Challenge:\r\n     13"

echo ::::: Applying chart ratings for Help me, ERINNNNNN!! [LauPi314 & Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Help me, ERINNNNNN!! [LauPi314 & Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     1" --replace "Beginner:\r\n     2"
fnr.exe --cl --dir "%~dp0\Help me, ERINNNNNN!! [LauPi314 & Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     3" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Help me, ERINNNNNN!! [LauPi314 & Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     5" --replace "Medium:\r\n     8"
fnr.exe --cl --dir "%~dp0\Help me, ERINNNNNN!! [LauPi314 & Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     7" --replace "Hard:\r\n     10"
fnr.exe --cl --dir "%~dp0\Help me, ERINNNNNN!! [LauPi314 & Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     8" --replace "Challenge:\r\n     12"

echo ::::: Applying chart ratings for Language (Stu Infinity Hardcore Mix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Language (Stu Infinity Hardcore Mix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     3" --replace "Beginner:\r\n     4"
fnr.exe --cl --dir "%~dp0\Language (Stu Infinity Hardcore Mix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     4" --replace "Easy:\r\n     6"
fnr.exe --cl --dir "%~dp0\Language (Stu Infinity Hardcore Mix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     6" --replace "Medium:\r\n     9"
fnr.exe --cl --dir "%~dp0\Language (Stu Infinity Hardcore Mix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     8" --replace "Hard:\r\n     12"

echo ::::: Applying chart ratings for Light of Playback (nadeco Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Light of Playback (nadeco Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     3" --replace "Beginner:\r\n     4"
fnr.exe --cl --dir "%~dp0\Light of Playback (nadeco Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     4" --replace "Easy:\r\n     7"
fnr.exe --cl --dir "%~dp0\Light of Playback (nadeco Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     5" --replace "Medium:\r\n     8"
fnr.exe --cl --dir "%~dp0\Light of Playback (nadeco Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     8" --replace "Hard:\r\n     11"
fnr.exe --cl --dir "%~dp0\Light of Playback (nadeco Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     10" --replace "Challenge:\r\n     15"

echo ::::: Applying chart ratings for Nothing More [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Nothing More [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Beginner:\r\n     1" --replace "Beginner:\r\n     2"
fnr.exe --cl --dir "%~dp0\Nothing More [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     3" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Nothing More [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     5" --replace "Medium:\r\n     7"
fnr.exe --cl --dir "%~dp0\Nothing More [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     7" --replace "Hard:\r\n     10"
fnr.exe --cl --dir "%~dp0\Nothing More [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     8" --replace "Challenge:\r\n     13"

echo ::::: Applying chart ratings for Top of The World [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Top of The World [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     4" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Top of The World [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     6" --replace "Medium:\r\n     9"
fnr.exe --cl --dir "%~dp0\Top of The World [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     8" --replace "Hard:\r\n     11"

echo ::::: Applying chart ratings for Underneath (DJ Genki Remix) [Thumbsy feat. Nezumi] :::::
fnr.exe --cl --dir "%~dp0\Underneath (DJ Genki Remix) [Thumbsy feat. Nezumi]" --fileMask "*.sm" --useEscapeChars --find "Challenge:\r\n     10" --replace "Challenge:\r\n     13"

echo ::::: Applying chart ratings for Verity (Chasers Remix) [Thumbsy] :::::
fnr.exe --cl --dir "%~dp0\Verity (Chasers Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Easy:\r\n     3" --replace "Easy:\r\n     5"
fnr.exe --cl --dir "%~dp0\Verity (Chasers Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Medium:\r\n     5" --replace "Medium:\r\n     7"
fnr.exe --cl --dir "%~dp0\Verity (Chasers Remix) [Thumbsy]" --fileMask "*.sm" --useEscapeChars --find "Hard:\r\n     7" --replace "Hard:\r\n     9"

echo Ratings should now have been changed to DDR X scale.
pause