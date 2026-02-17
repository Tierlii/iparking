page 50118 "Parking Forecast"
{
    PageType = List;
    Caption = 'Parking Forecast';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Parking Forecast";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("PS Location Code"; Rec."PS Location Code")
                {
                    ToolTip = 'Specifies the unique code identifying the parking area location.';
                }
                field("Forecast Date"; Rec."Forecast Date")
                {
                    ToolTip = 'Specifies the date for which the parking forecast is applicable.';
                }
                field("Updated At"; Rec."Updated At")
                {
                    ToolTip = 'Specifies the last date and time the forecast data was updated.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the forecasted number of parkings expected';
                }
            }
        }
    }
}