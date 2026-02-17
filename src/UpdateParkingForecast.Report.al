report 50102 "Update Parking Forecast"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Parking Forecast';

    dataset
    {
        dataitem(PSLocation; "PS Location")
        {
            RequestFilterFields = Code, "Date Filter";
            trigger OnAfterGetRecord()
            begin
                PSLocation.RequestParkingForecast(true);
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Message('Done!');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
    }
}