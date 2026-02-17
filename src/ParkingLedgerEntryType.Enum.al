enum 50101 "Parking Ledger Entry Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Check In") { Caption = 'Check In'; }
    value(1; "Extend Parking") { Caption = 'Extend Parking'; }
    value(2; "Check Out") { Caption = 'Check Out'; }
    value(3; "Violation") { Caption = 'Violation'; }
    value(4; "Parking Fee Invoice") { Caption = 'Parking Fee Invoice'; }
    value(5; "Penalty Fee Invoice") { Caption = 'Penalty Fee Invoice'; }
}