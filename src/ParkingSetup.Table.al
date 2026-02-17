table 50100 "Parking Setup"
{
    Caption = 'Parking Setup';
    LookupPageId = "Parking Setup";


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Parking Spot Nos."; Code[20])
        {
            Caption = 'Parking Spot Nos.';
            TableRelation = "No. Series";
            OptimizeForTextSearch = true;
        }
        field(3; "Parking Order Nos."; Code[20])
        {
            Caption = 'Parking Order Nos.';
            TableRelation = "No. Series";
            OptimizeForTextSearch = true;
        }
        field(4; "Bing Maps Locations API URL"; Text[250])
        {
            Caption = 'Bing Maps Locations API URL';
        }
        field(5; "Bing Maps API Key"; Text[100])
        {
            Caption = 'Bing Maps API Key';
        }
        field(6; "Parking Forecast API URL"; Text[250])
        {
            Caption = 'Parking Forecast API URL';
        }
        field(7; "Parking Forecast API Key"; Text[100])
        {
            Caption = 'Parking Forecast API Key';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}