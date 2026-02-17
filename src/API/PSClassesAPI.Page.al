page 50112 "PS Classes API"
{
    PageType = API;
    Caption = 'PS Classes';
    APIPublisher = 'student';
    APIGroup = 'carParkings';
    APIVersion = 'v2.0';
    EntityName = 'psClass';
    EntitySetName = 'psClasses';
    SourceTable = "PS Class";
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
                field(defPSLocationCode; Rec."Default PS Location Code") { }
                field(defPSLocationId; Rec."Default PS Location Id") { }
            }
        }
    }
}