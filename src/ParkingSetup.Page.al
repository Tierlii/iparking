page 50100 "Parking Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Parking Setup";
    Editable = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Parking Setup';

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Parking Spot Nos."; Rec."Parking Spot Nos.")
                {
                    ToolTip = 'Specifies the code for the number series that will be used to assing number to Parking Spots.';
                }
                field("Parking Order Nos."; Rec."Parking Order Nos.")
                {
                    ToolTip = 'Specifies the code for the number series that will be used to assing number to Parking orders.';
                }
            }
            group(Connector)
            {
                Caption = 'Connector';
                group(MapsAPI)
                {
                    Caption = 'Maps API';
                    field("Bing Maps Locations API URL"; Rec."Bing Maps Locations API URL")
                    {
                        ToolTip = 'Specifies the URL for the Bing Maps Locations API.';
                    }
                    field("Bing Maps API Key"; Rec."Bing Maps API Key")
                    {
                        ToolTip = 'Specifies the API Key for accessing Bing Maps services.';
                    }
                }
                group(ForecastAPI)
                {
                    Caption = 'Forecast API';

                    field("Parking Forecast API URL"; Rec."Parking Forecast API URL")
                    {
                        ToolTip = 'Specifies the URL endpoint for accessing the Parking Forecast API.';
                    }
                    field("Parking Forecast API Key"; Rec."Parking Forecast API Key")
                    {
                        ToolTip = 'Specifies the unique key required to authenticate requests to the Parking Forecast API.';
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}