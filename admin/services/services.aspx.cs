using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_services_services : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // redirect to cleaning types
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("environment/cleaningTypes.aspx");
    }

    // redirect to house types
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("environment/houseTypes.aspx");
    }

    // redirect to areas
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("environment/areas.aspx");
    }

    // redirect to presetItems
    protected void Button7_Click(object sender, EventArgs e)
    {
        Response.Redirect("environment/presetItems.aspx");
    }

    // redirect to rtq options
    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("rtqconfig/rtqOptions.aspx");
    }

    // redirect to appliances
    protected void Button5_Click(object sender, EventArgs e)
    {
        Response.Redirect("rtqconfig/rtqApps.aspx");
    }

    // redirect to rooms
    protected void Button6_Click(object sender, EventArgs e)
    {
        Response.Redirect("rtqconfig/rooms.aspx");
    }

}