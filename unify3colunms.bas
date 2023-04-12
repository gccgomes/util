rem Add a new sheet with name Copy before use this macro
rem This macro will copy all another sheets firts 3 colunm on sheet called copy
Sub Unify()
	doc = ThisComponent
	current = doc.CurrentController.ActiveSheet
	linha = 0
	For Each sheet In doc.Sheets
    	dim oSheet as Object, oCellCursor as object, oCellRangeAddress as object
		dim LStartCol as long, LStartRow as long, LEndCol as long, LEndRow as long
		oSheet = doc.Sheets.getByName(sheet.Name)
		oCellCursor = oSheet.createCursor()
		oCellCursor.gotoStartOfUsedArea(False)
		oCellCursor.gotoEndOfUsedArea(True)
		oCellRangeAddress = oCellCursor.getRangeAddress()
		LStartCol = oCellRangeAddress.StartColumn
		LStartRow = oCellRangeAddress.StartRow
		LEndCol = oCellRangeAddress.EndColumn
		LEndRow = oCellRangeAddress.EndRow
		if sheet.Name <> "Copy" Then 
		    for i = LStartRow to LEndRow 
			    cell1 = sheet.GetCellByPosition(LStartCol,i+1).getString()
			    cell2 = sheet.GetCellByPosition(LStartCol+1,i+1).getString()
			    cell3 = sheet.GetCellByPosition(LStartCol+2,i+1).getString()
			    shit = doc.Sheets.getByName("Copy")
			    sheetCell1 = shit.getCellByPosition(LStartCol,linha+i)
			    sheetCell2 = shit.getCellByPosition(LStartCol+1,linha+i)
			    sheetCell3 = shit.getCellByPosition(LStartCol+2,linha+i)
			    sheetCell4 = shit.getCellByPosition(LStartCol+3,linha+i)
				sheetCell1.setString(sheet.Name)
				sheetCell2.setString(cell1)
				sheetCell3.setString(cell2)
				sheetCell4.setString(cell3)
		 	next i
		 linha=linha+LEndRow
		End If
    Next
End Sub
