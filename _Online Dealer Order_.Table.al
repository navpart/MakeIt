table 50024 "Online Dealer Order"
{
    fields
    {
        field(1; "Refrence No."; Code[20])
        {
        }
        field(2; "Dealer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Dealer Name"; Text[50])
        {
        }
        field(4; "Part No."; Code[20])
        {
            TableRelation = Item."No.";
            ValidateTableRelation = false;
        }
        field(5; "Part Description"; Text[50])
        {
        }
        field(6; "Required Q'ty"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(7; "Q'ty Supply"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(8; "Supply Category"; Option)
        {
            OptionCaption = 'A,B,C,D,E';
            OptionMembers = A,B,C,D,E;
        }
        field(9; Branch; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; Remarks; Text[50])
        {
        }
        field(11; "Order No."; Code[20])
        {
        }
        field(12; Process; Boolean)
        {
        }
        field(13; "Tracker No."; Code[20])
        {
        }
        field(14; "Request Date"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "Refrence No.", "Part No.")
        {
            Clustered = true;
        }
    }
}