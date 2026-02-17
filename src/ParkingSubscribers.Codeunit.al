codeunit 50100 "Parking Subscribers"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterTableHasNumberFieldPrimaryKey, '', false, false)]
    local procedure OnAfterTableHasNumberFieldPrimaryKey(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        if TableNo = Database::"Parking Spot" then begin
            FieldNo := 1;
            Result := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterGetRefTable, '', false, false)]
    local procedure OnAfterGetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        ParkingSpot: Record "Parking Spot";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Parking Spot":
                begin
                    RecRef.Open(DATABASE::"Parking Spot");
                    if ParkingSpot.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ParkingSpot);
                end;
        end;
    end;
}