table 50094 "Item Price Group"
{
    fields
    {
        field(1; "Item Price Grp Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Maximum Discount %"; Decimal)
        {
            DecimalPlaces = 0: 5;
            MaxValue = 99.99;
            MinValue = 0;

            trigger OnValidate()
            begin
                VALIDATE("Profit % On Cost B4 Discount", GetProfitBeforeDiscount);
            end;
        }
        field(4; "Min Profit % After Discount"; Decimal)
        {
            DecimalPlaces = 0: 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                "MarkUp Profit % After Discount":=(ProfitOnCostToMarkup("Min Profit % After Discount"));
                VALIDATE("Profit % On Cost B4 Discount", GetProfitBeforeDiscount);
            end;
        }
        field(5; "MarkUp Profit % After Discount"; Decimal)
        {
            DecimalPlaces = 0: 5;
        }
        field(6; "Profit % On Cost B4 Discount"; Decimal)
        {
            DecimalPlaces = 0: 5;

            trigger OnValidate()
            begin
                "MarkUp Profit % B4 Discount":=(ProfitOnCostToMarkup("Profit % On Cost B4 Discount"));
            end;
        }
        field(7; "MarkUp Profit % B4 Discount"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Editable = false;
        }
        field(8; "Index No"; Integer)
        {
        }
        field(9; "Group Items"; Code[20])
        {
            CalcFormula = Lookup(Item."No." WHERE("Item Price Group"=FIELD("Item Price Grp Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Group Count"; Integer)
        {
            CalcFormula = Count(Item WHERE("Inventory Posting Group"=FILTER('N_PARTS'), "Item Price Group"=FIELD("Item Price Grp Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Item Price Grp Code")
        {
            Clustered = true;
        }
        key(Key2; "MarkUp Profit % After Discount")
        {
        }
        key(Key3; "Maximum Discount %")
        {
        }
        key(Key4; "Maximum Discount %", "MarkUp Profit % After Discount")
        {
        }
        key(Key5; "Index No")
        {
        }
    }
    fieldgroups
    {
    }
    procedure GetProfitBeforeDiscount(): Decimal begin
        EXIT(100 * ("Min Profit % After Discount" + "Maximum Discount %") / (100 - "Maximum Discount %"));
    end;
    procedure ProfitOnCostToMarkup("Input%": Decimal): Decimal begin
        IF "Input%" = -100 THEN EXIT(0)
        ELSE
            EXIT("Input%" * 100 / (100 + "Input%"));
    end;
    procedure ProfitMarkupToOnCost("Input%": Decimal): Decimal begin
        IF "Input%" = 100 THEN EXIT(0)
        ELSE
            EXIT((100 * "Input%") / (100 - "Input%"));
    end;
}
