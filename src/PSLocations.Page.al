page 50101 "PS Locations"
{
    AdditionalSearchTerms = 'parking spot locations departments sites offices';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PS Location";
    Caption = 'PS Locations';
    CardPageId = "PS Location Card";
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies a location code for the parking spot.';
                }
                field("Name"; Rec.Name)
                {
                    ToolTip = 'Specifies a name of the parking spot location.';
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
}