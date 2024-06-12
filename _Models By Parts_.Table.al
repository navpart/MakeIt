table 50032 "Models By Parts"
{
    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; "Model No."; Code[20])
        {
        }
        field(3; "Model Description"; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
