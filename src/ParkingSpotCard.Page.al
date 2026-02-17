page 50105 "Parking Spot Card"
{
    Caption = 'Parking Spot Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    Editable = true;
    SourceTable = "Parking Spot";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the parking spot.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies a search description for the parking spot.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a Global Dimension 1 Code for the parking spot.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a Global Dimension 2 Code for the parking spot.';
                }
                field("PS Class Code"; Rec."PS Class Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the class that the parking spot belongs to.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the parking spots serial number.';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies which employee is responsible for the parking spot.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
            }
            part(ParkingSpotUnits; "Parking Spot Units Subpage")
            {
                Caption = 'Parking Spot Units';
                SubPageLink = "Parking Spot No." = field("No.");
            }
        }

        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Parking Spot"),
                    "No." = field("No.");
            }
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                SubPageLink = "Table ID" = const(Database::"Parking Spot"),
                    "No." = field("No.");
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
}