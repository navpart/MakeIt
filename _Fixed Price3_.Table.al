table 50128 "Fixed Price3"
{
    fields
    {
        field(1; "Item No"; Code[20])
        {
        }
        field(2; "Unit Cost"; Decimal)
        {
            DecimalPlaces = 0: 6;
        }
    }
    keys
    {
        key(Key1; "Item No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
