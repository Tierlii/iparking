table 50102 "PS Class"
{
    Caption = 'PS Class';
    LookupPageId = "PS Classes";

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
        field(3; "Default PS Location Code"; Text[50])
        {
            Caption = 'Default PS Location Code';
            TableRelation = "PS Location".Code;

            trigger OnValidate()
            var
                _PSLocation: Record "PS Location";
            begin
                if "Default PS Location Code" = '' then begin
                    Clear("Default PS Location Id");
                    exit;
                end;
                _PSLocation.Get("Default PS Location Code");
                "Default PS Location Id" := _PSLocation.SystemId;
            end;
        }
        field(4; "Default PS Location Id"; Guid)
        {
            Caption = 'Default PS Location Id';
            TableRelation = "PS Location".SystemId;
            trigger OnValidate()
            var
                _PSLocation: Record "PS Location";
            begin
                if IsNullGuid("Default PS Location Id") then begin
                    "Default PS Location Code" := '';
                    exit;
                end;
                _PSLocation.GetBySystemId("Default PS Location Id");
                "Default PS Location Code" := _PSLocation.Code;
            end;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}