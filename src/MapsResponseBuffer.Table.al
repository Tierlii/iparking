table 50108 "Maps Response Buffer"
{
    Caption = 'Maps Response Buffer';
    TableType = Temporary;
    LookupPageId = "Maps Responses";
    DrillDownPageId = "Maps Responses";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Name"; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Confidence"; Text[20])
        {
            Caption = 'Confidence';
        }
        field(4; "Entity Type"; Text[20])
        {
            Caption = 'Entity Type';
        }
        field(5; "Country Region"; Text[50])
        {
            Caption = 'Country Region';
        }
        field(6; "Admin District"; Text[50])
        {
            Caption = 'Admin District';
        }
        field(7; "Locality"; Text[50])
        {
            Caption = 'Locality';
        }
        field(8; "Coordinates Latitude"; Code[30])
        {
            Caption = 'Coordinates Latitude';
        }
        field(9; "Coordinates Longitude"; Code[30])
        {
            Caption = 'Coordinates Longitude';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
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