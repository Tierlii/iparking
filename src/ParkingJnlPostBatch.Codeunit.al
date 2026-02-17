codeunit 50103 "Parking Jnl.-Post Batch"
{
    TableNo = "Parking Journal Line";
    trigger OnRun()
    begin
        ParkingJnlLine.Copy(Rec);
        Code();
        Rec := ParkingJnlLine;
    end;

    var
        ParkingJnlLine: Record "Parking Journal Line";
        ParkingJnlLine2: Record "Parking Journal Line";
        ParkingJnlCheckLine: Codeunit "Parking Jnl.-Check Line";
        LineCount: Integer;
        NoOfRecords: Integer;
        Window: Dialog;
        Text001Txt: Label 'Journal Batch Name    #1##########\\'; 
        Text002Txt: Label 'Checking lines        #2######\';
        Text003Txt: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@';

    local procedure Code()
    begin
        Window.Open(
            Text001Txt +
            Text002Txt +
            Text003Txt);
        Window.Update(1, ParkingJnlLine."Line No.");
        LineCount := 0;
        ParkingJnlLine.FindFirst();
        repeat
            LineCount := LineCount + 1;
            Window.Update(2, LineCount);
            ParkingJnlCheckLine.RunCheck(ParkingJnlLine);
        until ParkingJnlLine.Next() = 0;
        NoOfRecords := LineCount;
        LineCount := 0;
        ParkingJnlLine.FindFirst();
        repeat
            LineCount := LineCount + 1;
            Window.Update(3, LineCount);
            Window.Update(4, Round(LineCount / NoOfRecords * 10000, 1));
            if not ParkingJnlLine.EmptyLine() then
                ParkingJnlLine.TestField("Document No.");
            ParkingJnlCheckLine.RunCheck(ParkingJnlLine);
        until ParkingJnlLine.Next() = 0;

        ParkingJnlLine2.Copy(ParkingJnlLine);
        ParkingJnlLine2.DeleteAll();
        Commit();
    end;
}