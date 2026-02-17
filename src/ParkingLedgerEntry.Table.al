table 50107 "Parking Ledger Entry"
{
    Caption = 'Parking Ledger Entry';
    DrillDownPageId = "Parking Ledger Entries";
    LookupPageId = "Parking Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
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
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(11; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(12; "Parking Start"; Date)
        {
            Caption = 'Parking Start';
        }
        field(13; "Parking End"; Date)
        {
            Caption = 'Parking End';
        }
        field(14; "Parking Days"; Integer)
        {
            Caption = 'Parking Days';
        }
        field(15; "Days (Expected)"; Integer)
        {
            Caption = 'Days (Expected)';
        }
        field(16; "Days (Actual)"; Integer)
        {
            Caption = 'Days (Actual)';
        }
        field(17; "Days (Invoiced)"; Integer)
        {
            Caption = 'Days (Invoiced)';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Parking Order No.") { }
        key(Key3; "Posting Date", "Customer No.") { }
        key(Key4; "Parking Spot No.", "Parking Start") { }
        key(Key5; "Parking Spot Unit No.", "Parking End") { }
        key(Key6; "Parking Days") { }
    }


    var
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    var
        _ParkingLedgerEntry: Record "Parking Ledger Entry";
    begin
        if "Entry No." = 0 then begin
            _ParkingLedgerEntry.Reset();
            if _ParkingLedgerEntry.FindLast() then
                "Entry No." := _ParkingLedgerEntry."Entry No." + 1
            else
                "Entry No." := 1;
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

    procedure ShowDimensions() IsChanged: Boolean
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption(), "Entry No."));
    end;

    procedure CopyFromParkingJnlLine(ParkingJnlLine: Record "Parking Journal Line")
    begin
        "Entry Type" := ParkingJnlLine."Entry Type";
        "Document No." := ParkingJnlLine."Document No.";
        "Posting Date" := ParkingJnlLine."Posting Date";

        "Parking Order No." := ParkingJnlLine."Parking Order No.";
        "Customer No." := ParkingJnlLine."Customer No.";
        "Parking Spot No." := ParkingJnlLine."Parking Spot No.";
        "Parking Spot Unit No." := ParkingJnlLine."Parking Spot Unit No.";

        "Parking Start" := ParkingJnlLine."Parking Start";
        "Parking End" := ParkingJnlLine."Parking End";
        "Parking Days" := ParkingJnlLine."Parking Days";

        "Shortcut Dimension 1 Code" := ParkingJnlLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ParkingJnlLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ParkingJnlLine."Dimension Set ID";
    end;
}