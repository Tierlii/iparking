page 50115 "Parking Orders API"
{
    PageType = API;
    Caption = 'Parking Orders';
    APIPublisher = 'student';
    APIGroup = 'carParkings';
    APIVersion = 'v2.0';
    EntityName = 'parkingOrder';
    EntitySetName = 'parkingOrders';
    SourceTable = "Parking Document";
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
                field("no"; Rec."No.") { }
                field(status; Rec.Status) { }
                field("customerNo"; Rec."Customer No.") { }
                field("customerName"; Rec."Customer Name") { }
                field("customerPhoneNo"; Rec."Customer Phone No.") { }
                field("customerEMail"; Rec."Customer E-Mail") { }
                field("dimensionSetID"; Rec."Dimension Set ID") { }
                field("shortcutDimension1Code"; Rec."Shortcut Dimension 1 Code") { }
                field("shortcutDimension2Code"; Rec."Shortcut Dimension 2 Code") { }
                field("noSeries"; Rec."No. Series") { }
                field("parkingSpotNo"; Rec."Parking Spot No.") { }
                field("parkingSpotId"; Rec."Parking Spot Id") { }
                field("parkingSpotDescription"; Rec."Parking Spot Description") { }
                field("parkingSpotUnitNo"; Rec."Parking Spot Unit No.") { }
                field("parkingSpotUnitId"; Rec."Parking Spot Unit Id") { }
                field("parkingSpotUnitDescription"; Rec."Parking Spot Unit Description") { }
                field("parkingStart"; Rec."Parking Start") { }
                field("parkingEnd"; Rec."Parking End") { }
                field("parkingDays"; Rec."Parking Days") { }
            }
        }
    }
}