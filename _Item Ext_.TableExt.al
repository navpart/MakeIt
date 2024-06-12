tableextension 50008 "Item Ext" extends Item
{
    fields
    {
        field(50001; "Stock Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("Item Ledger Entry"."Posting Date" WHERE("Item No." = FIELD("No."), "Remaining Quantity" = FILTER(> 0)));
        }
        field(50002; "Item Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Item WHERE("Inventory Posting Group" = FIELD("Inventory Posting Grp Filter"), Inventory = FIELD("Inv Quantity Filter")));
            Editable = false;
        }
        field(50003; "Inv Quantity Filter"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(50004; "Inventory (All Locations)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50005; Maintenance; Option)
        {
            OptionCaption = ',Body Repair,Electrical,Electrical&Mechanical,Mechanical,Others,Routine';
            OptionMembers = ,"Body Repair",Electrical,"Electrical&Mechanical",Mechanical,Others,Routine;
        }
        field(50006; "Category Type"; Text[3])
        {
        }
        field(50008; Fuel; Option)
        {
            OptionMembers = " ",Petrol,Diesel;
        }
        field(50009; "Fixed Cost"; Decimal)
        {
            Caption = 'Landing Cost (FIXED)';
        }
        field(50010; "FOB (FIXED)"; Decimal)
        {
        }
        field(50040; "Stock Value Posted to G/L"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Posted to G/L" WHERE("Item No." = FIELD("No."), "Location Code" = FIELD("Location Filter"), "Posting Date" = FIELD("Date Filter"), "Variant Code" = FIELD("Variant Filter"), "Expected Cost" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50041; "Phase out"; Boolean)
        {
        }
        field(50042; "Perfomance Status"; Option)
        {
            Description = 'sh';
            OptionCaption = 'Phase-In,Phase-Out,Slow Moving,Obsolete';
            OptionMembers = "Phase-In","Phase-Out","Slow Moving",Obsolete;
        }
        field(50043; "Last Status Change Date"; Date)
        {
            Description = 'sh';
        }
        field(50044; "Reorder Period"; Integer)
        {
            Description = 'sh';
        }
        field(50045; "Maximum Period"; Integer)
        {
            Description = 'sh';
        }
        field(50088; "Article Group"; Code[20])
        {
            trigger OnValidate()
            begin
                TESTFIELD("Article Group");
            end;
        }
        field(50151; "Special Attn"; Option)
        {
            OptionMembers = " ",H;
        }
        field(50152; "Created On"; Date)
        {
        }
        field(50153; "Phase-In Transaction"; Integer)
        {
            Description = 'sh';
        }
        field(50154; "Phase-Out Transaction"; Integer)
        {
            Description = 'sh';
        }
        field(50155; "Phase-In  Period"; DateFormula)
        {
            Description = 'sh';
        }
        field(50156; "Phase-Out  Period"; DateFormula)
        {
            Description = 'sh';
        }
        field(50157; "Slow Moving Period"; DateFormula)
        {
            Description = 'sh';
        }
        field(50158; "Period Unit"; Option)
        {
            Description = 'sh';
            InitValue = Months;
            OptionCaption = 'Days,Weeks,Months,Years';
            OptionMembers = Days,Weeks,Months,Years;
        }
        field(50159; "Lead Time Period"; Integer)
        {
            Description = 'sh';
        }
        field(50160; "Use Item Setup"; Boolean)
        {
            Description = 'sh';
        }
        field(50161; "Transaction Count"; Integer)
        {
            CalcFormula = Count("Item Ledger Entry" WHERE("Item No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Location Code" = FIELD("Location Filter"), "Entry Type" = CONST(Sale)));
            Description = 'sh';
            FieldClass = FlowField;
        }
        field(50162; "Order Cycle"; Integer)
        {
        }
        field(50163; "Safety Stock of Lead Time"; Integer)
        {
        }
        field(50164; "Obsolete Period"; DateFormula)
        {
        }
        field(50165; "Non Specification"; Boolean)
        {
        }
        field(50190; "Model No."; Code[50])
        {
            TableRelation = Model;

            trigger OnValidate()
            begin
                // GetModel("Model No.");
                Model.SETRANGE(Model."Model No.", "Model No.");
                IF Model.FINDFIRST THEN "Model Name" := Model."Model Name";
            end;
        }
        field(50200; "Model Name"; Text[50])
        {
        }
        field(50201; "ABC-Classification"; Option)
        {
            OptionMembers = " ",A1,A2,A3,A4,B1,B2,B3,B4,E1,E2,WW,NN,OB;
        }
        field(50202; "SIIC-Code"; Code[5])
        {
        }
        field(50203; "Customs-Tarif"; Code[5])
        {
        }
        field(50204; "Currency Code"; Code[4])
        {
            TableRelation = Currency;
        }
        field(50205; "Block Price Group Update"; Boolean)
        {
            Description = 'to prevent item from automatic price update';
        }
        field(50206; Costpercent; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50207; "Foreign cur. price"; Decimal)
        {
            trigger OnValidate()
            begin
                VALIDATE("Unit Cost");
                VALIDATE("Unit Price");
                /*
                    IF CONFIRM('Do you want to change salesprice',TRUE) THEN
                    VALIDATE("Unit Price",Salesfactor*"Foreign cur. price");

                    IF CONFIRM('Do you want to change costprice',TRUE) THEN
                    BEGIN
                    {
                      Currec.GET("Currency Code");
                      Exchraterec.SETRANGE("Currency Code",Currec.Code);
                      IF Exchraterec.FIND('+') THEN;

                      "Unit Cost":=(("Foreign cur. price"*Exchraterec."Exchange Rate Amount")/100)*CostFactor;
                    }
                      VALIDATE("Unit Cost",CostFactor*"Foreign cur. price");
                    END;
                    */
                /*
                     IF LogRec.FIND('+') THEN
                     LogRec."Consecutive No.":=LogRec."Consecutive No."+1000 ELSE LogRec."Consecutive No.":=1000;
                     LogRec."User ID":=USERID;
                     LogRec.Date:=TODAY;
                     LogRec.Time:=TIME;
                     LogRec.ID:="No.";
                     LogRec."Acc. Diagr. Cons. No":=0;
                     LogRec."Create/change/delete":=1;
                     LogRec.FieldName:='Foreign Currency Price';
                     LogRec."Old Value":=FORMAT(xRec."Foreign cur. price");
                     LogRec."New Value":=FORMAT("Foreign cur. price");
                     LogRec."Delete: Text":='';
                     LogRec."Delete: Summing up":='';
                     LogRec.Tabletype:=5;
                     LogRec.INSERT;
                    */
            end;
        }
        field(50208; "Sales Price Pink"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50209; "Costprice Pink"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50210; "LRUC Price"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50211; "Estcost."; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50212; "Recost."; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50213; "Is Product Ok"; Boolean)
        {
            InitValue = true;
        }
        field(50214; "Salesprice WANG"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50215; "Salesfactor (FCY)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50216; CurrencyRate; Decimal)
        {
            DecimalPlaces = 4 : 4;
        }
        field(50217; "Imported on"; Date)
        {
        }
        field(50218; "Serialno Y/N"; Boolean)
        {
        }
        field(50219; "Stockvalue."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Cost Posted to G/L" WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Expected Cost" = CONST(false), "Posting Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50220; Department; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50221; "Modified By"; Code[10])
        {
            Editable = false;
        }
        field(50222; CostFactor; Decimal)
        {
            DecimalPlaces = 3 : 3;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF CONFIRM('Do you want to change costprice', TRUE) THEN BEGIN
                    /*
                      Currec.GET("Currency Code");
                      Exchraterec.SETRANGE("Currency Code",Currec.Code);
                      IF Exchraterec.FIND('+') THEN;

                      "Unit Cost":=(("Foreign cur. price"*Exchraterec."Exchange Rate Amount")/100)*CostFactor;
                    */
                    VALIDATE("Unit Cost", "Foreign cur. price" * CostFactor);
                END;
            end;
        }
        field(50223; "CostFactor Air"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            MinValue = 0;
        }
        field(50224; "Cost Value Naira"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50225; "Old Salesprice"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50226; "Old Salesfactor"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50230; ICC; Code[10])
        {
            Editable = false;
            TableRelation = "Parts By Model"."Model Code";
        }
        field(50231; SCC; Code[10])
        {
            Editable = false;
            TableRelation = "Online Dealer Order";
        }
        field(50232; "Loss Sales"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Qty. to Ship" WHERE("Document Type" = CONST("Blanket Order"), Type = CONST(Item), "No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Shipment Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            TableRelation = "Sales Line";
        }
        field(50233; MAD; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50234; "Back/On Order"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50235; StockValInv; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50236; CostValue4Sales; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50237; "Stock/Value differ"; Boolean)
        {
        }
        field(50238; "Inventory Posting Grp Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Inventory Posting Group";
        }
        field(50239; "MVO Count"; Decimal)
        {
            /*  FieldClass = FlowField;
                 CalcFormula = Sum("Monthly Vehicle Order Lines".Quantity WHERE("Period Starting" = FIELD("Date Filter"),
                                                                                 "PO Number" = FIELD("PO Filter)",
                                                                                 "Model No." = FIELD("No."),
                                                                                 Customer = FIELD("Customer Filter)",
                                                                                 "Model Group Code" = FIELD("Model Group Filter"),
                                                                                 "Model Category" = FIELD("Model Category Filter"),
                                                                                 Colour = FIELD("Colour Filter"),
                                                                                 "Customer Gen Bus Posting Group" = FIELD("Customer Gen Post Grp Filter"),
                                                                                 Purchaser = FIELD("MVO Purchaser Filter"),
                                                                                 "Location Code" = FIELD("Location Filter")));
                 DecimalPlaces = 0 : 0;
                 Editable = false; */
        }
        field(50240; "MVO Purchaser Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",TNL,DLF_A,DLF_B,OTHERS;
        }
        field(50241; "MVO Model Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        field(50242; "Customer Gen Post Grp Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Gen. Business Posting Group";
        }
        field(50243; "Customer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(50244; "Model Group Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50245; "Model Category Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }

        field(50247; "Colour Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50248; Obsolete; Boolean)
        {
        }
        field(50249; "Actual Qty Demanded"; Decimal)
        {
            /* CalcFormula = Sum("Sales Invoice Line"."Qty. Demanded" WHERE(Type = CONST(Item),
                                                                              "No."=FIELD("No.")));
                FieldClass = FlowField; */
        }
        field(50250; "Own Spec"; Boolean)
        {
        }
        field(50251; "Last Date Sold"; Date)
        {
        }
        field(50252; "Part Category"; Option)
        {
            OptionCaption = ' ,ENGINE/FUEL SYSTEM,POWER DRIVE/CHASIS,BODY PARTS,ELECTRICAL PARTS';
            OptionMembers = " ","ENGINE/FUEL SYSTEM","POWER DRIVE/CHASIS","BODY PARTS","ELECTRICAL PARTS";
        }
        field(50253; "Qty Demanded"; Decimal)
        {
            /* FieldClass = FlowField;
                CalcFormula = Sum("Parts Enquiry"."Quantity Demanded" WHERE ("Part No"=FIELD("No."),
                                                                             "Request Date"=FIELD("Date Filter"),
                                                                             "Location Code"=FIELD("Location Filter"),
                                                                             Variant=FIELD("Variant Filter")));
                DecimalPlaces = 0:0; */
        }
        field(50254; "Lost Sales Qty"; Decimal)
        {
            /*  CalcFormula = Sum("Parts Enquiry"."Lost Quantity" WHERE (Part No=FIELD(No.),
                                                                          Request Date=FIELD(Date Filter),
                                                                          Location Code=FIELD(Location Filter),
                                                                          Variant=FIELD(Variant Filter)));
                 DecimalPlaces = 0:0;
                 FieldClass = FlowField; */
        }
        field(50255; "Freq Request"; Integer)
        {
            /* CalcFormula = Count("Parts Enquiry" WHERE (Request Date=FIELD(Date Filter),
                                                           Part No=FIELD(No.)));
                FieldClass = FlowField; */
        }
        field(50256; "Qty Supplied"; Decimal)
        {
            /* CalcFormula = Sum("Parts Enquiry"."Quantity Supplied" WHERE (Part No=FIELD(No.),
                                                                             Request Date=FIELD(Date Filter),
                                                                             Location Code=FIELD(Location Filter),
                                                                             Variant=FIELD(Variant Filter)));
                DecimalPlaces = 0:0;
                FieldClass = FlowField; */
        }
        field(50257; "Qty. On Request"; Decimal)
        {
        }
        field(50258; "Issue Qty"; Decimal)
        {
            /*  CalcFormula = -Sum("Item Ledger Entry".Quantity WHERE (Entry Type=CONST(" "),
                                                                        Item No.=FIELD(No.),
                                                                        Location Code=FIELD(Location Filter),
                                                                        Variant Code=FIELD(Variant Filter),
                                                                        Posting Date=FIELD(Date Filter),
                                                                        "Global Dimension 1 Code"=FIELD(Global Dimension 1 Filter),
                                                                        Global Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
                 FieldClass = FlowField; */
        }
        field(50259; "Return Qty"; Decimal)
        {
            /* CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Entry Type=CONST(Assembly Consumption),
                                                                      Item No.=FIELD(No.),
                                                                      Location Code=FIELD(Location Filter),
                                                                      Variant Code=FIELD(Variant Filter),
                                                                      Posting Date=FIELD(Date Filter),
                                                                      "Global Dimension 1 Code"=FIELD(Global Dimension 1 Filter),
                                                                      Global Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
                FieldClass = FlowField; */
        }
        field(50300; "Item Color"; Code[30])
        {
        }
        field(50301; Degree; Code[10])
        {
        }
        field(50302; "Year of Production"; Code[10])
        {
        }
        field(50303; "Estimated Mileage"; Code[10])
        {
        }
        field(50304; "Pre-Owned Colour"; Code[10])
        {
        }
        field(60219; "Stockvalue.QQQ"; Decimal)
        {
            Editable = false;
        }
        field(60220; "Bin Count"; Decimal)
        {
            Editable = false;
        }
        field(60225; "Exchange Rate"; Decimal)
        {
            FieldClass = Normal;
        }
        field(60226; "Abuja Inventory"; Decimal)
        {
            /* CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(No.),
                                                                      "Global Dimension 1 Code"=FIELD(Global Dimension 1 Filter),
                                                                      Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                      Location Code=FIELD(Location Filter),
                                                                      Location Code=FILTER(112ABJ),
                                                                      Drop Shipment=FIELD(Drop Shipment Filter),
                                                                      Variant Code=FIELD(Variant Filter),
                                                                      Lot No.=FIELD(Lot No. Filter),
                                                                      Serial No.=FIELD(Serial No. Filter)));
                DecimalPlaces = 0:0;
                FieldClass = FlowField; */
        }
        field(60227; "Portharcourt Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Location Code" = FILTER('100PH'), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Lot No." = FIELD("Lot No. Filter"), "Serial No." = FIELD("Serial No. Filter")));
            DecimalPlaces = 0 : 0;
        }
        field(60228; "Isolo Inventory"; Decimal)
        {
            /* CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(No.),
                                                                      "Global Dimension 1 Code"=FIELD(Global Dimension 1 Filter),
                                                                      Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                      Location Code=FIELD(Location Filter),
                                                                      Location Code=FILTER(ISO150),
                                                                      Drop Shipment=FIELD(Drop Shipment Filter),
                                                                      Variant Code=FIELD(Variant Filter),
                                                                      Lot No.=FIELD(Lot No. Filter),
                                                                      Serial No.=FIELD(Serial No. Filter)));
                DecimalPlaces = 0:0;
                FieldClass = FlowField; */
        }
        field(60229; "Dojo Inventory"; Decimal)
        {
            /* CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(No.),
                                                                      "Global Dimension 1 Code"=FIELD(Global Dimension 1 Filter),
                                                                      Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                      Location Code=FIELD(Location Filter),
                                                                      Location Code=FILTER(ISO150),
                                                                      Drop Shipment=FIELD(Drop Shipment Filter),
                                                                      Variant Code=FIELD(Variant Filter),
                                                                      Lot No.=FIELD(Lot No. Filter),
                                                                      Serial No.=FIELD(Serial No. Filter)));
                DecimalPlaces = 0:0;
                FieldClass = FlowField; */
        }
        field(60230; "Dojo Oregun  Inventory"; Decimal)
        {
            /* CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(No.),
                                                                      "Global Dimension 1 Code"=FIELD(Global Dimension 1 Filter),
                                                                      Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                      Location Code=FIELD(Location Filter),
                                                                      Location Code=FILTER(ISO150),
                                                                      Drop Shipment=FIELD(Drop Shipment Filter),
                                                                      Variant Code=FIELD(Variant Filter),
                                                                      Lot No.=FIELD(Lot No. Filter),
                                                                      Serial No.=FIELD(Serial No. Filter)));
                DecimalPlaces = 0:0;
                FieldClass = FlowField; */
        }
        field(60231; "Item No Category"; Code[10])
        {
            Caption = 'Product Grp Code';
            DataClassification = ToBeClassified;
            TableRelation = "Prod. Grp. Code".code;
        }
        field(60232; "Sub Item"; Code[20])
        {
            CalcFormula = Lookup("Item Substitution"."Substitute No." WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60233; "Sub Name"; Text[100])
        {
            CalcFormula = Lookup("Item Substitution".Description WHERE("Substitute No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60234; "Part Division"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "TNL Profit %"; Decimal)
        {
            Caption = 'Unit Price Factor %';
            Description = 'SUSPENDED';

            trigger OnValidate()
            begin
                //UpdateSellingPrice(0);
                //VALIDATE("Unit Price",GetSellPriceAfterDiscount);
                //ProfitTNLtoStandard;
                //VALIDATE("Profit %",ProfitTNLtoStandard);
                VALIDATE("Last Direct Cost");
            end;
        }
        field(70001; "TNL Discount B/4 Profit"; Decimal)
        {
            Description = 'SUSPENDED';
            InitValue = 30;
            MinValue = 0;

            trigger OnValidate()
            begin
                //UpdateSellingPrice(3);
            end;
        }
        field(70002; "Item Price Group"; Code[10])
        {
            /* Description = 'ok';
                TableRelation = IF (Inventory Posting Group=CONST(N_PARTS)) "Item Price Group"."Item Price Grp Code";

                trigger OnValidate()
                begin
                    IF PriceGrp.GET("Item Price Group") THEN
                      VALIDATE("Profit %",PriceGrp."MarkUp Profit % B4 Discount");

                    "TNL Profit %" := PriceGrp."Profit % On Cost B4 Discount";
                end; */
        }
        field(70003; "Naira Sales Factor"; Decimal)
        {
            Description = 'SUSPENDED';
            Enabled = false;

            trigger OnValidate()
            begin
                //VALIDATE("Unit Price","Last Direct Cost" * "Naira Sales Factor");
                //"Unit Price" := "Last Direct Cost" * "Naira Sales Factor";
            end;
        }
        field(70004; "Created By"; Code[20])
        {
            Editable = false;
        }
        field(70005; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(70006; StockQty; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70007; StockQty2; Decimal)
        {
            /*  CalcFormula = Sum("Value Entry"."Valued Quantity" WHERE (Item No.=FIELD(No.),
                                                                          Expected Cost=CONST(No),
                                                                          Location Code=FIELD(Location Filter),
                                                                          Posting Date=FIELD(Date Filter)));
                 DecimalPlaces = 0:5;
                 Editable = false;
                 FieldClass = FlowField; */
        }
        field(70008; StockValue2; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70009; StockQtyLdgEntry; Decimal)
        {
            /*  CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(No.),
                                                                       Posting Date=FIELD(Date Filter),
                                                                       Location Code=FIELD(Location Filter),
                                                                       Variant Code=FIELD(Variant Filter)));
                 DecimalPlaces = 0:5;
                 Editable = false;
                 FieldClass = FlowField; */
        }
        field(70011; StockValueLdgEntry; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(70012; "Last Purchase Date"; Date)
        {
            /*  CalcFormula = Max("Item Ledger Entry"."Posting Date" WHERE (Item No.=FIELD(No.),
                                                                             Entry Type=CONST(Purchase)));
                 Editable = false;
                 FieldClass = FlowField; */
        }
        field(70013; "Last Sales Date"; Date)
        {
            /*  CalcFormula = Max("Item Ledger Entry"."Posting Date" WHERE (Item No.=FIELD(No.),
                                                                             Entry Type=CONST(Sale)));
                 Editable = false;
                 FieldClass = FlowField; */
        }
        field(70014; "Sales Entries"; Integer)
        {
            /* CalcFormula = Count("Item Ledger Entry" WHERE (Item No.=FIELD(No.),
                                                               Entry Type=CONST(Sale),
                                                               Posting Date=FIELD(Date Filter),
                                                               Variant Code=FIELD(Variant Filter),
                                                               Location Code=FIELD(Location Filter)));
                Editable = false;
                FieldClass = FlowField; */
        }
        field(70015; "Transfer Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                //VALIDATE("Unit Price");
                //"Transfer Cost" := "Unit Price" * 0.67;
            end;
        }
        field(70016; "Retail Price"; Decimal)
        {
            trigger OnValidate()
            begin
                VALIDATE("Unit Price");
                "Retail Price" := "Unit Price" * 0.67;
            end;
        }
        field(70017; "BNP Grouping"; Code[20])
        {
        }
        field(70100; "Item No. Filter"; Code[250])
        {
        }
        field(70101; "Product Group Filter"; Code[250])
        {
        }
        field(70102; "Sales Qty"; Decimal)
        {
        }
        field(70103; "Sales Amount"; Decimal)
        {
        }
        field(70104; "Unit Cost2"; Decimal)
        {
        }
        field(70105; "Product Code"; Code[10])
        {
        }
        field(70106; "Old DB Date"; Date)
        {
        }
        field(70107; Promo; Boolean)
        {
        }
        field(70108; "Part Group"; Code[10])
        {
        }
        field(70109; "Factor (Air)"; Decimal)
        {
        }
        field(70110; "Isolo Shelf No."; Code[20])
        {
            Caption = 'Shelf No.';
        }
        field(70111; "Available Quantity"; Decimal)
        {
        }
        field(70112; Contribution; Decimal)
        {
            trigger OnValidate()
            begin
                VALIDATE("Unit Price");
                Contribution := "Unit Price" * 0.33;
            end;
        }
        field(70113; "Percentage Available"; Decimal)
        {
            trigger OnValidate()
            begin
                CALCFIELDS(Inventory);
                "Available Quantity" := ROUND(Inventory * ("Percentage Available" / 100), 1, '=');
            end;
        }
        field(70114; "Isolo Profit %"; Decimal)
        {
            trigger OnValidate()
            begin
                VALIDATE("Unit Price");
                "Isolo Profit %" := (("Unit Price" * 0.33) / "Unit Price") * 100;
            end;
        }
        field(70115; "Item Type"; Option)
        {
            BlankZero = false;
            OptionCaption = ' ,Stock,Non-Stock';
            OptionMembers = " ",Stock,"Non-Stock";
        }
        field(70116; "Item Source"; Option)
        {
            OptionCaption = ' ,LPN,LPU';
            OptionMembers = " ",LPN,LPU;
        }
        field(70117; "TNL Selling Price to TCSC"; Decimal)
        {
        }
        field(70118; "Local Buys"; Boolean)
        {
        }
        field(70119; "Prod. Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    fieldgroups
    {
        addlast(DropDown;
        Inventory)
        {
        }
    }
    var
        UserSetup: Record 91;
        UserSetup2: Record 91;
        InvPGrp: Code[10];
        PriceGrp: Record 50094;
        Model: Record 50014;
        Locrec: Record 14;
        LocFilter: Code[20];
        LocAlloc: Decimal;
        LocAllocVal: Decimal;
        LocExceQty: Decimal;
        LocExceVAl: Decimal;
        ItemRec: Record 27;
        ItemLedgerEntRec: Record 32;
        SalesSetup: Record 311;
        ValueEntryRec: Record 5802;
        PurchInvLineRec: Record 123;
        PurchInvHdrRec: Record 122;
        FixedExchRate: Decimal;
        FixedPrice: Record 50126;
        FixedPrice2: Record 50128;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
    end;
}
