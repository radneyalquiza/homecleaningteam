using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SalesManager
/// </summary>
public class SalesManager
{
    hctDBEntities db = new hctDBEntities();

	public SalesManager()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public List<InvoiceDTOTable> getInvoices()
    {
        using (var context = new hctDBEntities())
        {
            List<Invoice> inv = context.Invoices.OrderBy(i => i.Id).ToList();
            List<InvoiceDTOTable> il = new List<InvoiceDTOTable>();

            foreach (Invoice i in inv)
            {
                InvoiceDTOTable cdt = new InvoiceDTOTable();
                cdt.InvoiceID = i.InvoiceID;
                cdt.DateCreated = i.dateCreated.ToString();
                cdt.Name = i.name;
                cdt.PaymentStatus = i.paymentStatus;
                cdt.JobStatus = i.jobStatus;
                il.Add(cdt);
            }
            return il;
        }
    }

    public List<QuoteDTOTable> getQuotes()
    {
        using (var context = new hctDBEntities())
        {
            List<Quote> q = context.Quotes.OrderBy(i => i.Id).ToList();
            List<QuoteDTOTable> ql = new List<QuoteDTOTable>();

            foreach (Quote i in q)
            {
                QuoteDTOTable cdt = new QuoteDTOTable();
                cdt.QuoteCode = i.quoteCode;
                cdt.Price = i.totalPrice.ToString();
                cdt.Time = i.totalTime.ToString();
                ql.Add(cdt);
            }
            return ql;
        }
    }

    public InvoiceDTO getInvoiceById(string id)
    {
        Invoice i = db.Invoices.Where(p => p.InvoiceID == id).FirstOrDefault();
        
        // use a serialize safe object
        InvoiceDTO ix = new InvoiceDTO();
        ix.InvoiceID = i.InvoiceID;
        ix.DateCreated = i.dateCreated.ToString();
        ix.DateModified = i.dateModified.ToString();
        ix.JobStatus = i.jobStatus;
        ix.PaymentStatus = i.paymentStatus;
        ix.QuoteCode = i.Quote.quoteCode;

        // you'll need to get the person connected to the Customer
        Person pr = db.People.Where(x => x.Customer_Id == i.Customer_Id).FirstOrDefault();
        
        ix.CustomerName = pr.fname + " " + pr.lname;
        
        return ix;
    }

    public QuoteDTO getQuoteById(string id)
    {
        Quote q = db.Quotes.Where(qq=> qq.quoteCode == id).FirstOrDefault();
        
        QuoteDTO q2 = new QuoteDTO();
        q2.QuoteCode = q.quoteCode;
        q2.TotalPrice = q.totalPrice.ToString();
        q2.TotalTime = q.totalTime.ToString();
        q2.QuoteName = q.name;
        q2.Email = q.email;
        return q2;
    }
}