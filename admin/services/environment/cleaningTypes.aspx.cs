using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_services_cleaningTypes : System.Web.UI.Page
{
    SecondaryEntitiesManager sec;
    DynamicElements de;

    protected void Page_Load(object sender, EventArgs e)
    {
        sec = new SecondaryEntitiesManager();
        de = new DynamicElements();

        if (!Page.IsPostBack)
        {
            // call populate table and pass the main object this cs file is working with
            generateRADSTable(new CleaningType());

            // check the method name, if the JSON call asks for update,
            // call the code behind's Update method
            #region Ajax methods
            if (Request.Form["MethodName"] == "UpdateC")// same Method Name 
            {
                UpdateCtype();
                return;
            }
            if (Request.Form["MethodName"] == "AddC")
            {
                addCType();
                return;
            }
            if (Request.Form["MethodName"] == "DeleteC")
            {
                deleteCtype();
                return;
            }
            #endregion
        }   
    }

    public void generateRADSTable(Object o)
    {
        List<CleaningType> cl = sec.getCleaningTypes();
        string tableCreate = "No records in the database..";

        // you must send also the NAVIGATION PROPERTIES so that i won't have to display them IF i don't want to
        List<string> types = new List<string>();
        types.Add("HouseItem");

        if (cl != null)
            tableCreate = de.populateTable(types, cl);
            
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script>makeTable(\"" + tableCreate + "\");</script>", false);
    }

    public void addCType()
    {
        string title = null;
        string desc = null;
        string val = null;

        // get all the keys from ajax, this case will return false
        // because we're not editing the other properties
        foreach (string key in Request.Form.AllKeys)
        {
            // is this key an areavalue?
            if (key.Contains("CTYPEVALUE"))
            {
                val = Request.Form["CTYPEVALUE"].ToString();
            }
            // is this key a name?
            else if (key.Contains("NAME"))
            {
                title = Request.Form["NAME"].ToString();
            }
            else if (key.Contains("DESCRIPTION"))
            {
                desc = Request.Form["DESCRIPTION"].ToString();
            }
            else
                ;
        }

        string successMessage = "";
        Single num;
        CleaningType a = null;

        // check if id exists, if name is not empty,
        // if name is not null, if areaval is not empty,
        // and if areaval is actually a number(single)
        if (title != "~noval~" && desc != "~noval~" && val != "~noval~")
        {

            // make sure the data is valid
            if (Single.TryParse(val, out num))
            {
                a = sec.addNewCType(title, desc, Convert.ToSingle(val));

                if (a != null)
                    successMessage = "Added the new Cleaning Type " + title + ". Updating server..";
                else
                {
                    successMessage = "Failed to add new area. There's either invalid or empty data.";
                    Response.StatusCode = 404;
                    Response.Write(successMessage);
                }

                titleTxt.Text = "";
                descTxt.Text = "";
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

    public void UpdateCtype()
    {
        // check if values in the ajax call are filled in,
        // otherwise, set them to null/0/empty

        string id = null;
        string title = null;
        string desc = null;
        string val = null;

        string successMessage = "";

        // get all the keys from ajax, this case will return false
        // because we're not editing the other properties
        foreach (string key in Request.Form.AllKeys)
        {
            // is this key an areavalue?
            if (key.Contains("CTYPEVALUE"))
            {
                val = Request.Form["CTYPEVALUE"].ToString();
            }
            // is this key a name?
            else if (key.Contains("NAME"))
            {
                title = Request.Form["NAME"].ToString();
            }
            // is this key a name?
            else if (key.Contains("DESCRIPTION"))
            {
                desc = Request.Form["DESCRIPTION"].ToString();
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
        CleaningType d = null;

        if (title != "" && desc != "" && val != "")
        {
            // check for correct format
            //if (name.Contains("-"))
            //if (Regex.IsMatch(from, @"^[0-9]+$"))
            //{
                // check if the area given is numbers, disregard the -
                // string tmp = name.Replace("-", string.Empty);
                int num2;

                // make sure the data is valid
                if (Single.TryParse(val, out num))
                {
                    d = sec.updateCType(Convert.ToInt32(id), title, desc, Convert.ToSingle(val));

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
            //}
            //else
            //{
            //    successMessage = "You entered invalid data.  Changes won't be saved in the server.";
            //    Response.StatusCode = 404;
            //    Response.Write(successMessage);
            //}
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

    public void deleteCtype()
    {
        int id = 0;
        id = Convert.ToInt32(Request.Form["ID"].ToString());

        bool success = false;
        
        success = sec.deleteCleaningType(id);

        if (success == true)
        {
            Response.Write("Removing item #: " + id + " from Cleaning Types..");
            Response.Flush();
        }
        else
        {
            Response.StatusCode = 404;
            Response.StatusDescription = "Error in deleting item.";
        }
        Response.End();
    }
}