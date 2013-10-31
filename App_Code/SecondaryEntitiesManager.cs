using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// THIS MANAGER CLASS WILL HANDLE ALL PROCESSES
/// TO BE DONE TO:
/// CLEANING TYPES - like routine cleaning, etc
/// HOUSE TYPE - like Detached, etc
/// AREA - like 100-299 sq. ft., etc
/// </summary>


public class SecondaryEntitiesManager
{
    // declare the database context
    hctDBEntities db = new hctDBEntities();
	

    // all functions go here
    
    ////////////////////////////////////////////////////////////////////////
    // AREAS
    ////////////////////////////////////////////////////////////////////////


    // get a list of areas
    public List<Area> getAreas()
    {
        // get all area items
        return db.Areas.OrderBy(i => i.Id).ToList();

    }
    
    // bind the list of areas into a dropdownlist for selection
    public void getAreasDrop(DropDownList d)
    {
        var dr = db.Areas.Select(n => new { Range = n.fromMin + " " + n.toMax, AreaVal = n.areaVal }).ToList();

        if (dr.Count > 0)
        {
            d.DataSource = dr;
            d.DataTextField = "Range";
            d.DataValueField = "AreaVal";
            d.DataBind();
            //return true;
        }
        else
        {
            d.DataSource = null;
            d.DataBind();
            //return false;
        }
    }
    
    public Area get1Area(int id)
    {
        return db.Areas.Where(i => i.Id == id).FirstOrDefault();
    }
    
    public Area addNewArea(string from, string to, Single mult)
    {
        Area tmp = new Area();

        // check if all data is correct
        if ( from != null && from != "" &&
            to != null && to!= "" &&
            mult > 0 && Convert.ToInt32(to) > Convert.ToInt32(from))
        {
            tmp.fromMin = from;
            tmp.toMax = to;
            tmp.areaVal = mult;
            db.Areas.AddObject(tmp);
        }
        else
            tmp = null;

        
        db.SaveChanges();

        return tmp;
    }

    public Area updateArea(int id, string from = null, string to = null, Single areaVal = 0)
    {
        Area d;

        if ( id > 0 )
            d = db.Areas.Where(o => o.Id == id).FirstOrDefault();
        else
            return null;

        // updating can be partial, you don't have to have new
        // data for every property. Set the properties to whatever
        // new data you receive
        
        // id's are important though, so always check

        if (from != "" && from != null && to != "" && to != null)
        {
            d.fromMin = from;
            d.toMax = to;
        }

        // so to validate, IF some
        if (areaVal > 0)
            d.areaVal = areaVal;
        

        db.SaveChanges();
        return d;
    }

    public bool deleteArea(int id)
    {
        Area a = null;

        if ( id > 0 )
            a = db.Areas.Where(o=>o.Id == id).FirstOrDefault();

        if (a != null)
        {
            db.Areas.DeleteObject(a);
            db.SaveChanges();
            return true;
        }
        else
        {
            return false;
        }

    }

    ////////////////////////////////////////////////////////////////////////
    // CLEANING TYPES
    ////////////////////////////////////////////////////////////////////////

    public List<CleaningType> getCleaningTypes()
    {
        return db.CleaningTypes.OrderBy(i => i.Id).ToList();
    }

    public bool deleteCleaningType(int id)
    {
        CleaningType a = null;

        if (id > 0)
            a = db.CleaningTypes.Where(o => o.Id == id).FirstOrDefault();

        if (a != null)
        {
            db.CleaningTypes.DeleteObject(a);
            db.SaveChanges();
            return true;
        }
        else
        {
            return false;
        }
    }

    public CleaningType addNewCType(string title, string desc, Single val)
    {
        CleaningType c = new CleaningType();

        if (title != "" && title != null && desc != "" && desc != null && val > 0)
        {
            c.name = title;
            c.cTypeValue = val;
            c.description = desc;
            db.CleaningTypes.AddObject(c);
            db.SaveChanges();
            return c;
        }
        else
            return c;

    }

    public CleaningType updateCType(int id, string title=null, string desc=null, Single val=0)
    {
        CleaningType d;

        if (id > 0)
            d = db.CleaningTypes.Where(o => o.Id == id).FirstOrDefault();
        else
            return null;

        // updating can be partial, you don't have to have new
        // data for every property. Set the properties to whatever
        // new data you receive

        // id's are important though, so always check

        if (title != "" && title != null)
            d.name = title;

        if (desc != "" && desc != null)
            d.description = desc;

        // so to validate, IF some
        if (val > 0)
            d.cTypeValue = val;


        db.SaveChanges();
        
        return d;
    }


    ////////////////////////////////////////////////////////////////////////
    // HOUSE TYPES
    ////////////////////////////////////////////////////////////////////////


    ////////////////////////////////////////////////////////////////////////
    // PROMOTIONS
    ////////////////////////////////////////////////////////////////////////
}