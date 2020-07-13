Attribute VB_Name = "Module1"

Sub Rectangle1_3_Click()
Dim ticker_1, ticker_2, analysis_year As String
Dim stock_vol, open_price, close_price As Variant
Dim i, j, k, l, yy As Variant
yy = InputBox("Please enter the year to be analysed. to abort please enter 0")
Do Until yy = 0 'Cells(2, yy) = ""
  Application.DisplayAlerts = False
  Application.ScreenUpdating = False
  
  analysis_year = yy ' Cells(2, yy)
  Worksheets(analysis_year).Activate
  Cells.Select
  stock_vol = 0 'Innitialising with to 0 to remove any garbage value
  i = 2         'loop counter to track the row numbers
  j = 2         'loop counter to track the row numbers

  'loop to clean the cells where the analysed stock data will be stored
  For k = 2 To 10000
     Cells(k, 10) = ""
     Cells(k, 11) = ""
     Cells(k, 12) = ""
     Cells(k, 13) = ""
  Next k

  ticker_1 = Cells(i, 1)
  l = i
  Do Until Cells(i, 1) = ""
      open_price = Cells(l, 3)
      If ticker_1 = Cells(i, 1) Then
         stock_vol = (stock_vol + Cells(i, 7))
      Else
         close_price = Cells((i - 1), 6)
         Cells(j, 10) = ticker_1
         Cells(j, 13) = stock_vol
         ticker_1 = Cells(i, 1)
         Cells(j, 11) = close_price - open_price
         If open_price = 0 Then
           Cells(j, 11) = 0
           Cells(j, 12) = 0
         Else
           Cells(j, 11) = Round((close_price - open_price), 2)
           Cells(j, 12) = (close_price - open_price) / open_price
           If Cells(j, 11) > 0 Then
              Cells(j, 11).Interior.ColorIndex = 4 'green color
           ElseIf Cells(j, 11) < 0 Then
              Cells(j, 11).Interior.ColorIndex = 3 'red color
           Else
              Cells(j, 11).Interior.ColorIndex = 2 'white color
           End If
         End If
      l = i
      j = (j + 1)
      i = (i - 1)
    End If
 
    i = (i + 1)
    Loop

   ' section to analyse the greatest % increase, decrease and greatest total volume

   Dim greatest_increase, greatest_decrease, greatest_volume As Variant
   i = 2
   greatest_increase = Cells(i, 12)
   greatest_decrease = Cells(i, 12)
   greatest_volume = Cells(i, 13)
   ticker_1 = Cells(i, 10)
   ticker_2 = Cells(i, 10)
   ticker_3 = Cells(i, 10)
   Do Until Cells(i, 10) = ""
    If Cells(i, 12) > greatest_increase Then
      greatest_increase = Cells(i, 12)
      ticker_1 = Cells(i, 10)
    End If
    If Cells(i, 12) < greatest_decrease Then
      greatest_decrease = Cells(i, 12)
      ticker_2 = Cells(i, 10)
    End If
    If Cells(i, 13) > greatest_volume Then
      greatest_volume = Cells(i, 13)
      ticker_3 = Cells(i, 10)
    End If
    i = (i + 1)
  Loop
  Cells(2, 16) = ticker_1
  Cells(2, 17) = greatest_increase
  
  Cells(3, 16) = ticker_2
  Cells(3, 17) = greatest_decrease
  
  Cells(4, 16) = ticker_3
  Cells(4, 17) = greatest_volume
  
yy = InputBox("Please enter the year to be analysed. to abort please enter 0")
Loop
MsgBox ("All Years Processed. Check it tab")
End Sub
