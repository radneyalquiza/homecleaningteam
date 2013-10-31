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
public partial class selfserve_register : System.Web.UI.Page
{
    static CustomerManager cs;
    static RTQManager rtq;
    public static Person person;
    public static Address address;
    public static Customer customer;
    public static Property prop;
    public static Quote q;
    public static Invoice invoice;

    protected void Page_Load(object sender, EventArgs e)
    {
        cs = new CustomerManager();
        rtq = new RTQManager();
        person = null;
        address = null;
        customer = null;
        invoice = null;
        q = null;

    }

    // create customer then person and address

    // create a single person
    [WebMethod()]
    public static string createPerson(string fname, string lname, string email1, string email2,
                                    string home, string mobile, string work)
    {
        if (fname != null && fname != "" &&
            lname != null && lname != "" &&
            email1 != null && email1 != "" &&
            home != null && home != "")
        {
            person = cs.createPerson(fname, lname, email1, email2, home, mobile, work, customer.Id);
            if (person != null)
                return "true";
            else
                return "false";
        }
        return "false";
    }

    // create a single address
    [WebMethod()]
    public static int createAddress(string bldg, string unit, string street, string city,
                                        string postalcode)
    {
        // unit can be null
        if (bldg != null && bldg != "" &&
            street != null && street != "" &&
            postalcode != null && postalcode != "")
        {
            address = cs.createAddress(bldg, unit, street, city, postalcode);
            if (address != null)
                return address.Id;
            else
                return 0;
        }
        else return 0;
    }

    // create a single customer
    [WebMethod()]
    public static string createCustomer()
    {
        customer = cs.createCustomer();
        if (customer != null)
            return "true";
        else
            return "false";
    }

    // create a single property
    [WebMethod()]
    public static string createProperty(string name, int address, int area, int housetype)
    {
        if (name == null || name == "")
            name = "Default";
        prop = cs.createProperty(name, address, area, customer.Id, housetype);
        if (prop != null)
            return "true";
        else
            return "false";
    }


    // create a quote invoice 
    [WebMethod()]
    public static string createInvoice(string quote)
    {
        if ( quote != "" && quote != null)
            q = rtq.getQuote(quote);

        if (q != null)
        {
            // if this email and the saved email are the same
            if ( q.email == customer.People.First().email1 )
                invoice = rtq.createInvoice(q.Id, customer.Id, quote);
        }
        if (invoice != null)
            return "true";
        else
            return "false";
    }

}