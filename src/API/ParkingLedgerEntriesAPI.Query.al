query 50100 "Parking Ledger Entries API"
{
    QueryType = API;
    APIPublisher = 'student';
    APIGroup = 'carParkings';
    APIVersion = 'v2.0';
    EntityName = 'parkingLedgerEntry';
    EntitySetName = 'parkingLedgerEntries';

    elements
    {
        dataitem(ParkingLedgerEntry; "Parking Ledger Entry")
        {
            column(entryNo; "Entry No.") { }
            column(eEntryType; "Entry Type") { }
            column(documentNo; "Document No.") { }
            column(postingDate; "Posting Date") { }
            column(parkingOrderNo; "Parking Order No.") { }
            column(customerNo; "Customer No.") { }
            column(parkingSpotNo; "Parking Spot No.") { }
            column(parkingSpotUnitNo; "Parking Spot Unit No.") { }
            column(dimensionSetID; "Dimension Set ID") { }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code") { }
            column(shortcutDimension2Code; "Shortcut Dimension 2 Code") { }
            column(parkingStart; "Parking Start") { }
            column(parkingEnd; "Parking End") { }
            column(parkingDays; "Parking Days") { }
            column(daysExpected; "Days (Expected)") { }
            column(daysActual; "Days (Actual)") { }
            column(daysInvoiced; "Days (Invoiced)") { }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}