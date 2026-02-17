table 50105 "Parking Document"
{
    Caption = 'Parking Order';
    DataCaptionFields = "No.";
    DrillDownPageId = "Parking Orders";
    LookupPageId = "Parking Orders";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            OptimizeForTextSearch = true;
            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    ParkingSetup.Get();
                    NoSeries.TestManual(ParkingSetup."Parking Order Nos.");
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(2; Status; Enum "Parking Order Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            OptimizeForTextSearch = true;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestStatusOpen();
                CreateDimFromDefaultDim(Rec.FieldNo("Customer No."));
                if "Customer No." <> '' then begin
                    Customer.Get("Customer No.");
                    Customer.TestField(Blocked, 0);
                    Validate("Customer Name", Customer.Name);
                    Validate("Customer E-Mail", Customer."E-Mail");
                    Validate("Customer Phone No.", Customer."Phone No.");
                end;
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(5; "Customer E-Mail"; Text[80])
        {
            Caption = 'Customer E-mail';
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Customer E-Mail");
            end;
        }
        field(6; "Customer Phone No."; Text[30])
        {
            Caption = 'Customer Phone No-';
            ExtendedDatatype = PhoneNo;
        }
        field(7; "Parking Spot No."; Code[20])
        {
            Caption = 'Parking Spot No.';
            TableRelation = "Parking Spot"."No.";


            trigger OnValidate()
            var
                _ParkingSpot: Record "Parking Spot";

            begin
                if "Parking Spot No." = '' then begin
                    Clear("Parking Spot Id");
                    exit;
                end;

                _ParkingSpot.Get("Parking Spot No.");
                "Parking Spot Id" := _ParkingSpot.SystemId;

                UpdateParkingSpot();
            end;
        }
        field(8; "Parking Spot Description"; Text[100])
        {
            Caption = 'Parking Spot Description';
        }
        field(9; "Parking Spot Unit No."; Code[20])
        {
            Caption = 'Parking Spot Unit No.';
            TableRelation = "Parking Spot Unit"."PS Unit No." where("Parking Spot No." = field("Parking Spot No."));

            trigger OnValidate()
            var
                _ParkingSpotUnit: Record "Parking Spot Unit";
            begin
                if "Parking Spot Unit No." = '' then begin
                    Clear("Parking Spot Unit Id");
                    exit;
                end;

                _ParkingSpotUnit.Get("Parking Spot No.", "Parking Spot Unit No.");
                "Parking Spot Unit Id" := _ParkingSpotUnit.SystemId;

                UpdateParkingSpotUnit();
            end;
        }
        field(10; "Parking Spot Unit Description"; Text[100])
        {
            Caption = 'Parking Spot Unit Description';
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(14; "Parking Start"; Date)
        {
            Caption = 'Parking Start';
            trigger OnValidate()
            begin
                TestStatusOpen();
                if ("Parking Start" <> 0D) and ("Parking End" <> 0D) then
                    "Parking Days" := "Parking End" - "Parking Start";
            end;
        }
        field(15; "Parking End"; Date)
        {
            Caption = 'Parking End';
            trigger OnValidate()
            begin
                TestStatusOpen();
                if ("Parking Start" <> 0D) and ("Parking End" <> 0D) then
                    "Parking Days" := "Parking End" - "Parking Start";
            end;
        }
        field(16; "Parking Days"; Integer)
        {
            Caption = 'Parking Days';
            trigger OnValidate()
            begin
                TestStatusOpen();
                if ("Parking Start" <> 0D) and ("Parking End" <> 0D) then
                    "Parking End" := "Parking Start" - "Parking Days";
            end;
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(18; "Parking Spot Id"; Guid)
        {
            Caption = 'Parking Spot Id';
            TableRelation = "Parking Spot".SystemId;
            trigger OnValidate()
            var
                _ParkingSpot: Record "Parking Spot";
            begin
                if IsNullGuid("Parking Spot Id") then begin
                    "Parking Spot No." := '';
                    exit;
                end;

                _ParkingSpot.GetBySystemId("Parking Spot Id");
                "Parking Spot No." := _ParkingSpot."No.";

                UpdateParkingSpot();
            end;
        }
        field(19; "Parking Spot Unit Id"; Guid)
        {
            Caption = 'Parking Spot Unit Id';
            TableRelation = "Parking Spot Unit".SystemId;
            trigger OnValidate()
            var
                _ParkingSpotUnit: Record "Parking Spot Unit";
            begin
                if IsNullGuid("Parking Spot Unit Id") then begin
                    "Parking Spot No." := '';
                    "Parking Spot Unit No." := '';
                    exit;
                end;

                _ParkingSpotUnit.GetBySystemId("Parking Spot Unit Id");
                "Parking Spot No." := _ParkingSpotUnit."Parking Spot No.";
                "Parking Spot Unit No." := _ParkingSpotUnit."PS Unit No.";

                UpdateParkingSpot();
                UpdateParkingSpotUnit();
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var
        ParkingSetup: Record "Parking Setup";
        ParkingOrder: Record "Parking Document";
        NoSeries: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
        StatusCheckSuspended: Boolean;

    trigger OnInsert()
    begin
        InitOrderNo();
    end;

    local procedure InitOrderNo()
    begin
        if "No." = '' then begin
            ParkingSetup.Get();
            ParkingSetup.TestField("Parking Order Nos.");
            if NoSeries.AreRelated(ParkingSetup."Parking Order Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := ParkingSetup."Parking Order Nos.";
            "No." := NoSeries.GetNextNo("No. Series", Today(), true);
            ParkingOrder.SetLoadFields("No.");
            while ParkingOrder.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series", Today(), true);
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
         DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('Parking Oder %1', "No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IsChanged := OldDimSetID <> "Dimension Set ID";
    end;

    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        if not DimMgt.IsDefaultDimDefinedForTable(GetTableValuePair(FieldNo)) then exit;
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    local procedure GetTableValuePair(FieldNo: Integer) TableValuePair: Dictionary of [Integer, Code[20]];
    begin
        case true of
            FieldNo = Rec.FieldNo("Customer No."):
                TableValuePair.Add(Database::Customer, Rec."Customer No.");
            FieldNo = Rec.FieldNo("Parking Spot No."):
                TableValuePair.Add(Database::"Parking Spot", Rec."Parking Spot No.");
        end;
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::Customer, Rec."Customer No.", FieldNo = Rec.FieldNo("Customer No."));
        DimMgt.AddDimSource(DefaultDimSource, Database::"Parking Spot", Rec."Parking Spot No.", FieldNo = Rec.FieldNo("Parking Spot No."));
    end;

    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        SourceCodeSetup.Get();
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
            DimMgt.GetRecDefaultDimID(
                Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Sales,
                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure TestStatusOpen()
    begin
        if StatusCheckSuspended then
            exit;
        TestField(Status, Status::Open);
    end;

    procedure ReleaseOrder()
    begin
        Rec.TestField(Status, "Parking Order Status"::Open);
        Rec.TestField("No.");
        Rec.TestField("Customer No.");
        Rec.TestField("Parking Spot No.");
        Rec.TestField("Parking Start");
        Rec.TestField("Parking End");
        Rec.TestField("Parking Days");
        Rec.Status := "Parking Order Status"::Released;
        Rec.Modify(true);
    end;

    procedure ReOpenOrder()
    begin
        Rec.TestField(Status, "Parking Order Status"::Released);
        Rec.Status := "Parking Order Status"::Open;
        Rec.Modify(true);
    end;

    procedure PrintOrder()
    var
        _recParkingOder: Record "Parking Document";
        _repParkingOrder: Report "Parking Order";
    begin
        _recParkingOder.SetRange("No.", Rec."No.");
        _repParkingOrder.SetTableView(_recParkingOder);
        _repParkingOrder.Run();
    end;

    procedure AssistEdit(OldOrder: Record "Parking Document") Result: Boolean
    begin
        ParkingOrder := Rec;
        ParkingSetup.Get();
        ParkingSetup.TestField("Parking Order Nos.");
        if NoSeries.LookupRelatedNoSeries(ParkingSetup."Parking Order Nos.", OldOrder."No. Series", ParkingOrder."No. Series") then begin
            ParkingOrder."No." := NoSeries.GetNextNo(ParkingOrder."No. Series");
            Rec := ParkingOrder;
            exit(true);
        end;
    end;

    procedure UpdateParkingSpot()
    var
        ParkingSpot: Record "Parking Spot";
    begin
        TestStatusOpen();
        CreateDimFromDefaultDim(Rec.FieldNo("Parking Spot No."));

        if "Parking Spot No." <> '' then begin
            ParkingSpot.Get("Parking Spot No.");
            ParkingSpot.TestField(Blocked, false);

            Validate("Parking Spot Description", ParkingSpot.Description);
        end;
    end;

    procedure UpdateParkingSpotUnit()
    var
        ParkingSpotUnit: Record "Parking Spot Unit";
    begin
        TestStatusOpen();

        if "Parking Spot Unit No." <> '' then begin
            ParkingSpotUnit.Get("Parking Spot No.", "Parking Spot Unit No.");
            ParkingSpotUnit.TestField(Blocked, false);

            Validate("Parking Spot Unit Description", ParkingSpotUnit.Description);
        end;
    end;
}