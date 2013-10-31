using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Hosting;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web.Script.Serialization;

[ScriptService]
public partial class admin_sales_sales : System.Web.UI.Page
{
    static RTQManager rtq;
    static SalesManager sales;
    static ServicesManager serv;
    static DynamicElements de;

    protected void Page_Load(object sender, EventArgs e)
    {
        rtq = new RTQManager();
        sales = new SalesManager();
        serv = new ServicesManager();
        de = new DynamicElements();
    }
    
    [WebMethod()]
    [ScriptMethod(UseHttpGet = true)]
    public static IEnumerable<InvoiceDTOTable> getInvoices()
    {
        return sales.getInvoices();
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true)]
    public static IEnumerable<QuoteDTOTable> getQuotes()
    {
        return sales.getQuotes();
    }

    [WebMethod()]
    public static QuoteDTO getQuoteInfo(string id)
    {
        QuoteDTO i = sales.getQuoteById(id);
        return i;
    }


    [WebMethod()]
    public static InvoiceDTO getInvoiceInfo(string id)
    {
        InvoiceDTO i = sales.getInvoiceById(id);

        /*JsonSerializerSettings jsSettings = new JsonSerializerSettings();
        jsSettings.ReferenceLoopHandling = ReferenceLoopHandling.Serialize;

        string json = JsonConvert.SerializeObject(sales.getInvoiceById(id), Formatting.None, jsSettings);
        */
        return i;
    }

}