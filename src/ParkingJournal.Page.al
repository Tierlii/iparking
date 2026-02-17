page 50109 "Parking Journal"
{
    Caption = 'Parking Journal';
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = true;
    AutoSplitKey = true;
    DelayedInsert = true;
    SourceTable = "Parking Journal Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the unique number of each line in the parking journal.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the type of transaction that will be posted from the parking journal line.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Parking Order No."; Rec."Parking Order No.")
                {
                    ToolTip = 'Specifies the number of the parking order associated with this journal line.';
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
                    ToolTip = 'Specifies the ID of the dimension set that groups multiple dimensions for this entry.';
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Posting")
            {
                Caption = 'Posting';
                Image = Post;

                action(Post)
                {
                    Caption = 'Post';
                    Image = PostBatch;
                    ShortcutKey = 'F9';
                    ToolTip = 'Finilize the document or journal by posting the amounts and quantities to the related ledgers in your company books.';

                    trigger OnAction()
                    begin
                        Codeunit.Run(Codeunit::"Parking Jnl.-Post", Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
}