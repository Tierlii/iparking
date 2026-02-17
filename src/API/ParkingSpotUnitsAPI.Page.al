page 50114 "Parking Spot Units API"
{
    PageType = API;
    Caption = 'Parking Spot Units';
    APIPublisher = 'student';
    APIGroup = 'carParkings';
    APIVersion = 'v2.0';
    EntityName = 'parkingSpotUnit';
    EntitySetName = 'parkingSpotUnits';
    SourceTable = "Parking Spot Unit";
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
                field("parkingSpotId"; Rec."Parking Spot Id") { }
                field("parkingSpotNo"; Rec."Parking Spot No.") { }
                field("psUnitNo"; Rec."PS Unit No.") { }
                field(description; Rec.Description) { }
                field("psLocationcode"; Rec."PS Location Code") { }
                field("psLocationId"; Rec."PS Location Id") { }
                field("serialNo"; Rec."Serial No.") { }
                field(blocked; Rec.Blocked) { }
            }
        }
    }
}