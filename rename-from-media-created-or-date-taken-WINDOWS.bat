@echo off
REM For documentation on exiftool usage see: https://www.sno.phy.queensu.ca/~phil/exiftool/exiftool_pod.html
REM This script renames a file based on CreateDate.
echo =============================================================================================
echo Preserving Current File Name (as OriginalFileName)
echo =============================================================================================
echo Conditionally copying file name to OriginalFileName (if OriginalFileName does not already exist)...
exiftool -overwrite_original -ignoreMinorErrors -extractEmbedded -overwrite_original "-OriginalFileName<${filename;s/\.[^.]*$//}" -v0 -if "!$OriginalFileName" %*
echo:
echo Done copying file name to OriginalFileName.
echo:
echo:
echo:
echo =============================================================================================
echo Renaming File(s) from Media Created (CreationDate)
echo =============================================================================================
echo Renaming file(s) to {CreationDate}_{OriginalFileName}...
exiftool -overwrite_original -extractEmbedded -d %%Y-%%m-%%d-%%H%%M%%S -"filename<${CreationDate}_${OriginalFileName}%%-c.%%le" -if "$CreationDate && $OriginalFileName" %*
echo:
echo Done renaming file(s) from media created.
echo:
echo:
echo:
echo =============================================================================================
echo Renaming File(s) from Date Taken (CreateDate)
echo =============================================================================================
echo Renaming file(s) to {CreateDate}_{OriginalFileName}...
exiftool -overwrite_original -extractEmbedded -d %%Y-%%m-%%d-%%H%%M%%S -"filename<${CreateDate}_${OriginalFileName}%%-c.%%le" -if "$CreateDate && $OriginalFileName && !$CreationDate" %*
echo:
echo Done renaming file(s) from date taken.
echo:
echo:
echo:
echo Done. You may close the window.
pause>nul