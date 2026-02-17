page 50103 "Parking Spot List"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Parking Spot";
    CardPageId = "Parking Spot Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the parking spot.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies the class that the parking spot belongs to.';
                }
                field("PS Class Code"; Rec."PS Class Code")
                {
                    ToolTip = 'Specifies a search description for the parking spot.';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ToolTip = 'Specifies which employee is responsible for the parking spot.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the parking spot serial number.';
                }
                field("Blocked"; Rec.Blocked)
                {
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
            }
        }
    }
}