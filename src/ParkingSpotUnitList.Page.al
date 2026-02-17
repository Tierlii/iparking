page 50104 "Parking Spot Unit List"
{
    Caption = 'Parking Spot Units';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Parking Spot Unit";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Parking Spot No."; Rec."Parking Spot No.")
                {
                    ToolTip = 'Specifies the number of the related parking spot number.';
                }
                field("PS Unit No."; Rec."PS Unit No.")
                {
                    ToolTip = 'Specifies the number of the related parking spot unit no.';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the parking spot unit task.';
                }
                field("PS Location Code"; Rec."PS Location Code")
                {
                    ToolTip = 'Specifies a location of the parking spot unit.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies a serial number of the parking spot unit.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies if parking spot unit is blocked from being rented out.';
                }
            }
        }
    }
}