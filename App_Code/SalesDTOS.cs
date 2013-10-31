using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SalesDTOS
/// </summary>
public class SalesDTOS
{
	public SalesDTOS()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

public class InvoiceDTOTable
{
    protected internal InvoiceDTOTable() { }
    public string InvoiceID;
    public string Name;
    public string DateCreated;
    public string PaymentStatus;
    public string JobStatus;
}

public class InvoiceDTO
{
    protected internal InvoiceDTO() { }
    public string InvoiceID;
    public string Name;
    public string DateCreated;
    public string DateModified;
    public string PaymentStatus;
    public string PaymentMethod;
    public string PaymentDate;
    public string JobStatus;
    public string CustomerName;
    public string QuoteCode;
}

public class QuoteDTOTable
{
    protected internal QuoteDTOTable() { }
    public string QuoteCode;
    public string Price;
    public string Time;
}

public class QuoteDTO
{
    protected internal QuoteDTO() { }
    public string QuoteCode;
    public string TotalPrice;
    public string TotalTime;
    public string QuoteName;
    public string Email;
    public string DateCreated;
    public string HouseItem;
}