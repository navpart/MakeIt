table 50014 Model
{
    DataCaptionFields = "Model No.", "Model Name";

    /* DrillDownPageID = 50037;
    LookupPageID = 50037 */
    ;
    fields
    {
        field(1; "Model No."; Code[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
            // ItemRec."Model Name":="Model Name";
            end;
        }
        field(2; "Model Name"; Text[50])
        {
        }
        field(3; "Prod Date"; Text[30])
        {
        }
        field(4; "Units in Operation"; Decimal)
        {
            DecimalPlaces = 0: 0;
            Editable = false;
        }
        field(5; "Date Filter"; Date)
        {
            trigger OnValidate()
            begin
            //datefilter := GETFILTER("Date Filter");
            /*  PartsBymodel.SETRANGE(PartsBymodel."Model Code", "Model No.");
                IF PartsBymodel.FIND('-') THEN
                    PartsBymodel.SETFILTER(PartsBymodel."Base Date", '%1', "Date Filter"); */
            end;
        }
        field(6; "Part Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'BODY PARTS,BRAKE/SUSPENSION,CLUTCH SYSTEM,ELECTRICAL,ENGINE PARTS,FUEL SYSTEM,SILENCER/AIR CLEANER,WATER PUMP,WATER PUMP & RADIATOR';
            OptionMembers = "BODY PARTS", "BRAKE/SUSPENSION", "CLUTCH SYSTEM", ELECTRICAL, "ENGINE PARTS", "FUEL SYSTEM", "SILENCER/AIR CLEANER", "WATER PUMP", "WATER PUMP & RADIATOR";
        }
        field(7; "Line Items"; Integer)
        {
            CalcFormula = Count("Parts By Model" WHERE("Model Code"=FIELD("Model No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Line Items with Stock Q'ty"; Integer)
        {
        /*  CalcFormula = Count("Parts By Model" WHERE ("Model Code"=FIELD("Model No."),
                                                        "Q'ty On Hand"=FILTER(>0)));
            Editable = false;
            FieldClass = FlowField; */
        }
        field(9; "Other Specification"; Boolean)
        {
            trigger OnValidate()
            begin
            /* ItemRec.SETRANGE(ItemRec."Model No.","Model No.");
                IF ItemRec.FIND('-') THEN
                 REPEAT
                   IF "Other Specification" THEN
                      ItemRec."Non Specification" := TRUE
                      ELSE
                      ItemRec."Non Specification" := FALSE;
                   ItemRec.MODIFY;
                 UNTIL ItemRec.NEXT = 0; */
            end;
        }
        field(10; "Inventory Line Item"; Integer)
        {
        /* CalcFormula = Count(Item WHERE (Model No.=FIELD(Model No.),
                                            Inventory Posting Group=CONST('N_PARTS')));
            FieldClass = FlowField; */
        }
        field(11; "Operation code"; Code[20])
        {
        }
        field(12; Type; Option)
        {
            OptionCaption = ' ,Item,Resource,Cost,Temp';
            OptionMembers = " ", Item, Resource, Cost, Temp;
        }
        field(13; "No."; Code[20])
        {
        }
        field(14; Description; Text[50])
        {
        }
        field(15; Quantity; Integer)
        {
        }
        field(16; "Model Description"; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Model No.", "Model Name")
        {
            Clustered = true;
        }
        key(Key2; "Model Name")
        {
        }
    }
    fieldgroups
    {
    }
    var ItemRec: Record Item;
    //PartsBymodel: Record "50023";
    datefilter: Text[30];
    Qsales: Decimal;
    procedure unitinoperation(): Decimal begin
        Qsales:=0;
        ItemRec.SETCURRENTKEY("Model No.", "Inventory Posting Group");
        ItemRec.SETRANGE(ItemRec."Model No.", "Model No.");
        ItemRec.SETRANGE(ItemRec."Inventory Posting Group", 'N_CARS');
        IF ItemRec.FIND('-')THEN REPEAT ItemRec.CALCFIELDS(ItemRec."Sales (Qty.)");
                Qsales:=Qsales + ItemRec."Sales (Qty.)";
            UNTIL ItemRec.NEXT = 0;
        "Units in Operation":=Qsales;
        EXIT(Qsales);
    end;
}
