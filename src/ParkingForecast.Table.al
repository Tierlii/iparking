table 50109 "Parking Forecast"
{
    Caption = 'Parking Forecast';
    LookupPageId = "Parking Forecast";
    DrillDownPageId = "Parking Forecast";
    
    fields
    {
        field(1; "PS Location Code"; Code[10])
        {
            Caption = 'PS Location Code';
            TableRelation = "PS Location";
        }
        field(2; "Forecast Date"; Date)
        {
            Caption = 'Forecast Date';
        }
        field(3; "Updated At"; DateTime)
        {
            Caption = 'Updated At';
        }
        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(Key1; "PS Location Code", "Forecast Date")
        {
            Clustered = true;
        }
    }
}