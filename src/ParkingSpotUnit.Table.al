table 50104 "Parking Spot Unit"
{
    Caption = 'Parking Spot Unit';
    DrillDownPageId = "Parking Spot Unit List";
    LookupPageId = "Parking Spot Unit List";

    fields
    {
        field(1; "Parking Spot No."; Code[20])
        {
            Caption = 'Parking Spot No.';
            TableRelation = "Parking Spot";

            trigger OnValidate()
            var
                _ParkingSpot: Record "Parking Spot";
            begin
                if "Parking Spot No." = '' then begin
                    Clear("Parking Spot Id");
                    exit;
                end;
                _ParkingSpot.Get("Parking Spot No.");
                "Parking Spot Id" := _ParkingSpot.SystemId;
            end;
        }
        field(2; "PS Unit No."; Code[20])
        {
            Caption = 'Parking Spot Unit No.';
            trigger OnValidate()
            var
                ParkingSpot: Record "Parking Spot";
                PSClass: Record "PS Class";
            begin
                if Rec."Parking Spot No." = '' then
                    exit;
                ParkingSpot.Get(Rec."Parking Spot No.");
                ParkingSpot.TestField("PS Class Code");
                PSClass.Get(ParkingSpot."PS Class Code");
                PSClass.TestField("Default PS Location Code");
                Rec.Validate("PS Location Code", PSClass."Default PS Location Code");
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "PS Location Code"; Code[10])
        {
            Caption = 'PS Location Code';
            TableRelation = "PS Location";

            trigger OnValidate()
            var
                _PSLocation: Record "PS Location";
            begin
                if "PS Location Code" = '' then begin
                    Clear("PS Location Id");
                    exit;
                end;
                _PSLocation.Get("PS Location Code");
                "PS Location Id" := _PSLocation.SystemId;
            end;
        }
        field(5; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }

        field(7; "Parking Spot Id"; Guid)
        {
            Caption = 'Parking Spot Id';
            TableRelation = "Parking Spot".SystemId;
            trigger OnValidate()
            var
                _ParkingSpot: Record "Parking Spot";
            begin
                if IsNullGuid("Parking Spot Id") then begin
                    "Parking Spot No." := '';
                    exit;
                end;
                _ParkingSpot.GetBySystemId("Parking Spot Id");
                "Parking Spot No." := _ParkingSpot."No.";
            end;
        }

        field(8; "PS Location Id"; Guid)
        {
            Caption = 'PS Location Id';
            TableRelation = "PS Location".SystemId;
            trigger OnValidate()
            var
                _PSLocation: Record "PS Location";
            begin
                if IsNullGuid("PS Location Id") then begin
                    "PS Location Code" := '';
                    exit;
                end;
                _PSLocation.GetBySystemId("PS Location Id");
                "PS Location Code" := _PSLocation.Code;
            end;
        }
    }

    keys
    {
        key(Key1; "Parking Spot No.", "PS Unit No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        _ParkingSpot: Record "Parking Spot";
    begin

        if "Parking Spot No." <> '' then begin
            _ParkingSpot.Get("Parking Spot No.");
            "Parking Spot Id" := _ParkingSpot.SystemId;
        end else begin
            TestField("Parking Spot Id");
            _ParkingSpot.GetBySystemId("Parking Spot Id");
            "Parking Spot No." := _ParkingSpot."No.";
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}