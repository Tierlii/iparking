table 50101 "PS Location"
{
    Caption = 'PS Location';
    LookupPageId = "PS Locations";
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Name"; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Maps Country Region"; Text[50])
        {
            Caption = 'Maps Country Region';
        }
        field(4; "Maps Admin District"; Text[50])
        {
            Caption = 'Maps Admin District';
        }
        field(5; "Maps Locality"; Text[50])
        {
            Caption = 'Maps Locality';
        }
        field(6; "Maps Coordinates Latitude"; Code[30])
        {
            Caption = 'Maps Coordinates Latitude';
        }
        field(7; "Maps Coordinates Longitude"; Code[30])
        {
            Caption = 'Maps Coordinates Longitude';
        }
        field(8; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    procedure RequestCoordinates()
    var
        _ParkingSetup: Record "Parking Setup";
        _MapsResponseBuffer: Record "Maps Response Buffer" temporary;
        _EntryNo: Integer;
        _HttpClient: HttpClient;
        _HttpResponseMessage: HttpResponseMessage;
        _ResponseText: Text;
        _JsonMessage: JsonObject;
        _JsonToken: JsonToken;
        _JsonResourceSets: JsonArray;
        _JsonResourceSet: JsonObject;
        _JsonResources: JsonArray;
        _JsonResource: JsonObject;
        _JsonAddress: JsonObject;
        _JsonCoordinates: JsonArray;
    begin
        _ParkingSetup.Get();
        _ParkingSetup.TestField("Bing Maps Locations API URL");
        _ParkingSetup.TestField("Bing Maps API Key");
        if not _HttpClient.Get(
            StrSubstNo(_ParkingSetup."Bing Maps Locations API URL",
                "Maps Country Region",
                "Maps Admin District",
                "Maps Locality",
                _ParkingSetup."Bing Maps API Key"),
            _HttpResponseMessage)
        then
            Error('GET request failed: %1', _HttpResponseMessage.ReasonPhrase);
        if not _HttpResponseMessage.IsSuccessStatusCode then
            Error(_HttpResponseMessage.ReasonPhrase);
        _HttpResponseMessage.Content.ReadAs(_ResponseText);
        _JsonMessage.ReadFrom(_ResponseText);
        _JsonMessage.Get('resourceSets', _JsonToken);
        _JsonResourceSets := _JsonToken.AsArray();
        _JsonResourceSets.Get(0, _JsonToken);
        _JsonResourceSet := _JsonToken.AsObject();
        _JsonResourceSet.Get('resources', _JsonToken);
        _JsonResources := _JsonToken.AsArray();
        for _EntryNo := 1 to _JsonResources.Count() do begin
            _JsonResources.Get(_EntryNo - 1, _JsonToken);
            _JsonResource := _JsonToken.AsObject();
            Clear(_MapsResponseBuffer);
            _MapsResponseBuffer.Init();
            _MapsResponseBuffer."Entry No." := _EntryNo;
            _JsonResource.Get('name', _JsonToken);
            _MapsResponseBuffer.Name := _JsonToken.AsValue().AsText();
            _JsonResource.Get('confidence', _JsonToken);
            _MapsResponseBuffer.Confidence := _JsonToken.AsValue().AsText();
            _JsonResource.Get('entityType', _JsonToken);
            _MapsResponseBuffer."Entity Type" := _JsonToken.AsValue().AsText();
            //Address
            _JsonResource.Get('address', _JsonToken);
            _JsonAddress := _JsonToken.AsObject();
            if _JsonAddress.Get('countryRegion', _JsonToken) then
                _MapsResponseBuffer."Country Region" := _JsonToken.AsValue().AsText();
            if _JsonAddress.Get('adminDistrict', _JsonToken) then
                _MapsResponseBuffer."Admin District" := _JsonToken.AsValue().AsText();
            if _JsonAddress.Get('locality', _JsonToken) then
                _MapsResponseBuffer.Locality := _JsonToken.AsValue().AsText();
            //Coordinates
            _JsonResource.Get('point', _JsonToken);
            _JsonToken.AsObject().Get('coordinates', _JsonToken);
            _JsonCoordinates := _JsonToken.AsArray();
            _JsonCoordinates.Get(0, _JsonToken);
            _MapsResponseBuffer."Coordinates Latitude" := _JsonToken.AsValue().AsText();
            _JsonCoordinates.Get(1, _JsonToken);
            _MapsResponseBuffer."Coordinates Longitude" := _JsonToken.AsValue().AsText();
            _MapsResponseBuffer.Insert();
        end;
        Commit();
        _MapsResponseBuffer.FindFirst();
        if Page.RunModal(Page::"Maps Responses", _MapsResponseBuffer) = Action::LookupOK then begin
            "Maps Country Region" := _MapsResponseBuffer."Country Region";
            "Maps Admin District" := _MapsResponseBuffer."Admin District";
            "Maps Locality" := _MapsResponseBuffer.Locality;
            "Maps Coordinates Latitude" := _MapsResponseBuffer."Coordinates Latitude";
            "Maps Coordinates Longitude" := _MapsResponseBuffer."Coordinates Longitude";
            Modify(true);
            Message('Maps data modified.');
        end;
    end;

    procedure RequestParkingForecast()
    begin
        RequestParkingForecast(false);
    end;

    procedure RequestParkingForecast(p_silent: Boolean)
    var
        _FromDate: Date;
        _ToDate: Date;
        _Date: Record Date;
        _JsonObject: JsonObject;
        _JsonArray: JsonArray;
        _JsonToken: JsonToken;
        _JsonMessage: JsonObject;
        _HttpClient: HttpClient;
        _HttpContent: HttpContent;
        _HttpContentHeaders: HttpHeaders;
        _HttpResponseMessage: HttpResponseMessage;
        _RequestText: Text;
        _ResponseText: Text;
        _Weekday: Integer;
        _WorkingDay: Integer;
        _ParkingSetup: Record "Parking Setup";
        _ParkingForecast: Record "Parking Forecast";
        _EntriesCount: Integer;
    begin
        _ParkingSetup.Get();
        _ParkingSetup.TestField("Parking Forecast API URL");
        _ParkingSetup.TestField("Parking Forecast API Key");
        if GetFilter("Date Filter") <> '' then begin
            _FromDate := GetRangeMax("Date Filter");
            _ToDate := GetRangeMax("Date Filter");
        end;
        if _FromDate = 0D then
            _FromDate := Today;
        if _ToDate = 0D then
            _ToDate := CalcDate('<+10D>', _FromDate);
        _Date.Reset();
        _Date.SetRange("Period Type", _Date."Period Type"::Date);
        _Date.SetRange("Period Start", _FromDate, _ToDate);
        _EntriesCount := 0;
        if _Date.FindFirst() then
            repeat
                _Weekday := Date2DWY(_Date."Period Start", 1);
                if _Weekday <= 5 then
                    _WorkingDay := 1
                else
                    _WorkingDay := 0;
                if _Weekday = 7 then
                    _Weekday := 0;
                Clear(_JsonObject);
                _JsonObject.Add('day', Date2DMY(_Date."Period Start", 1));
                _JsonObject.Add('mnth', Date2DMY(_Date."Period Start", 2));
                _JsonObject.Add('year', Date2DMY(_Date."Period Start", 3));
                _JsonObject.Add('holiday', 0);
                _JsonObject.Add('weekday', _Weekday);
                _JsonObject.Add('workingday', _WorkingDay);
                _JsonObject.Add('temp', 0.5);
                _JsonObject.Add('hum', 0.5);
                _JsonObject.Add('windspeed', 0.5);
                Clear(_JsonArray);
                _JsonArray.Add(_JsonObject);
                Clear(_JsonObject);
                _JsonObject.Add('data', _JsonArray);
                Clear(_JsonMessage);
                _JsonMessage.Add('Inputs', _JsonObject);
                _JsonMessage.Add('GlobalParameters', 0.0);
                _JsonMessage.WriteTo(_RequestText);
                Clear(_HttpContent);
                Clear(_HttpContentHeaders);
                _HttpContent.WriteFrom(_RequestText);
                _HttpContent.GetHeaders(_HttpContentHeaders);
                _HttpContentHeaders.Remove('Content-Type');
                _HttpContentHeaders.Add('Content-Type', 'application/json');
                Clear(_HttpClient);
                Clear(_HttpResponseMessage);
                _HttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Bearer %1', _ParkingSetup."Parking Forecast API Key"));
                if not _HttpClient.Post(_ParkingSetup."Parking Forecast API URL", _HttpContent, _HttpResponseMessage) then
                    Error('POST request failed: %1', _HttpResponseMessage.ReasonPhrase);
                if not _HttpResponseMessage.IsSuccessStatusCode then
                    Error(_HttpResponseMessage.ReasonPhrase);
                _HttpResponseMessage.Content.ReadAs(_ResponseText);
                Clear(_JsonMessage);
                Clear(_JsonArray);
                Clear(_JsonToken);
                _JsonMessage.ReadFrom(_ResponseText);
                _JsonMessage.Get('Results', _JsonToken);
                _JsonArray := _JsonToken.AsArray();
                _JsonArray.Get(0, _JsonToken);
                if not _ParkingForecast.Get(Code, _Date."Period Start") then begin
                    Clear(_ParkingForecast);
                    _ParkingForecast.Init();
                    _ParkingForecast."PS Location Code" := Code;
                    _ParkingForecast."Forecast Date" := _Date."Period Start";
                    _ParkingForecast.Insert(true);
                end;
                _ParkingForecast."Updated At" := CurrentDateTime();
                _ParkingForecast.Amount := _JsonToken.AsValue().AsDecimal();
                _ParkingForecast.Modify(true);
                _EntriesCount += 1;
            until _Date.Next() = 0;
        if not p_silent then
            Message('Parking Forecast modified, %1 entries.', _EntriesCount);
    end;
}