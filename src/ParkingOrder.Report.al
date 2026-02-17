report 50100 "Parking Order"
{
    Caption = 'Parking Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;
    PreviewMode = PrintLayout;
    WordMergeDataItem = ParkingOrder;

    dataset
    {
        dataitem(ParkingOrder; "Parking Document")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Customer No.", "Parking Spot No.", "Parking Spot Unit No.";

            column(No; "No.") { }
            column(Status; Status) { }
            column(CustomerNo; "Customer No.") { }
            column(CustomerName; "Customer Name") { }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code") { }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code") { }
            column(DimensionSetID; "Dimension Set ID") { }
            column(ParkingSpotNo; "Parking Spot No.") { }
            column(ParkingSpotDescription; "Parking Spot Description") { }
            column(ParkingSpotUnitNo; "Parking Spot Unit No.") { }
            column(ParkingSpotUnitDescription; "Parking Spot Unit Description") { }
            column(ParkingStart; "Parking Start") { }
            column(ParkingEnd; "Parking End") { }
            column(ParkingDays; "Parking Days") { }
            column(NoSeries; "No. Series") { }
        }
    }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = './src/Layout/ParkingOrder.docx';
        }
    }
}