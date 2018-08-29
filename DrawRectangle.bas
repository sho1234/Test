Attribute VB_Name = "DrawRectangle"
Sub DrawRectangle(targetCell As Range)
    targetCell.Select
    ActiveSheet.Shapes.AddShape(msoShapeRectangle, ActiveCell.Left, ActiveCell.Top, ActiveCell.Width, ActiveCell.Height).Select
    Selection.ShapeRange.Fill.Visible = msoFalse
End Sub

Sub Test()
    Call DrawRectangle(Cells(5, 5))
End Sub
