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

lcCursorName = "TableDefs"
lcCursorDef = _getcursordef(lnFHandle,lcSeparator, lcCursorName)
if empty(lcCursorDef)
	_errorquit("Unable to find cursor definition.")
endif

? lcCursorDef

llOK = _createcursor(lcCursorDef,lcCursorName)

*** End of Main

procedure _createcursor
	lparameters tcCursorDef, tcCursorName
	
	
	
endproc


procedure _getcursordef
	lParameters tnFHandle, tcCursorSeparator
	local lcLine, lcLookFor = "*cursordef", lcFieldDefs, lCursorDef
	
	lcLine = _freadstr(tnFHandle, 254)
	do while left(lower(lcLine),len(lcLookFor)) # lcLookFor
		lcLine = _freadstr(tnFHandle)
	enddo
	
	if left(lower(lcLine),len(lcLookFor)) # lcLookFor
		_errorquit("Cursor Definition not found.")
	endif
	*** by Jove, the next line is it!
	lcLine = _freadstr(tnFHandle, 254)
	
	lcCursorDef = "create cursor <<tcCursorName>>" + " ("
	lcLine = tcCursorSeparator + lcLine + tcCursorSeparator
	lcFieldDefs = ""
	for lnField = 1 to occurs(tcCursorSeparator,lcLine) - 1
		lcCurField = alltrim(strextract(lcLine, tcCursorSeparator, tcCursorSeparator,lnField))
		lcFieldDefs = lcFieldDefs + lcCurField + ","
	endfor
	lcFieldDefs = left(lcFieldDefs,len(lcFieldDefs) - 1) 
	return lcCursorDef + lcFieldDefs + ")"
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


