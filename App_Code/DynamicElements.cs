using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Metadata.Edm;
using System.Data.Objects.DataClasses;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;
using System.Web;
using System.Web.UI;
using System.Data.Entity.Infrastructure;
using System.Collections;
using System.Data.Entity.Design.PluralizationServices;   


public class DynamicElements
{
    // generates custom elements like WHOLE tables,
    // WHOLE divs, etc.

    SecondaryEntitiesManager sec = new SecondaryEntitiesManager();
    RTQManager rtq = new RTQManager();
    ServicesManager serv = new ServicesManager();
    CustomerManager customer = new CustomerManager();
    SalesManager sales = new SalesManager();
    hctDBEntities db = new hctDBEntities();


    public string populateTable<T>(List<string> navtype, List<T> list)
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////
        // this is only for showing the headers
        ///////////////////////////////////////////////////////////////////////////////////////////////

        // to modularize this method, you can pass an object (init or not)
        // and use GetType() just to get the type, then GetProperties() to
        // get it's properties. this will work on any object in this application


        // get the properties for this specific area object
        PropertyInfo[] props = null;
        string[] propnames = null;

        if (list.Count() > 0)
        {
            //MemberInfo[] props = list[0].GetType().GetProperties();
            props = list[0].GetType().GetProperties();

            // initialize a string array according to the number of properties in the area object
            propnames = new string[props.Count()];

            // column counter
            int countCols = 0;

            // loop through each property, and treat it as a column
            // using propnames
            
            string[] pr = new string[props.Count()];

            PluralizationService plural = PluralizationService.CreateService(CultureInfo.GetCultureInfo("en-us"));

            string ht = null;
            string at = null;
            
            for ( int i = 0; i < props.Count(); i++ )
            {
                    // for some reason, the first column will be RELATIONSHIPMANAGER
                    // the second column is obviously a ID

                if (props[i] != null)
                {
                    if (props[i].Name.ToString() != "RelationshipManager")
                    {
                        // first, check if the navigation properties are in this object
                        if (navtype.Count() > 0)
                        {
                            // if there are navigation properties, check and compare the PROPERTY NAMES
                            foreach (string q in navtype)
                            {
                                // since TYPES are also names, just pluralize some of them in order to get ICollections

                                ht = plural.Pluralize(props[i].Name.ToString());
                                at = plural.Pluralize(q.ToString());

                                if (plural.Pluralize(q) != plural.Pluralize(props[i].Name.ToString()) && q != props[i].Name.ToString())
                                {
                                    object v = props[i].Name;
                                    propnames[countCols] = props[i].Name.ToString();
                                    countCols++;
                                }
                            }
                        }
                        else
                        {
                            // if there are no nav props, do the normal stuff
                            object v = props[i].Name;
                            propnames[countCols] = props[i].Name.ToString();
                            countCols++;
                        }
                    }
                }
            }

            string tableCreate = "<table class='displayGrid'><tr class='headerRow'>";

            // show the column names
            tableCreate += "<td>Control</td>";

            // start from 1 because the first column is the ID, which you dont need to show
            for (int t = 1; t < propnames.Count(); t++)
            {
                if (propnames[t] != null)
                    tableCreate += "<td>" + propnames[t].ToUpper() + "</td>";
            }
            tableCreate += "</tr>";

            // row identifier
            int row = 0;

            // this loop will only consider 1 column
            foreach (T g in list)
            {
                string[] propvals = new string[propnames.Count()];

                // loop through all properties in this area object
                // there's ID, NAME, AREAVALUE
                // and set them to local variables (that will be replaced once the next area object is focused)
                int count = 0;

                for (int i = 0; i < propnames.Count(); i++)
                {
                        if (props[i].Name.ToString() != "RelationshipManager")
                        {
                            // first, check if the navigation properties are in this object
                            if (navtype.Count() > 0)
                            {
                                // if there are navigation properties, check and compare the PROPERTY NAMES
                                foreach (string q in navtype)
                                {
                                    // since TYPES are also names, just pluralize some of them in order to get ICollections

                                    ht = plural.Pluralize(props[i].Name.ToString());
                                    at = plural.Pluralize(q.ToString());

                                    if (plural.Pluralize(q) != plural.Pluralize(props[i].Name.ToString()) && q != props[i].Name.ToString())
                                    {
                                        object val = props[i].GetValue(g, null);
                                        if (val != null)
                                            propvals[count] = val.ToString();
                                        count++;
                                    }
                                }
                            }
                            else
                            {
                                object val = props[i].GetValue(g, null);
                                if (val != null)
                                    propvals[count] = val.ToString();
                                count++;
                            }
                        }
                }

                // set the id for the current row
                // it is usually the first column propvals[0]
                row = Convert.ToInt32(propvals[0].ToString());

                // this section will contain the original text (data)
                tableCreate += @"<tr id='" + row + "'>";
                // this will contain the actual object's ID column
                tableCreate += @"<td class='deleteBtnTD'><input class='delBtn" + row + @"' id='" + row + @"' type='button' value='Delete' /></td>";

                for (int column = 1; column < propnames.Count(); column++)
                {
                    if (propnames[column] != null)
                    {
                        // "column" is the counter for columns
                        // propvals[column] contains the value of the field in the row

                        tableCreate += @"<td><div class='containerOrig" + column + @"' id='data" + row + @"' >";
                        tableCreate += @"<span class='replaceable" + column + @"' id='label" + row + @"' >" + propvals[column] + @"</span>";
                        tableCreate += @"</div>";

                        // this section will contain the textbox
                        tableCreate += @"<div class='containerEdit" + column + @"' id='edit" + row + @"' >";
                        tableCreate += @"<input class='textbox" + column + @"' id='box" + row + @"' type='text' />";
                        tableCreate += @"<input class='ok" + column + @"' id='" + row + @"' type='button' value='UPDATE' />";
                        tableCreate += @"<input class='canc" + column + @"' id='" + row + @"' type='button' value='CANCEL' />";
                        tableCreate += @"</div>";
                    }
                }

                tableCreate += @"</td></tr>";
                // go to the next Area row
                row += 1;
            }
            tableCreate += "</table";

            return tableCreate;
        }
        else
            return "<h3>Sorry, I haven't found any records in this table. Why not add some?</h3>";

    }

    public string createRooms(List<Room> rooms, List<RTQApp> apps, List<RTQOption> options, List<RTQOptionSub> subs, int num, string whichRoom, string nextroom)
    {
        string divCreate = "<div class='pageTransContainer roomouter'>";

        int counter = 0;

        int popupflag = 0; ;


        // loop through rooms and get whatever room is passed

        for (counter = 0; counter < num; counter++ )
        {
            foreach (Room r in rooms)
            {
                if (r.name == whichRoom)
                {
                    divCreate += "<div class='pageTransItem";
                    // if this is a multi-clone room, add a clone classname                    
                    if ( num > 1 )
                        divCreate += " clone" + counter;
                    
                    divCreate += "' >";
                    divCreate += "<h2>" + whichRoom;
                    
                    if ( num > 1 )
                        divCreate += " # " + (counter + 1);
                    
                    divCreate += " Options</h2>";
                    divCreate += "<div id='room" + r.name.Replace(" ", "") +"' class='roomMain " + r.name.Replace(" ", "") + "'>";
                    divCreate += "<div class='grid-whole equalize " + r.name + "' >"; // room contents
                        
                        foreach (RTQApp a in apps)
                        {
                            if (a.Room_Id == r.Id)
                            {
                                divCreate += "<div class='grid-third s-grid-whole padded' id='boxin" + a.Id + "'>";
                                divCreate += "<div class='content-box box'>";
                                divCreate += "<div class='appHead'>" + a.name + "</div>";
                                divCreate += "<ul>";

                                foreach (RTQOption o in options)
                                {
                                    if (o.RTQApp_Id == a.Id)
                                    {
                                        divCreate += "<li>";
                                        divCreate += "<input id='";
                                        // check if the option has no time, which means it has conflicts,
                                        // thus calling the sub options if it is clicked
                                        if (o.time == null || o.time < 0)
                                            divCreate += "conflict";

                                        divCreate += "rtqoption" + o.Id + "' type='checkbox' class='lineCheck";

                                        // if the time is equal to zero, these are special checkboxes
                                        // that will bring up a textbox where they can enter a value
                                        if (o.time == 0)
                                            divCreate += " variablevalue";


                                        if (a.name == "Ceilings & Walls" || a.name == "Floors" || a.name == "Windows & Blinds")
                                                divCreate += " popupcheck";


                                        // insert another class for this checkbox, for the tooltips
                                        if (o.time == null || o.time < 0)
                                        {
                                            divCreate += " lineConflict";
                                            divCreate += "' value='" + o.name + "'";
                                            // if conflicted, store the name into the value so that
                                            // you can access it if the user cancels
                                        }
                                        else
                                            divCreate += "' value='" + o.Id + "'";

                                        // insert the data attribute, which can be the actual name of the RTQ Option
                                        // because the label is actually a separate element so we cannot access from
                                        // javascript without stepping across the DOM tree
                                        divCreate += " data-optionname='" + o.name + "'";
                                        divCreate += " data-appname='" + a.name + "'";

                                        divCreate += " />";
                                        divCreate += "<label>" + o.name + "</label>";

                                        // if this option is conflicted, add the sub options inside a hidden div
                                        if (o.time == null || o.time < 0)
                                        {
                                            int c = 0;
                                            divCreate += "<div id='inner" + o.Id + "' style='text-align:left'>"; // inner div
                                            foreach (RTQOptionSub s in subs)
                                            {
                                                // if this sub option belongs to this option, add stuff
                                                if (s.RTQOption_Id == o.Id)
                                                {
                                                    divCreate += "<div><input type='radio' class='lineRadioCheck ";

                                                    divCreate += " color" + c + "' name='sub" + o.Id + "' value='" + s.Id + "'";
                                                    divCreate += " data-optionname='" + s.name + "'";
                                                    divCreate += " data-appname='" + a.name + "'";
                                                    if (o.time == 0)
                                                        divCreate += " data-noteenabled='true' ";
                                                    divCreate += " />";
                                                    divCreate += "<label>" + s.name + "</label>";

                                                    divCreate += "</div>";
                                                }
                                                c++;
                                            }
                                            divCreate += "<div><input type='radio' class='lineRadioCheck cancelRadioCheck' data-optionname='No thanks.' name='sub" + o.Id + "' value='' />";
                                            divCreate += "<label>No thanks.</label></div>";
                                            divCreate += "</div>"; // end inner 

                                        }
                                        if (o.time == 0)
                                        {
                                            divCreate += "<div id='valuebox" + o.Id + "'>"; // inner div
                                            divCreate += "Please enter the number of Items:<br/><select id='valueinput" + o.Id + "'><option value=''>Select...</option></select><br/><input type='button' id='doneValuebox' value='Done' />";
                                            divCreate += "</div>";
                                        }


                                        // for extra buttons to apply
                                        //if (popupflag < 9)
                                        //{
                                            if (a.name == "Ceilings & Walls" || a.name == "Floors" || a.name == "Windows & Blinds")
                                            {
                                                divCreate += "<div class='popupapplybtn notapplied'></div>";
                                                divCreate += "<div class='popupunapplybtn'></div>";
                                            }
                                        //}


                                        divCreate += "</li>"; // end rtq option
                                    }
                                }   // end list option
                                divCreate += "</ul></div></div>";
                            }
                        } // end appliance
                        divCreate += "</div></div>";
                        if ( counter == (num - 1))  // this is the last clone of a room
                            if ( nextroom != "Bedroom" )
                                if ( whichRoom != "Office" )
                                    divCreate += "<br/><input type='button' onclick='goNextRoom(\"" + nextroom + "\");' class='mainBtn nextroom' value='Next Room' /><br/>";
                                else
                                    divCreate += "<br/><input type='button' onclick='finishQuote();' class='mainBtn nextroom' value='Complete Quote!' /><br/>";
                            else
                                divCreate += "<br/><input type='button' onclick='finishBath(\"" + nextroom + "\");' class='mainBtn nextroom' value='Next Room' /><br/>";
                        
                        // if this is the first instance of the room, ask the user if they would like to apply to the rest of the rooms
                        if ( counter < 1 )
                            if ( num > 1 )  // if there are more than 1 rooms in this room type
                                divCreate += "<input type='button' class='mainBtnApply' onclick='cloneServicePattern(\"" + whichRoom + "\");' value='Apply this service pattern &#13;&#10;to all " + r.name + "s' /><br/>";

                        divCreate += "<br/><br/></div>";  // end inner div (pagetransitem)
                    }
                }
            
        } // end rooms loop
        
        
        divCreate += "</div>";  // end main div (pagetranscontainer)

        return divCreate;
    }

    public string callRoom(int room)
    {
        Room roomob = null;
        string divCreate = "";
        if (room > 0)
        {
            roomob = serv.getRoom(room);
            divCreate += "<div class='roomCont'><div class='roomtitle'><span class='titletxt'>" + roomob.name + "</span>";
            divCreate += "<span class='arrowdown'></span><span class='xbtn'></span><div class='gifarrow tooltipcontainer'>";
            divCreate += "<div class='tooltipside'><p>Please click the button below to enable options for " + roomob.name +
                ". If no " + roomob.name + "s need cleaning, click on 'Next Room'!</p></div>"; 
            divCreate += "</div></div><div class='appslist'>";
        }

        List<RTQApp> apps = serv.getApps(roomob.Id);

        if (apps != null)
        {
            foreach (RTQApp a in apps)  // loop through the apps in this room
            {
                List<RTQOption> options = serv.getOptions(a.Id);
                if (options != null)
                {
                    divCreate += "<ul class='appl'>";
                    divCreate += "<li data-header='" + a.name + "'>";
                    foreach (RTQOption o in options)    // loop through the options in this app
                    {
                        divCreate += "<li data-optionid='" + o.Id + "' ";
                        divCreate += "data-appname='" + a.name + "' ";
                        divCreate += "data-timeunit='" + o.time + "' ";
                        divCreate += "data-optionname='" + o.name + "' ";
                        divCreate += "class='" + o.ctype + "'><span>" + o.name + "</span>";
                        if (o.time == null)
                        {
                            List<RTQOptionSub> subs = serv.getOptionSubs(o.Id);
                            if (subs != null)
                            {
                                divCreate += "<ul class='isRadioList'>";
                                foreach (RTQOptionSub s in subs)
                                {
                                    divCreate += "<li data-suboptionid='" + s.Id + "' ";
                                    divCreate += "data-appname='" + a.name + "' ";
                                    divCreate += "data-timeunit='" + s.time + "' ";
                                    divCreate += "data-optionname='" + s.name + "' ";
                                    divCreate += "class='" + s.ctype + "'><span>" + s.name + "</span></li>";
                                }
                                divCreate += "<li><span>No thanks.</span></li>";
                                divCreate += "</ul>";
                            }
                        }
                        divCreate += "</li>";
                    }
                    divCreate += "</ul>"; // closing for ul
                }
            }
        }

        divCreate += "<div class='typeselector'><span>Floor type:</span><select class='inline'>";
        divCreate += "<option value=''>Select...</option>";
        divCreate += "<option value='HRDWD'>Hardwood</option>";
        divCreate += "<option value='MRBL'>Marble</option>";
        divCreate += "<option value='CRMC'>Ceramic</option>";
        divCreate += "<option value='LAMT'>Laminate</option>";
        divCreate += "</select></div>";

        if (room == 1 || room == 2)
            divCreate += "<div class='addroom'>Add Room</div>";
        divCreate += "</div"; // closing for applist
        divCreate += "</div>"; // closing for roomCont

        return divCreate;
    }


    public string createRooms(List<Room> rooms, List<RTQApp> apps, List<RTQOption> options, List<RTQOptionSub> subs)
    {
        string divCreate = "<div class='rtqcont1'><span id='roomtitle'></span>";

        foreach (Room r in rooms)
        {
            divCreate += "<div id='room" + r.name + "'>";
            divCreate += "<div class='grid-whole equalize " + r.name + "' >"; // room contents
            
            foreach (RTQApp a in apps)
            {
                if (a.Room_Id == r.Id)
                {
                    divCreate += "<div class='grid-third s-grid-whole padded' id='boxin" + a.Id + "'>";
                    divCreate += "<div class='content-box box'>";
                    divCreate += "<div class='appHead'>" + a.name + "</div>";
                    divCreate += "<ul>";
                    foreach (RTQOption o in options)
                    {
                        // if this option belongs to this appliance, add stuff
                        if (o.RTQApp_Id == a.Id)
                        {
                            divCreate += "<li>";
                            divCreate += "<input id='";
                            // check if the option has no time, which means it has conflicts,
                            // thus calling the sub options if it is clicked
                            if (o.time == null || o.time < 1)
                                divCreate += "conflict";

                            divCreate += "rtqoption" + o.Id + "' type='checkbox' class='lineCheck";

                            // insert another class for this checkbox, for the tooltips
                            if (o.time == null || o.time < 1)
                                divCreate += " lineConflict";

                            divCreate += "' value=" + o.Id + " />";


                            divCreate += "<label>" + o.name + "</label>";

                            // if this option is conflicted, add the sub options inside a hidden div
                            if (o.time == null || o.time < 0)
                            {
                                divCreate += "<div id='inner" + o.Id + "' style='text-align:left'>"; // inner div
                                foreach (RTQOptionSub s in subs)
                                {
                                    // if this sub option belongs to this option, add stuff
                                    if (s.RTQOption_Id == o.Id)
                                    {
                                        divCreate += "<input type='radio' class='lineRadio' name='sub" + o.Id + "' value='" + s.Id + "' />";
                                        divCreate += "<label>" + s.name + "</label>";
                                    }
                                }
                                divCreate += "</div>"; // end inner 

                            }

                            divCreate += "</li>"; // end rtq option
                        }
                    }

                    divCreate += "</ul>";
                    divCreate += "<input type='button' class='slideoutbtn" + a.Id + "' title='dsd' value='Done'>";
                    divCreate += "</div>"; // end rtq box
                    divCreate += "</div>";
                }
                
            }
            //if (r.name.ToLower() == "bathroom" || r.name.ToLower() == "bedroom")
            //    divCreate += "<input type='button' class='doneBtn' value='Apply to Others' />";

            divCreate += "</div>";
            divCreate +="</div>";
        
        }

        

        divCreate += "<br/><input type='button' class='mainBtn' id='nextroom' value='Next Room' />";
       
        divCreate += "</div><br/>";
        return divCreate;

    }

      // will a quote code, which can be used to retreive all info about it
      public string createInvoiceImage(List<RoomDataDTO> rooms)
      {
          string divInvoice = "<div class='invoiceSummary'>";
          divInvoice += "<div style='text-align:center'><img style='width:450px' src='../Styles/img/logofin3.png' alt='Logo' /><br/>";
          divInvoice += " <a>service@homecleaningteam.com</a>";
          divInvoice += " <h3>(647)-704-6153</h3>";

          divInvoice += "<h3 style='font-size:2.5em'>Service Detail</h3></div>";

          divInvoice += "<div class='serviceDetailCont'><div id='serviceDetailDiv' class='grid-whole equalize'>";
          
          foreach (RoomDataDTO r in rooms)
          {
              if (r.Apps.Length > 0)
              {
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + r.RoomName + "</th><tbody>";

                  // i have to use anonymous receiver variable because App is an inner class within the DTO
                  foreach (var a in r.Apps)
                  {
                      divInvoice += "<tr><td class='appname'>" + a.AppName + "</td></tr>";
                      foreach (var o in a.Options)
                      {
                          divInvoice += "<tr><td>" + o.OptionName + "</td></tr>";
                      }
                  }

                  divInvoice += "</tbody></table><br/>";
              }
          }
          
          
          divInvoice += "</div></div>";

          divInvoice += "</div>"; // closing div for outermost
          return divInvoice;

          /*Quote q = rtq.getQuote(code);
          //HouseItem h = rtq.getHouse(q.HouseItem_Id);
          //List<RoomItem> r = rtq.getRoomsForHouse(h.Id);

          string divInvoice = "<div class='invoiceSummary'>";
          divInvoice += "<div style='text-align:center'><img style='width:450px' src='../Styles/img/logofin3.png' alt='Logo' /><br/>";
          divInvoice += " <a>service@homecleaningteam.com</a>";
          divInvoice += " <h3>(647)-704-6153</h3>";
        
          divInvoice += "<h3 style='font-size:2.5em'>Service Detail</h3></div>";

          divInvoice += "<div class='houseInfo'>";
          //divInvoice += "<p><span>Property Type: </span>" + h.HouseType + "</p>";
          //divInvoice += "<p><span>Property Name: </span>" + h.HouseName + "</p>";
          //divInvoice += "<p><span>Square Footage: </span>" + h.Area + " ft</p>";
          //divInvoice += "<p><span>Cleaning Type: </span>" + h.CleaningType.name + "</p>";
          //divInvoice += "<p><span>Pets:</span>" + h.Pets + "</p>";
          divInvoice += "</div>";
          divInvoice += "<br/>";
        
          divInvoice += "<div class='serviceDetailCont'><div id='serviceDetailDiv' class='grid-whole equalize'>";
        
          List<RoomItem> baths = r.Where(i => i.name == "Bathroom").ToList();
          List<RoomItem> beds = r.Where(i => i.name == "Bedroom").ToList();
          List<RoomItem> kitchens = r.Where(i => i.name == "Kitchen").ToList();
          List<RoomItem> dinings = r.Where(i => i.name == "DiningRoom").ToList();
          List<RoomItem> livings = r.Where(i => i.name == "LivingRoom").ToList();
          List<RoomItem> offices = r.Where(i => i.name == "Office").ToList();

          int bt = 1;
          int bd = 1;

          string b1width = "style='width:";
          string b2width = "style='width:";

          int bathwidth = (100 / baths.Count) - 1;
          int bedwidth = (100 / beds.Count) - 1;
        
          if (baths != null && baths.Count > 0)
          {
              b1width += bathwidth + "%'";
              foreach (RoomItem bath in baths)
              {
                  // for the actual room (Bathroom, etc)
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + bath.name + " " + bt + "</th><tbody>";
                  foreach (AppItem ap in rtq.getAppsForRoom(bath.Id))
                  {
                      // get the apps for this room
                      divInvoice += "<tr><td class='appname'>" + ap.name + "</td></tr>";
                      foreach (OptionItem op in rtq.getOptionsForApp(ap.Id))
                      {
                          divInvoice += "<tr><td>" + op.name + "</td></tr>";
                      }
                  }
                  divInvoice += "</tbody></table>";   // closing for room table
                  bt++;
              }
              divInvoice += "<br/>";
          }


          if (beds != null && beds.Count > 0)
          {
              b2width += bedwidth + "%'";
              foreach (RoomItem bed in beds)
              {
                  // for the actual room (Bathroom, etc)
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + bed.name + " " + bd + "</th><tbody>";
                  foreach (AppItem ap in rtq.getAppsForRoom(bed.Id))
                  {
                      // get the apps for this room
                      divInvoice += "<tr><td class='appname'>" + ap.name + "</td></tr>";
                      foreach (OptionItem op in rtq.getOptionsForApp(ap.Id))
                      {
                          divInvoice += "<tr><td>" + op.name + "</td></tr>";
                      }
                  }
                  divInvoice += "</tbody></table>";   // closing for room table
                  bd++;
              }
              divInvoice += "<br/>";
          }

          if (kitchens != null && kitchens.Count > 0)
          {
              foreach (RoomItem kitchen in kitchens)
              {
                  // for the actual room (Bathroom, etc)
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + kitchen.name + "</th><tbody>";
                  foreach (AppItem ap in rtq.getAppsForRoom(kitchen.Id))
                  {
                      // get the apps for this room
                      divInvoice += "<tr><td class='appname'>" + ap.name + "</td></tr>";
                      foreach (OptionItem op in rtq.getOptionsForApp(ap.Id))
                      {
                          divInvoice += "<tr><td>" + op.name + "</td></tr>";
                      }
                  }
                  divInvoice += "</tbody></table>";   // closing for room table
              }
              divInvoice += "<br/>";
          }

          if (dinings != null && dinings.Count > 0)
          {
              foreach (RoomItem dining in dinings)
              {
                  // for the actual room (Bathroom, etc)
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + dining.name + "</th><tbody>";
                  foreach (AppItem ap in rtq.getAppsForRoom(dining.Id))
                  {
                      // get the apps for this room
                      divInvoice += "<tr><td class='appname'>" + ap.name + "</td></tr>";
                      foreach (OptionItem op in rtq.getOptionsForApp(ap.Id))
                      {
                          divInvoice += "<tr><td>" + op.name + "</td></tr>";
                      }
                  }
                  divInvoice += "</tbody></table>";   // closing for room table
              }
              divInvoice += "<br/>";
          }

          if (livings != null && livings.Count > 0)
          {
              foreach (RoomItem living in livings)
              {
                  // for the actual room (Bathroom, etc)
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + living.name + "</th><tbody>";
                  foreach (AppItem ap in rtq.getAppsForRoom(living.Id))
                  {
                      // get the apps for this room
                      divInvoice += "<tr><td class='appname'>" + ap.name + "</td></tr>";
                      foreach (OptionItem op in rtq.getOptionsForApp(ap.Id))
                      {
                          divInvoice += "<tr><td>" + op.name + "</td></tr>";
                      }
                  }
                  divInvoice += "</tbody></table>";   // closing for room table
              }
              divInvoice += "<br/>";
          }

          if (offices != null && offices.Count > 0)
          {
              foreach (RoomItem office in offices)
              {
                  // for the actual room (Bathroom, etc)
                  divInvoice += "<table class='roomtable'>";
                  divInvoice += "<thead><th>" + office.name + "</th><tbody>";
                  foreach (AppItem ap in rtq.getAppsForRoom(office.Id))
                  {
                      // get the apps for this room
                      divInvoice += "<tr><td class='appname'>" + ap.name + "</td></tr>";
                      foreach (OptionItem op in rtq.getOptionsForApp(ap.Id))
                      {
                          divInvoice += "<tr><td>" + op.name + "</td></tr>";
                      }
                  }
                  divInvoice += "</tbody></table>";   // closing for room table
              }
              divInvoice += "<br/>";
          }

          divInvoice += "</div></div>";

          divInvoice += "</div>"; // closing div for outermost
          return divInvoice;*/
      }

    public void filldb()
    {
        for (var i = 0; i < 5000; i++)
        {
            string s = "Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,";
            s += "Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,";
            s += "Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,";
            s += "Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,";
            s += "Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,";
            s += "Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,Test,1,";
            OptionItem o = new OptionItem();
            o.name = s;
            o.AppItem_Id = 1;
            db.OptionItems.AddObject(o);
            db.SaveChanges();
        }
    }
    /*
    public string getCustomers()
    {
        string table = "<table class='datatable'><thead><th>Customer Id</th><th>Customer Name</th><th>Date Joined</th><th>Status</th></thead><tbody>";
        List<CustomerDTOTable> cust = customer.getCustomers();
        if (cust != null)
        {
            foreach (CustomerDTOTable c in cust)
            {
                table += "<tr id='" + c.CustomerID + "'>";
                table += "<td>" + c.CustomerID + "</td><td>" + c.CustomerName + "</td><td>" + c.JoinDate + "</td><td>" + c.Status + "</td></tr>";
                table += "</tr>";
            }
        }
        table += "</tbody></table>";
        return table;
    }
    
    public string getQuotes()
    {
        string table = "<table class='datatable'><thead><th>Quote Code</th><th>Email</th><th>Price</th></thead><tbody>";
        List<QuoteDTOTable> q = sales.getQuotes();
        if (q != null)
        {
            foreach (QuoteDTOTable i in q)
            {
                table += "<tr id='" + i.QuoteCode + "'>";
                table += "<td>" + i.QuoteCode + "</td><td>" + i.Email + "</td><td>" + i.Price + "</td></tr>";
                table += "</tr>";
            }
        }
        table += "</tbody></table>";
        return table;
    }


    public string getInvoices()
    {
        string table = "<table class='datatable'><thead><th>Invoice Id</th><th>Date Created</th></thead><tbody>";
        List<InvoiceDTOTable> inv = sales.getInvoices();
        if (inv != null)
        {
            foreach (InvoiceDTOTable i in inv)
            {
                table += "<tr id='" + i.InvoiceID + "'>";
                table += "<td>" + i.InvoiceID + "</td><td>" + i.DateCreated + "</td></tr>";
                table += "</tr>";
            }
        }
        table += "</tbody></table>";
        return table;
    }
    */
}