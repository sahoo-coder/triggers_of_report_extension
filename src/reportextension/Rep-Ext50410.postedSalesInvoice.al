reportextension 50135 postedSalesInvoice extends "Standard Sales - Invoice"
{
    RDLCLayout = './postedSalesInvoice.rdl';
    dataset
    {
        // Add changes to dataitems and columns here
        add(Header)
        {
            column(Payment_Terms; "Payment Terms Code")
            {
                Caption = 'Payment terms Code';
            }
        }

        modify(Header)
        {
            trigger OnBeforePreDataItem()
            var
                myInt: Integer;
            begin
                Message('On Before Pre DataItem');
            end;

            trigger OnAfterPreDataItem()
            var
                myInt: Integer;
            begin
                Message('On After Pre DataItem');
            end;

            trigger OnAfterAfterGetRecord()
            var
                myInt: Integer;
            begin
                Message('On After After Get Record');
            end;

            trigger OnBeforeAfterGetRecord()
            var
                myInt: Integer;
            begin
                Message('On Before After Get Record');
            end;


            trigger OnAfterPostDataItem()
            var
                myInt: Integer;
            begin
                Message('On After Post Data Item');
            end;

            trigger OnBeforePostDataItem()
            var
                myInt: Integer;
            begin
                Message('On Before Post DataItem');
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Message('On  Pre Report');
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('On Post Report');
    end;
}