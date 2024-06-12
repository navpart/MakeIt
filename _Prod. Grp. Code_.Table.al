table 50301 "Prod. Grp. Code"
{
    fields
    {
        field(1; "code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
