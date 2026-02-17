table 50106 "Parking Journal Line"
{
    Caption = 'Parking Journal Line';
    DrillDownPageId = "Parking Journal";
    LookupPageId = "Parking Journal";
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Entry Type"; Enum "Parking Ledger Entry Type")
        {
            Caption = 'Entry Type';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Parking Order No."; Code[20])
        {
            Caption = 'Parking Order No.';
            TableRelation = "Parking Document"."No.";
            trigger OnValidate()
            begin
                SetParkingJournalLineFields();
            end;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(7; "Parking Spot No."; Code[20])
        {
            Caption = 'Parking Spot No.';
            TableRelation = "Parking Spot"."No.";
        }
        field(8; "Parking Spot Unit No."; Code[20])
        {
            Caption = 'Parking Spot Unit No.';
            TableRelation = "Parking Spot Unit"."PS Unit No." where("Parking Spot No." = field("Parking Spot No."));
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(11; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(12; "Parking Start"; Date)
        {
            Caption = 'Parking Start';
            trigger OnValidate()
            begin
                CalcParkingDays();
            end;
        }
        field(13; "Parking End"; Date)
        {
            Caption = 'Parking End';
            trigger OnValidate()
            begin
                CalcParkingDays();
            end;
        }
        field(14; "Parking Days"; Integer)
        {
            Caption = 'Parking Days';
            trigger OnValidate()
            begin
                if ("Parking End" <> 0D) and ("Parking Start" <> 0D) and ("Parking Days" <> 0) then
                    "Parking End" := "Parking Start" + "Parking Days";
            end;
        }
    }
    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }
    var
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions() IsChanged: Boolean
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            Rec, "Dimension Set ID", StrSubstNo('Parking Journal Line %1', "Line No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure SetParkingJournalLineFields()
    var
        ParkingOrder: Record "Parking Document";
    begin
        if "Parking Order No." <> '' then begin
            ParkingOrder.Get("Parking Order No.");
            "Customer No." := ParkingOrder."Customer No.";
            "Parking Spot No." := ParkingOrder."Parking Spot No.";
            "Parking Spot Unit No." := ParkingOrder."Parking Spot Unit No.";
            "Shortcut Dimension 1 Code" := ParkingOrder."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ParkingOrder."Shortcut Dimension 2 Code";
            "Dimension Set ID" := ParkingOrder."Dimension Set ID";
            "Parking Start" := ParkingOrder."Parking Start";
            "Parking End" := ParkingOrder."Parking End";
            "Parking Days" := ParkingOrder."Parking Days";
        end;
    end;

    procedure CalcParkingDays()
    begin
        if ("Parking Start" <> 0D) and ("Parking End" <> 0D) then
            "Parking Days" := "Parking End" - "Parking Start";
    end;

    procedure EmptyLine(): Boolean
    begin
        exit(("Parking Order No." = '') and ("Parking Start" = 0D) and ("Parking End" = 0D) and ("Parking Days" = 0))
    end;
}