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

}