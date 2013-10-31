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

[ScriptService]
public partial class selfserve_jobBooking : System.Web.UI.Page
{
    static RTQManager rtq;
    static ServicesManager serv;
    static CustomerManager cs;

    protected void Page_Load(object sender, EventArgs e)
    {
        rtq = new RTQManager();
        serv = new ServicesManager();
        cs = new CustomerManager();
    }

    [WebMethod()]
    public static string getQuotes()
    {
        //System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
        return JsonConvert.SerializeObject(rtq.getHouses(), Formatting.Indented, new JsonSerializerSettings
        {
            ReferenceLoopHandling = ReferenceLoopHandling.Serialize
        });
    }
}