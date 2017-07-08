lParameters tcFile, tlAutoPK
local lcExtension

if !"psplibrary" $ set("path")
	set path to addbs(curdir()) + "PspLibrary"
endif

lcExtension = lower(justext(tcFile))
if lcExtension = "tsv"
	lcSeparator = chr(9)
elseif lcExtension = "csv"
	lcSeparator = ","
else
	_errorquit("Invalid Separator")
endif

lnFHandle = fopen(tcFile)
if lnFHandle < 1
	_errorquit("Unable to open file.")
endif

lcCursorDef = _getcursordef(lnFHandle)
if empty(lcCursorDef)
	_errorquit("Unable to find cursor definition.")
endif

? lcCursorDef
lcCursorName = "TableDefs"
llOK = _createcursor(lcCursorDef,lcCursorName,tlAutoPK)

*** End of Main

procedure _createcursor
	lparameters tcCursorDef, tcCursorName, tlAutoPK
	local lcTable = "", lcField = ""
	
	
endproc


procedure _getcursordef
	lParameters tnFHandle
	local lcLine, lcLookFor = "*cursordef"
	
	lcLine = _freadstr(tnFHandle, 254)
	do while left(lower(lcLine),len(lcLookFor)) # lcLookFor
		lcLine = _freadstr(tnFHandle)
	enddo
	
	if left(lower(lcLine),len(lcLookFor)) # lcLookFor
		_errorquit("Cursor Definition not found.")
	endif
	*** by Jove, the next line is it!
	lcLine = _freadstr(tnFHandle, 254)
return lcLine

endproc

procedure _freadstr
	lParameters tnFHandle
	local lcRet = ""
	
	lcRet = freadstr(tnFHandle,254)
	if ferror() = -1
		_errorquit("Error reading file.")
	endif
return lcRet
endproc

procedure _errorquit
	lparameter  tcMsg
	messagebox(tcMsg)
return to master
endproc


