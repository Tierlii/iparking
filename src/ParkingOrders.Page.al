page 50107 "Parking Orders"
{
    Caption = 'Parking Orders';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = "Parking Document";
    CardPageId = "Parking Order";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique identifier for the parking order.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the current status of the parking order.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer number for whom the parking order is created.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Release)
            {
                ApplicationArea = All;
                ToolTip = 'Release the selected order for processing.';
                trigger OnAction()
                begin
                    Rec.ReleaseOrder();
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                ToolTip = 'Reopen the selected order for modifications.';
                trigger OnAction()
                begin
                    Rec.ReOpenOrder();
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                ToolTip = 'Print the details of the selected order.';
                trigger OnAction()
                begin
                    Rec.PrintOrder();
                end;
            }
        }
    }
}