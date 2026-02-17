page 50116 "PS Location Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "PS Location";
    Caption = 'PS Location Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies a location code for the parking spot.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the parking spot location.';
                }
            }
            group(Maps)
            {
                Caption = 'Maps';
                field("Maps Country Region"; Rec."Maps Country Region")
                {
                    ToolTip = 'Specifies the country or region of the location on maps.';
                }
                field("Maps Admin District"; Rec."Maps Admin District")
                {
                    ToolTip = 'Specifies the administrative district of the location on maps.';
                }
                field("Maps Locality"; Rec."Maps Locality")
                {
                    ToolTip = 'Specifies the locality or area of the location on maps.';
                }
                field("Maps Coordinates Latitude"; Rec."Maps Coordinates Latitude")
                {
                    ToolTip = 'Specifies the latitude coordinates of the location on maps.';
                }
                field("Maps Coordinates Longitude"; Rec."Maps Coordinates Longitude")
                {
                    ToolTip = 'Specifies the longitude coordinates of the location on maps.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(RequestCoordinates)
            {
                Caption = 'Request Coordinates';
                Image = ImportCodes;
                ToolTip = 'Initiates a request to retrieve coordinates for the location.';
                trigger OnAction()
                begin

                    Rec.RequestCoordinates();
                end;
            }
            action(RequestParkingForecast)
            {
                Caption = 'Request Parking Forecast';
                Image = ImportCodes;
                ToolTip = 'Initiates a process to retrieve and display the parking forecast for a specific location.';
                trigger OnAction()
                begin
                    Rec.RequestParkingForecast();
                end;
            }
        }
        area(Navigation)
        {
            action(ParkingForecast)
            {
                Caption = 'Parking Forecast';
                Image = Entries;
                RunObject = page "Parking Forecast";
                RunPageLink = "PS Location Code" = field(Code);
                ToolTip = 'Access the parking forecast page to view and analyze predicted parking activity for a chosen location';
            }
        }
    }
}