codeunit 50105 "Parking-Post"
{
    TableNo = "Parking Document";
    trigger OnRun()
    var
        ParkingOrder: Record "Parking Document";
    begin
        ClearAll();
        ParkingOrder := Rec;
        InitPost(ParkingOrder);
        Post(ParkingOrder, ParkingJnlPostLine);
        FinalizePost(ParkingOrder);
        Rec := ParkingOrder;
    end;

    var
        ParkingJnlPostLine: Codeunit "Parking Jnl.-Post Line";
        PostingDate: Date;

    local procedure InitPost(var ParkingOrder: Record "Parking Document")
    begin
        ParkingOrder.TestField("No.");
        ParkingOrder.TestField("Customer No.");
        ParkingOrder.TestField("Parking Spot No.");
        ParkingOrder.TestField("Parking Spot Unit No.");
        ParkingOrder.TestField("Parking Start");
        ParkingOrder.TestField("Parking End");
        ParkingOrder.TestField("Parking Days");
    end;

    local procedure Post(var ParkingOrder: Record "Parking Document"; var ParkingJnlPostLine2: Codeunit "Parking Jnl.-Post Line")
    var
        TempParkingJnlLine: Record "Parking Journal Line" temporary;
    begin
        TempParkingJnlLine.Init();
        TempParkingJnlLine."Document No." := ParkingOrder."No.";
        TempParkingJnlLine."Posting Date" := PostingDate;
        TempParkingJnlLine."Parking Order No." := ParkingOrder."No.";
        TempParkingJnlLine."Customer No." := ParkingOrder."Customer No.";
        TempParkingJnlLine."Parking Spot No." := ParkingOrder."Parking Spot No.";
        TempParkingJnlLine."Parking Spot Unit No." := ParkingOrder."Parking Spot Unit No.";
        TempParkingJnlLine."Parking Start" := ParkingOrder."Parking Start";
        TempParkingJnlLine."Parking End" := ParkingOrder."Parking End";
        TempParkingJnlLine."Parking Days" := ParkingOrder."Parking Days";
        TempParkingJnlLine."Shortcut Dimension 1 Code" := ParkingOrder."Shortcut Dimension 1 Code";
        TempParkingJnlLine."Shortcut Dimension 2 Code" := ParkingOrder."Shortcut Dimension 2 Code";
        TempParkingJnlLine."Dimension Set ID" := ParkingOrder."Dimension Set ID";
        ParkingJnlPostLine2.RunWithCheck(TempParkingJnlLine);
    end;

    local procedure FinalizePost(ParkingOrder: Record "Parking Document")
    begin
        ParkingOrder.Status := ParkingOrder.Status::Closed;
        ParkingOrder.Modify();
    end;
}