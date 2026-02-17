page 50108 "Parking Order"
{
    Caption = 'Parking Order';
    PageType = Document;
    ApplicationArea = All;
    Editable = true;
    UsageCategory = None;
    SourceTable = "Parking Document";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique identifier for the parking order.';
                    ShowMandatory = true;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the current status of the parking order';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer number for whom the parking order is created';
                    ShowMandatory = true;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the name of the customer for whom the parking order is created';
                }
                field("Customer E-Mail"; Rec."Customer E-Mail")
                {
                    ToolTip = 'Specifies the email address of the customer for whom the parking order is created';
                }
                field("Customer Phone No."; Rec."Customer Phone No.")
                {
                    ToolTip = 'Specifies the phone number of the customer for whom the parking order is created';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the number series used for generating the parking order number';
                }
            }
            group(ParkingSpot)
            {
                Caption = 'Parking Spot';
                field("Parking Spot No."; Rec."Parking Spot No.")
                {
                    ToolTip = 'Specifies the identifier for the parking Spot being ordered.';
                    ShowMandatory = true;
                }
                field("Parking Spot Description"; Rec."Parking Spot Description")
                {
                    ToolTip = 'Displays the description of the selected parking spot.';
                }
                field("Parking Spot Unit No."; Rec."Parking Spot Unit No.")
                {
                    ToolTip = 'Specifies the unit number of the parking spot.';
                    ShowMandatory = true;
                }
                field("Parking Spot Unit Description"; Rec."Parking Spot Unit Description")
                {
                    ToolTip = 'Displays the description of the parking spot unit.';
                }
            }
            group(ParkingPeriod)
            {
                Caption = 'Parking Period';
                field("Parking Start"; Rec."Parking Start")
                {
                    ToolTip = 'Specifies the start date of the parking period.';
                    ShowMandatory = true;
                }
                field("Parking End"; Rec."Parking End")
                {
                    ToolTip = 'Specifies the end date of the parking period.';
                }
                field("Parking Days"; Rec."Parking Days")
                {
                    ToolTip = 'Displays the total number of days for the parking period.';
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
                Caption = 'Release Order';
                ToolTip = 'Release the selected order for processing.';
                trigger OnAction()
                begin
                    Rec.ReleaseOrder();
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen Order';
                ToolTip = 'Reopen the selected spot for modifications.';
                trigger OnAction()
                begin
                    Rec.ReOpenOrder();
                end;
            }
        }
        area(Reporting)
        {
            action(Print)
            {
                Caption = 'Print Order';
                ToolTip = 'Print the details of the selected spot.';
                trigger OnAction()
                begin
                    Rec.PrintOrder();
                end;
            }
        }
    }
}