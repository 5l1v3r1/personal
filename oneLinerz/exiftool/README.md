## Exiftool

Manipulate data as a pro

```sh
exiftool -comment= -o newdir -ext jpg .
```

-  Replace existing keyword list with two new keywords ("EXIF" and "editor").

```sh
exiftool -keywords=EXIF -keywords=editor dst.jpg
```

-  Copy a source image to a new file, and add a keyword ("word") to the current list of keywords.

```sh
exiftool -Keywords+=word -o newfile.jpg src.jpg
```

-Delete Credit information from all files in a directory where the Credit value was "xxx".

```sh
exiftool -credit-=xxx dir
```

- Write alternate language for XMP:Description, using HTML character escaping to input special characters.

```sh
exiftool -xmp:description-de='k&uuml;hl' -E dst.jpg
```

- Delete all meta information from an image.  Note: You should NOT do this to RAW images (except DNG) since proprietary RAW image formats often contain information in the makernotes that is necessary for 
converting the            image.

```sh
exiftool -all= dst.jpg
```

- Delete all meta information from an image and add a comment back in.  (Note that the order is important: "-comment='lonely' -all=" would also delete the new comment.)

```sh
exiftool -all= -comment='lonely' dst.jpg
```

- Delete all meta information except JFIF group from an image.

```sh
exiftool -all= --jfif:all dst.jpg
```

- Delete Photoshop meta information from an image (note that the Photoshop information also includes IPTC).

```sh
exiftool -Photoshop:All= dst.jpg
```

- Adjust original date/time of all images in directory "dir" by subtracting one hour and 30 minutes.  (This is equivalent to "-DateTimeOriginal-=1.5".  See Image::ExifTool::Shift.pl for details.)

```sh
exiftool -DateTimeOriginal-='0:0:0 1:30:0' dir
```

- Add 3 hours to the CreateDate and ModifyDate timestamps of two images.

```sh
exiftool -createdate+=3 -modifydate+=3 a.jpg b.jpg
```

- Shift the values of DateTimeOriginal, CreateDate and ModifyDate forward by 1 hour and 30 minutes for all Canon images in a directory.  (The AllDates tag is provided as a shortcut for these three tags, allowing them to be accessed via a single tag.)

```sh
 exiftool -AllDates+=100000:-30 -if '$make eq "Canon"' dir
```

- Set all dates to 2012

```sh
exiftool -AllDates="2012:03:14 12:25:00"
```

- Create xmp files

```sh
exiftool -o %d%f.xmp dir
```

- Set city

```sh
exiftool -xmp:city=Kingston i
```

- Print megapixels

```sh
exiftool -Megapixels -if "$Make eq 'Sony'"
```

- Print GPS info

```sh
exiftool -Composite:GPSPosition
```

- Remove  all gps info 

```sh
exiftool -GPS*= -a
```

- remove ALL metadata run both

```sh
exiftool -ApertureValue="3.0" -EXIF:all=
exiftool -EXIF:all= -ApertureValue="3.0"
```

- Include some cool info 

```sh
$gpsPosition = $(exiftool -s -s -s -Composite:GPSPosition TestPic.jpg)
echo "This picture was taken at $gpsPosition"
```


- Timeshift Photos by One Year

```sh
exiftool "-AllDates+=1:0:0 0" .
```

- Rename files to datestamp

```sh
exiftool '-FileName<DateTimeOriginal' -d "%Y-%m-%d %H.%M.%S%%-c.%%e" .  
```

- Display all compoisites

```sh
exiftool -G -Composite:all
```

- Print values by alphanet sorted

```sh
exiftool -Sort -G -Composite:all
```

- Rename Files to With Milliseconds

```sh
exiftool -v '-Filename<${datetimeoriginal}${subsectimeoriginal;$_.=0 x(3-length)}.%e' -d %Y%m%d_%H%M%S .
```

- Set Date/Time Original date:

```sh
exiftool '-datetimeoriginal=2015:01:18 12:00:00' .
```

- Edit File Modification Date/Time to same date as "date/time original" (run this date/time command before this if you wanna manipulate)

```sh
exiftool "-filemodifydate<datetimeoriginal"
```

- List all dates

```sh
exiftool -time:all -a -G0:1 -s
```

- Update any photo that doesn't have DateTimeOriginal to have it based on file modify date

```sh
exiftool '-datetimeoriginal<filemodifydate' -if '(not $datetimeoriginal or ($datetimeoriginal eq "0000:00:00 00:00:00")) and ($filetype eq "JPEG")' .
```

- The command alone will put the full filename in the comments. If you want to add the filename without the extension, add the example exiftool config file found here
	
```sh
exiftool "-AllDates=1986:11:05 12:00:00" -if '$filetype eq "JPEG"' .
```
OR

```sh
	find . -name "*.jpg" | while read filename;  do
    	exiftool "-AllDates=1986:11:05 12:00:00" "$filename";
	done
```

- Set File Modification Date/Time  

```sh
exiftool "-FileModifyDate<XMP:DateTimeOriginal" "-FileModifyDate<EXIF:CreateDate" "-FileModifyDate<XMP:CreateDate" "-FileModifyDate<$IPTC:DateCreated $IPTC:TimeCreated" "-FileModifyDate<EXIF:DateTimeOriginal" ```

