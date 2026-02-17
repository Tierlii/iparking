codeunit 50106 "Parking-Post (Yes/No)"
{
    TableNo = "Parking Document";
    trigger OnRun()
    begin
        ParkingOrder.Copy(Rec);
        Code();
        Rec := ParkingOrder;
    end;

    var
        ParkingOrder: Record "Parking Document";
        Text000Txt: Label 'Do you want to post the %1?';
        Text001Txt: Label 'The order was successfully posted.';

    local procedure Code()
    begin
        if not Confirm(Text000Txt, false, ParkingOrder."No.") then
            exit;
        Codeunit.Run(Codeunit::"Parking-Post", ParkingOrder);
        Message(Text001Txt);
    end;
}