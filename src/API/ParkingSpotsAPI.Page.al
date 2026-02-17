page 50113 "Parking Spots API"
{
    PageType = API;
    Caption = 'Parking Spots';
    APIPublisher = 'student';
    APIGroup = 'carParkings';
    APIVersion = 'v2.0';
    EntityName = 'parkingSpot';
    EntitySetName = 'parkingSpots';
    SourceTable = "Parking Spot";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System Id', Locked = true;
                }
                field(no; Rec."No.") { }
                field(description; Rec.Description) { }
                field("searchDescription"; Rec."Search Description") { }
                field("psClassCode"; Rec."PS Class Code") { }
                field("psClassId"; Rec."PS Class Id") { }
                field("responsibleEmployee"; Rec."Responsible Employee") { }
                field("globalDimension1Code"; Rec."Global Dimension 1 Code") { }
                field("globalDimension2Code"; Rec."Global Dimension 2 Code") { }
                field(blocked; Rec.Blocked) { }
                part(ParkingSpotUnis; "Parking Spot Units API")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Spot Units';
                    EntityName = 'parkingSpotUnit';
                    EntitySetName = 'parkingSpotUnits';
                    SubPageLink = "Parking Spot Id" = FIELD(SystemId);
                }
            }
        }
    }
}