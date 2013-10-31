using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.Text.RegularExpressions;

public partial class admin_services_areas : System.Web.UI.Page
{
    SecondaryEntitiesManager sec;
    DynamicElements de;

    protected void Page_Load(object sender, EventArgs e)
    {
        sec = new SecondaryEntitiesManager();
        de = new DynamicElements();
       
        // bind the gridview to whatever data is in the db
        
        sec.getAreasDrop(test);
        
        if (!Page.IsPostBack)
        {
            // call populate table and pass the main object this cs file is working with
            generateRADSTable(new Area());

            // check the method name, if the JSON call asks for update,
            // call the code behind's Update method
            #region Ajax methods
            if (Request.Form["MethodName"] == "UpdateA")// same Method Name 
            {
                UpdateArea();
                return;
            }
            if (Request.Form["MethodName"] == "AddA")
            {
                addArea();
                return;
            }
            if (Request.Form["MethodName"] == "DeleteA")
            {
                deleteArea();
                return;
            }
            #endregion
        }   
        
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

    public void UpdateArea()
    {
        // check if values in the ajax call are filled in,
        // otherwise, set them to null/0/empty
        
        string id = null;
        string from = null;
        string to = null;
        string val = null;

        string successMessage = "";

        // get all the keys from ajax, this case will return false
        // because we're not editing the other properties
        foreach (string key in Request.Form.AllKeys)
        {
            // is this key an areavalue?
            if (key.Contains("AREAVAL"))
            {
                val = Request.Form["AREAVAL"].ToString();
            }
                // is this key a name?
            else if (key.Contains("FROM"))
            {
                from = Request.Form["FROMMIN"].ToString();
            }
            // is this key a name?
            else if (key.Contains("TOMAX"))
            {
                to = Request.Form["TOMAX"].ToString();
            }
                // is this key a ID?
            else if (key.Contains("ID"))
            {
                id = Request.Form["ID"].ToString();
            }
            else
                ;
        }

        Single num;
        Area d = null;

        if (from != "" && to != "" && val != "")
        {
            // check for correct format
            //if (name.Contains("-"))
            if (Regex.IsMatch(from, @"^[0-9]+$"))
            {
                // check if the area given is numbers, disregard the -
               // string tmp = name.Replace("-", string.Empty);
                int num2;

                // make sure the data is valid
                if (Single.TryParse(val, out num) && Int32.TryParse(from, out num2) && Int32.TryParse(to, out num2))
                {
                    d = sec.updateArea(Convert.ToInt32(id), from, to, Convert.ToSingle(val));

                    if (d != null)
                    {
                        successMessage = "Successfully Updated Item #: " + id + ". Updating server...";
                        Response.Write(successMessage);
                    }
                }
                else
                {
                    successMessage = "You entered invalid data.  Changes won't be saved in the server.";
                    Response.StatusCode = 404;
                    Response.Write(successMessage);
                }
            }
            else
            {
                successMessage = "You entered invalid data.  Changes won't be saved in the server.";
                Response.StatusCode = 404;
                Response.Write(successMessage);
            }
        }
        else
        {
            successMessage = "One or more fields are empty.  Changes won't be saved in the server.";
            Response.StatusCode = 404;
            Response.Write(successMessage);
        }

        
        Response.Flush();
        Response.End();
    }

    public void addArea()
    {
        string from = null;
        string to = null;
        string val = null;

        // get all the keys from ajax, this case will return false
        // because we're not editing the other properties
        foreach (string key in Request.Form.AllKeys)
        {
            // is this key an areavalue?
            if (key.Contains("AREAVAL"))
            {
                val = Request.Form["AREAVAL"].ToString();
            }
            // is this key a name?
            else if (key.Contains("TOMAX"))
            {
                to = Request.Form["TOMAX"].ToString();
            }
            else if (key.Contains("FROMMIN"))
            {
                from = Request.Form["FROMMIN"].ToString();
            }
            else
                ;
        }

        string successMessage = "";
        Single num;
        Area a = null;

        // check if id exists, if name is not empty,
        // if name is not null, if areaval is not empty,
        // and if areaval is actually a number(single)
        if (from != "~noval~" && to != "~noval~" && val != "~noval~")
        {
            int num2;

            // make sure the data is valid
            if (Single.TryParse(val, out num) && Int32.TryParse(from, out num2) && Int32.TryParse(to, out num2))
            {
                a = sec.addNewArea(from, to, Convert.ToSingle(val));

                if (a != null)
                    successMessage = "Added the new area " + from + "-" + to + ". Updating server..";
                else
                {
                    successMessage = "Failed to add new area. There's either invalid or empty data.";
                    Response.StatusCode = 404;
                    Response.Write(successMessage);
                }

                fromTxt.Text = "";
                toTxt.Text = "";
                multi.Text = "";
                Response.Write(successMessage);
            }
            else
            {
                successMessage = "You entered invalid data.";
                Response.StatusCode = 404;
                Response.Write(successMessage);
            }

        }
        else
        {
            successMessage = "You entered incomplete data. Check all required fields.";
            Response.StatusCode = 404;
            Response.Write(successMessage);
        }

        // this will be the way to return values to the ajax call
        Response.Flush();
        Response.End();
        
    }

    public void deleteArea()
    {
        int id = 0;
        id = Convert.ToInt32(Request.Form["ID"].ToString());

        bool success = false;
        
        success = sec.deleteArea(id);

        if (success == true)
        {
            Response.Write("Removing item #: " + id + " from Areas..");
            Response.Flush();
        }
        else
        {
            Response.StatusCode = 404;
            Response.StatusDescription = "Error in deleting item.";
        }
        Response.End();
    }

    public void generateRADSTable(Object o)
    {
        List<Area> areas = sec.getAreas();
        //List<Invoice> inv = sec.getInvoices();
        //List<CleaningType> cl = sec.getCleaningTypes();
        string tableCreate = "No records in the database..";

        // you must send also the NAVIGATION PROPERTIES so that i won't have to display them IF i don't want to
        List<string> types = new List<string>();
        //types.Add(new Customer().GetType());
        //types.Add(new Quote().GetType());
        types.Add("Property");
        //types.Add(new HouseItem().GetType());

        if (areas != null)
            tableCreate = de.populateTable(types, areas);
            //tableCreate = de.populateTable(o, types, cl);
            
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script>makeTable(\"" + tableCreate + "\");</script>", false);
    }
    /*
    public void generateRADSForm(Object o, string what)
    {
        string tableCreate = de.generateForm(o, what);
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp2", "<script>makeForm(\"" + tableCreate + "\");</script>", false);
    }*/
}