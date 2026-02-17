table 50103 "Parking Spot"
{
    DataCaptionFields = "No.", Description;
    Caption = 'Parking Spot';
    DrillDownPageId = "Parking Spot List";
    LookupPageId = "Parking Spot List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    ParkingSetup.Get();
                    NoSeriesMgt.TestManual(ParkingSetup."Parking Spot Nos.");
                    Rec."No. Series" := '';
                end
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            OptimizeForTextSearch = true;
            trigger OnValidate()
            var
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(4; "PS Class Code"; Code[10])
        {
            Caption = 'PS Class Code';
            TableRelation = "PS Class".Code;

            trigger OnValidate()
            var
                _PSClass: Record "PS Class";
            begin
                if "PS Class Code" = '' then begin
                    Clear("PS CLass Id");
                    exit;
                end;
                _PSClass.Get("PS Class Code");
                "PS Class Id" := _PSClass.SystemId;
            end;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(7; "Responsible Employee"; Code[20])
        {
            Caption = 'Responsible Employee';
            TableRelation = Employee;
        }
        field(8; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(10; "PS Class Id"; Guid)
        {
            Caption = 'PS Class Id';
            TableRelation = "PS Class".SystemId;
            trigger OnValidate()
            var
                _PSClass: Record "PS Class";
            begin
                if IsNullGuid("PS Class Id") then begin
                    "PS Class Code" := '';
                    exit;
                end;
                _PSClass.GetBySystemId("PS Class Id");
                "PS Class Code" := _PSClass.Code;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Description") { }
        key(Key3; "PS Class Code") { }
        key(Key4; "Global Dimension 1 Code") { }
        key(Key5; "Global Dimension 2 Code") { }
        key(Key6; Description) { }
    }

    var
        ParkingSetup: Record "Parking Setup";
        ParkingSpot: Record "Parking Spot";
        NoSeriesMgt: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        InitPSNo();
    end;

    local procedure InitPSNo()
    begin
        if "No." = '' then begin
            ParkingSetup.Get();
            ParkingSetup.TestField("Parking Spot Nos.");
            if NoSeriesMgt.AreRelated(ParkingSetup."Parking Spot Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := ParkingSetup."Parking Spot Nos.";
            "No." := NoSeriesMgt.GetNextNo("No. Series", Today(), true);
            ParkingSpot.SetLoadFields("No.");
            while ParkingSpot.Get("No.") do
                "No." := NoSeriesMgt.GetNextNo("No. Series", Today(), true);
        end;
    end;

    procedure AssistEdit(OldPS: Record "Parking Spot") Result: Boolean
    begin
        ParkingSpot := Rec;
        ParkingSetup.Get();
        ParkingSetup.TestField("Parking Spot Nos.");
        if NoSeriesMgt.LookupRelatedNoSeries(ParkingSetup."Parking Spot Nos.", OldPS."No. Series", ParkingSpot."No. Series") then begin
            ParkingSpot."No." := NoSeriesMgt.GetNextNo(ParkingSpot."No.");
            Rec := ParkingSpot;
            exit(true);
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        if not IsTemporary then begin
            DimMgt.SaveDefaultDim(DATABASE::"Parking Spot", "No.", FieldNumber, ShortcutDimCode);
            Modify(true);
        end;
    end;
}