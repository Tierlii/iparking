codeunit 50102 "Parking Jnl.-Post Line"
{
    TableNo = "Parking Journal Line";
    Permissions = tabledata "Res. Ledger Entry" = imd;

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    var
        ParkingJnlLine: Record "Parking Journal Line";
        ParkingSpot: Record "Parking Spot";
        ParkingSpotUnit: Record "Parking Spot Unit";
        ParkingLedgerEntry: Record "Parking Ledger Entry";
        ParkingLedgerEntryHist: Record "Parking Ledger Entry";
        ParkingJnlCheckLine: Codeunit "Parking Jnl.-Check Line";
        EntryAlreadyExistsErr: Label '%1 entry for Parking Order %2 already exists.';

    procedure RunWithCheck(var ParkingJnlLine2: Record "Parking Journal Line")
    begin
        ParkingJnlLine.Copy(ParkingJnlLine2);
        Code();
        ParkingJnlLine2 := ParkingJnlLine;
    end;

    local procedure Code()
    var
        _intDays: Integer;
    begin
        if ParkingJnlLine.EmptyLine() then
            exit;
        ParkingJnlCheckLine.RunCheck(ParkingJnlLine);

        ParkingSpot.Get(ParkingJnlLine."Parking Spot No.");
        ParkingSpotUnit.Get(ParkingJnlLine."Parking Spot No.", ParkingJnlLine."Parking Spot Unit No.");

        ParkingSpot.TestField(Blocked, false);
        ParkingSpotUnit.TestField(Blocked, false);

        Clear(ParkingLedgerEntry);
        ParkingLedgerEntry.Init();

        ParkingLedgerEntry.CopyFromParkingJnlLine(ParkingJnlLine);

        case ParkingJnlLine."Entry Type" of
            ParkingJnlLine."Entry Type"::"Check In":
                begin
                    ParkingLedgerEntryHist.Reset();
                    ParkingLedgerEntryHist.SetCurrentKey("Entry Type", "Parking Order No.");
                    ParkingLedgerEntryHist.SetRange("Entry Type", "Parking Ledger Entry Type"::"Check In");
                    ParkingLedgerEntryHist.SetRange("Parking Order No.", ParkingJnlLine."Parking Order No.");

                    if not ParkingLedgerEntryHist.IsEmpty then
                        Error(EntryAlreadyExistsErr, ParkingJnlLine."Entry Type", ParkingJnlLine."Parking Order No.");

                    ParkingLedgerEntry."Days (Expected)" := ParkingJnlLine."Parking Days";
                end;

            ParkingJnlLine."Entry Type"::"Extend Parking":
                begin
                    ParkingLedgerEntryHist.Reset();
                    ParkingLedgerEntryHist.SetCurrentKey("Entry Type", "Parking Order No.");
                    ParkingLedgerEntryHist.SetRange("Entry Type", "Parking Ledger Entry Type"::"Check In");
                    ParkingLedgerEntryHist.SetRange("Parking Order No.", ParkingJnlLine."Parking Order No.");
                    ParkingLedgerEntryHist.FindFirst();

                    _intDays := ParkingLedgerEntryHist."Days (Expected)";

                    ParkingLedgerEntryHist.Reset();
                    ParkingLedgerEntryHist.SetCurrentKey("Entry Type", "Parking Order No.");
                    ParkingLedgerEntryHist.SetRange("Entry Type", "Parking Ledger Entry Type"::"Extend Parking");
                    ParkingLedgerEntryHist.SetRange("Parking Order No.", ParkingJnlLine."Parking Order No.");
                    if ParkingLedgerEntryHist.FindSet() then
                        repeat
                            _intDays += ParkingLedgerEntryHist."Days (Expected)";
                        until ParkingLedgerEntryHist.Next() = 0;

                    ParkingLedgerEntry."Days (Expected)" := ParkingJnlLine."Parking Days" - _intDays;
                end;

            ParkingJnlLine."Entry Type"::"Check Out":
                begin
                    ParkingLedgerEntryHist.Reset();
                    ParkingLedgerEntryHist.SetCurrentKey("Entry Type", "Parking Order No.");
                    ParkingLedgerEntryHist.SetRange("Entry Type", "Parking Ledger Entry Type"::"Check Out");
                    ParkingLedgerEntryHist.SetRange("Parking Order No.", ParkingJnlLine."Parking Order No.");
                    if not ParkingLedgerEntryHist.IsEmpty then
                        Error(EntryAlreadyExistsErr, ParkingJnlLine."Entry Type", ParkingJnlLine."Parking Order No.");
                    ParkingLedgerEntry."Days (Actual)" := ParkingJnlLine."Parking Days";
                end;

            ParkingJnlLine."Entry Type"::Violation:;

            ParkingJnlLine."Entry Type"::"Parking Fee Invoice":;

            ParkingJnlLine."Entry Type"::"Penalty Fee Invoice":;
        end;

        ParkingLedgerEntry.Insert(true);
    end;
}