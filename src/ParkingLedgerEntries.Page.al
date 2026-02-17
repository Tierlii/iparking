page 50110 "Parking Ledger Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Parking Ledger Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the unique number of each line in the parking ledger.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies which type of transaction that the entry is created from.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number on the entry. The document is the voucher that the entry was based on.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Parking Order No."; Rec."Parking Order No.")
                {
                    ToolTip = 'Specifies the number of the parking order associated with this entry.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer occupying the spot.';
                }
                field("Parking Spot No."; Rec."Parking Spot No.")
                {
                    ToolTip = 'Specifies the number of the spot being occupied.';
                }
                field("Parking Spot Unit No."; Rec."Parking Spot Unit No.")
                {
                    ToolTip = 'Specifies the unit number of the parking spot.';
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
                field("Parking Start"; Rec."Parking Start")
                {
                    ToolTip = 'Specifies the start date of the parking period for the spot.';
                }
                field("Parking End"; Rec."Parking End")
                {
                    ToolTip = 'Specifies the end date of the parking period for the spot.';
                }
                field("Parking Days"; Rec."Parking Days")
                {
                    ToolTip = 'Specifies the total number of days for which the spot is occupied.';
                }
                field("Days (Expected)"; Rec."Days (Expected)")
                {
                    ToolTip = 'The expected number of days for the parking.';
                }
                field("Days (Actual)"; Rec."Days (Actual)")
                {
                    ToolTip = 'The actual number of days the spot was occupied.';
                }
                field("Days (Invoiced)"; Rec."Days (Invoiced)")
                {
                    ToolTip = 'The number of days invoiced to the customer for the parking.';
                }
            }
        }
    }
}