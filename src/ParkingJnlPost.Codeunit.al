codeunit 50104 "Parking Jnl.-Post"
{
    TableNo = "Parking Journal Line";
    trigger OnRun()
    begin
        ParkingJnlLine.Copy(Rec);
        Code();
        Rec.Copy(ParkingJnlLine);
    end;

    var
        ParkingJnlLine: Record "Parking Journal Line";
        Text001Txt: Label 'Do you want to post the journal lines?';
        Text002Txt: Label 'The journal lines were successfullt posted.';

    local procedure Code()
    begin
        if not Confirm(Text001Txt) then
            exit;
        Codeunit.Run(Codeunit::"Parking Jnl.-Post Batch", ParkingJnlLine);
        Message(Text002Txt);
    end;
}