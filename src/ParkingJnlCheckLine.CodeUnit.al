codeunit 50101 "Parking Jnl.-Check Line"
{
    TableNo = "Parking Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        Text000Txt: Label 'cannot be a closing date';

    procedure RunCheck(var ParkingJnlLine: Record "Parking Journal Line")
    begin
        if ParkingJnlLine.EmptyLine() then
            exit;

        ParkingJnlLine.TestField("Document No.", ErrorInfo.Create());
        ParkingJnlLine.TestField("Posting Date", ErrorInfo.Create());
        ParkingJnlLine.TestField("Parking Order No.", ErrorInfo.Create());
        ParkingJnlLine.TestField("Customer No.", ErrorInfo.Create());
        ParkingJnlLine.TestField("Parking Spot No.", ErrorInfo.Create());
        ParkingJnlLine.TestField("Parking Spot Unit No.", ErrorInfo.Create());
        ParkingJnlLine.TestField("Parking Start", ErrorInfo.Create());
        ParkingJnlLine.TestField("Parking End", ErrorInfo.Create());
        ParkingJnlLine.TestField("Parking Days", ErrorInfo.Create());

        CheckPostingDate(ParkingJnlLine);
    end;

    local procedure CheckPostingDate(ParkingJnlLine: Record "Parking Journal Line")
    var
        UserSetupManagement: Codeunit "User Setup Management";
    begin
        if ParkingJnlLine."Posting Date" <> NormalDate(ParkingJnlLine."Posting Date") then
            ParkingJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text000Txt, true));

        UserSetupManagement.CheckAllowedPostingDate(ParkingJnlLine."Posting Date");
    end;

}