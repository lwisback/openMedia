-- Copyright 2015, Selcuk Karakas, All rights reserved.

set someLines to returnFileContentsAsList("/Users/kullanıcıadı/Desktop/mediaList.txt")
set numLines to count of someLines
set itemNumber to 1
set a to "http://kat.ph/usearch/"
set b to "http://unutulmazfilmler.co/arama.php?arama="
set c to "http://dizipub.com/?s="
set d to "category:movies/"
set e to "http://www.youtube.com/results?search_query="

repeat numLines times
  set pieceString to item itemNumber of someLines

  if("youtube" is in pieceString)
    set the text item delimiters to "***"

    set pieceName to text item 1 of pieceString
    set querySource to text item 2 of pieceString
    tell application "Safari"
          set queryYoutube to e & pieceName
          open location queryYoutube
    end tell

  else if("***" is in pieceString)
    set the text item delimiters to "***"

    set pieceName to text item 1 of pieceString
    set querySource to text item 2 of pieceString
    set queryType to text item 3 of pieceString

    tell application "Safari"
       if("kat" is in querySource) then
          set queryKat to a & pieceName & d
          open location queryKat
       end if

       if("stream" is in querySource and "film" is in queryType) then
          set queryStreamFilm to b & pieceName
          open location queryStreamFilm
       end if

       if("stream" is in querySource and "dizi" is in queryType) then
          set queryStreamDizi to c & pieceName
          open location queryStreamDizi
       end if

       if("both" is in querySource and "film" is in queryType) then
          set queryKat to a & pieceName & d
          open location queryKat
          set queryStreamFilm to b & pieceName
          open location queryStreamFilm
       end if

       if("both" is in querySource and "dizi" is in queryType) then
          set queryKat to a & pieceName & d
          open location queryKat
          set queryStreamDizi to c & pieceName
          open location queryStreamDizi
       end if

       if("both" is in querySource and "both" is in queryType) then
          set queryKat to a & pieceName
          open location queryKat
          set queryStreamFilm to b & pieceName
          open location queryStreamFilm
          set queryStreamDizi to c & pieceName
          open location queryStreamDizi
       end if

    end tell
  else
      tell application "Safari"
          set queryKat to a & pieceString
          open location queryKat
      end tell
  end

  set itemNumber to itemNumber+1
end repeat

on returnFileContentsAsList(theFile)
  set fileHandle to open for access theFile
  set theLines to paragraphs of (read fileHandle)
  close access fileHandle
  return theLines
end
