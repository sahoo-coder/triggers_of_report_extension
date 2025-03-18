report 50605 salesOrderReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './salesOrderReport_KSS.rdl';
    Caption = 'Sales Order Report(2)_KSS';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            column(Item_No_; "No.") { }
            column(Description; Description) { }
            column(Ordered_Quantity; Quantity) { }
            column(Unit_Price_Excl_Tax; "Unit Price") { }
            column(shippedQuantity; shippedQuantity) { }
            column(shippedAmount; shippedAmount) { }
            column(invoicedQuantity; invoicedQuantity) { }
            column(invoicedAmount; invoicedAmount) { }
            column(amountIncludingTax; amountIncludingTax) { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if orderNumber <> '' then begin
                    "Sales Line".SetRange("Document No.", orderNumber);
                end
                else
                    Error('Please Give Document Number');
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                salesShipmentline.SetRange("Order No.", "Sales Line"."Document No.");
                salesShipmentline.SetRange("No.", "Sales Line"."No.");
                if salesShipmentline.FindFirst() then begin
                    shippedQuantity := salesShipmentline.Quantity;
                    shippedAmount := salesShipmentline."VAT Base Amount";
                end
                else
                    Message('Data found to be Zero in Shipmment Line');

                salesinvoiceLine.SetRange("Order No.", "Sales Line"."Document No.");
                salesinvoiceLine.SetRange("No.", "Sales Line"."No.");
                if salesinvoiceLine.FindFirst() then begin
                    invoicedQuantity := salesinvoiceLine.Quantity;
                    invoicedAmount := salesinvoiceLine.Amount;
                    amountIncludingTax := salesinvoiceLine."Amount Including VAT";
                end
                else
                    Message('Data found to be Zero in invoice line');
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group("Sales Order_KIRTI")
                {
                    field(orderNumber; orderNumber)
                    {
                        Caption = 'Sales Order Number(Document No.)';
                        ApplicationArea = All;
                        TableRelation = "Sales Line"."Document No." where("Document Type" = const(Order));
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    var
        orderNumber: Code[60];
        salesLine: Record "Sales Line";
        shippedQuantity: Integer;
        shippedAmount: Decimal;
        invoicedQuantity: Integer;
        invoicedAmount: Decimal;
        salesShipmentline: Record "Sales Shipment Line";
        salesinvoiceLine: Record "Sales Invoice Line";
        amountIncludingTax: Decimal;
}