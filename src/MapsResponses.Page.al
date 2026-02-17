page 50117 "Maps Responses"
{
    Caption = 'Maps Responses';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    Editable = false;
    SourceTable = "Maps Response Buffer";
    SourceTableTemporary = true;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the unique identifier for the entry.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the location entity identified on the map.';
                }
                field(Confidence; Rec.Confidence)
                {
                    ToolTip = 'Specifies the confidence level of the identification.';
                }
                field("Entity Type"; Rec."Entity Type")
                {
                    ToolTip = 'Specifies the type of entity identified.';
                }
                field("Country Region"; Rec."Country Region")
                {
                    ToolTip = 'Specifies the country or region where the location is situated.';
                }
                field("Admin District"; Rec."Admin District")
                {
                    ToolTip = 'Specifies the administrative district or division within the country or region.';
                }
                field(Locality; Rec.Locality)
                {
                    ToolTip = 'Specifies the locality or area within administrative district.';
                }
                field("Coordinates Latitude"; Rec."Coordinates Latitude")
                {
                    ToolTip = 'Specifies the latitude coordinates of the location.';
                }
                field("Coordinates Longitude"; Rec."Coordinates Longitude")
                {
                    ToolTip = 'Specifies the longitude coordinates of the location.';
                }
            }
        }
    }
}