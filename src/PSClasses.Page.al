page 50102 "PS Classes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PS Class";
    AdditionalSearchTerms = 'parking spot classes category';
    Editable = true;
    Caption = 'PS Classes';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies a code for the class that the parking spot belongs to.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the parking spot class.';
                }
                field("Default PS Location Code"; Rec."Default PS Location Code")
                {
                    ToolTip = 'Specifies the default location of the parking spot class.';
                }
            }
        }
    }
}