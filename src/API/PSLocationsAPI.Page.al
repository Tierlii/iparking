page 50111 "PS Locations API"
{
    PageType = API;
    Caption = 'PS Locations';
    APIPublisher = 'student';
    APIGroup = 'carParkings';
    APIVersion = 'v2.0';
    EntityName = 'psLocation';
    EntitySetName = 'psLocations';
    SourceTable = "PS Location";
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
                field(code; Rec.Code) { }
                field(name; Rec.Name) { }
            }
        }
    }
}