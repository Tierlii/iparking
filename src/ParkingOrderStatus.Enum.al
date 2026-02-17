enum 50100 "Parking Order Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open) { Caption = 'Broneeritud'; }
    value(1; Released) { Caption = 'Hoivatud'; }
    value(2; Closed) { Caption = 'Closed'; }
}