using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CustomerManager
/// </summary>
public class CustomerManager
{
    hctDBEntities db = new hctDBEntities();

	public CustomerManager()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public Customer getCustomer(int id)
    {
        return db.Customers.Where(i => i.Id == id).FirstOrDefault();
    }

    public List<Property> getProperties()
    {
        return db.Properties.OrderBy(i => i.Id).ToList();
    }

    // get a DTO of customer depending on required "displayable" data
    public List<CustomerDTOTable> getCustomers()
    {
        using (var context = new hctDBEntities())
        {
            List<Customer> cl = context.Customers.OrderBy(i => i.Id).ToList();
            List<CustomerDTOTable> dl = new List<CustomerDTOTable>();

            foreach (Customer c in cl)
            {
                Person p = context.People.Where(pp => pp.Customer_Id == c.Id).FirstOrDefault();
                CustomerDTOTable cdt = new CustomerDTOTable();
                cdt.CustomerID = c.custID;
                cdt.FirstName = p.fname;
                cdt.LastName = p.lname;
                cdt.JoinDate = c.joinDate.ToString();
                cdt.Status = c.status;
                dl.Add(cdt);
            }
            return dl;
        }
    }

    // get a single DTO of a customer
    public CustomerDTO getCustomerById(string id)
    {
        // note: update this to accommodate multiple properties + multiple addresses

        Customer c = db.Customers.Where(o => o.custID == id).FirstOrDefault();
        Person p = db.People.Where(d => d.Customer_Id == c.Id).FirstOrDefault();
        Address ad = null;

        CustomerDTO cd = new CustomerDTO();
        cd.PersonID = p.Id;
        cd.CustomerID = c.custID;
        cd.FirstName = p.fname;
        cd.LastName = p.lname;
        cd.Email1 = p.email1;
        cd.Email2 = p.email2;
        cd.HomePhone = p.homePhone;
        cd.MobilePhone = p.mobilePhone;
        cd.WorkPhone = p.workPhone;
        cd.Status = c.status;
        cd.JoinDate = c.joinDate.ToString();

        Property pr = db.Properties.Where(pd => pd.Customer_Id == c.Id).FirstOrDefault();
        if( pr != null )
            ad = db.Addresses.Where(add => add.Id == pr.Address_Id).FirstOrDefault();

        if (ad != null)
        {
            cd.AddressID = ad.Id;
            cd.Bldg = ad.bldg.ToString();
            cd.Unit = ad.unit.ToString();
            cd.Street = ad.street;
            cd.City = ad.city;
            cd.Postal = ad.postal.ToUpper();
        
            cd.HouseType = pr.HouseType_Id.ToString();
            cd.Area = pr.Area_Id.ToString();
        }
        return cd;
    }

    // save a single customer and related info
    public bool updateCustomer(string customerID, int personID, int addressID,
        string fName, string lName, string status, string home, string work,
        string mobile, string email1, string email2, string bldg, string unit, string street, string city,
        string postal, string houseType, string area)
    {
        Customer c = db.Customers.Where(i => i.custID == customerID).FirstOrDefault();
        Person p = db.People.Where(x => x.Id == personID).FirstOrDefault();
        Address a = db.Addresses.Where(s => s.Id == addressID).FirstOrDefault();
        Property pr = db.Properties.Where(px => px.Address_Id == a.Id).FirstOrDefault();

        c.status = status;
        db.SaveChanges();

        p.fname = fName;
        p.lname = lName;
        p.email1 = email1;
        p.email2 = email2;
        p.homePhone = home;
        p.workPhone = work;
        p.mobilePhone = mobile;
        db.SaveChanges();

        if (bldg != "" && bldg != null)
            a.bldg = Convert.ToInt32(bldg);
        else
            a.bldg = null;

        if (unit != "" && unit != null)
            a.unit = Convert.ToInt32(unit);
        else
            a.unit = null;
        a.street = street;
        a.city = city;
        a.postal = postal.ToUpper();
        db.SaveChanges();

        pr.HouseType_Id = Convert.ToInt32(houseType);
        pr.Area_Id = Convert.ToInt32(area);
        db.SaveChanges();

        if (c != null && p != null && a != null)
            return true;
        else
            return false;
    }

    // create a new customer
    public CustomerDTO createCustomer(string fName, string lName, string status,
                               string home, string work, string mobile, string email1, string email2, string bldg,
                                string unit, string street, string city, string postal, string area, string housetype)
    {
        Customer c = createCustomer();
        Person p = createPerson(fName, lName, email1, email2, home, mobile, work, c.Id);
        Address a = createAddress(bldg, unit, street, city, postal);
        Property pr = createProperty("Default", a.Id, Convert.ToInt32(area), c.Id, Convert.ToInt32(housetype));
        
        // assuming the customer is created

        CustomerDTO cd = null;
        
        if ( c != null && p != null) cd = getCustomerById(c.custID);

        if (c != null && p != null && a != null && pr != null)
            return cd;
        else
            return null;
    }

    // Generate customer code
    public string generateCustomerId()
    {
        string num = "";
        Customer c = null;
        bool chk = true;

        // keep creating customer ids if they already exist
        do
        {
            Random random = new Random();
            String generateChar = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9";
            char[] seperator = { ',' };
            String[] splitChars = generateChar.Split(seperator);
            String[] randomChars = new String[4];

            for (int i = 0; i < 4; i++)
            {
                randomChars[i] = splitChars[random.Next(0, splitChars.Length)];
                num += randomChars[i];
            }

            c = db.Customers.Where(i => i.custID == num).FirstOrDefault();
            if (c != null)
                chk = true;
            else
                chk = false;
        } while (chk == true);

        return num;
    }


    public Person createPerson(string fname, string lname, string email1, string email2,
                                    string home, string mobile, string work, int customer)
    {
        Person p = new Person();
        p.Customer_Id = customer;
        p.lname = lname;
        p.fname = fname;
        p.email1 = email1;
        p.email2 = email2;
        p.homePhone = home;
        p.mobilePhone = mobile;
        p.workPhone = work;
        db.People.AddObject(p);
        db.SaveChanges();
        return p;
    }

    public Address createAddress(string bldg, string unit, string street, string city,
                                        string postalcode)
    {
        Address a = new Address();
        a.bldg = Convert.ToInt32(bldg);
        if ( unit != null && unit != "")
            a.unit = Convert.ToInt32(unit);
        a.street = street;
        if ( city != null && city != "")
            a.city = city;
        a.postal = postalcode.ToUpper();
        db.Addresses.AddObject(a);
        db.SaveChanges();
        return a;
    }

    public Customer createCustomer()
    {
        Customer c = new Customer();
        c.custID = generateCustomerId();
        c.joinDate = DateTime.Now;
        c.status = "Active";
        db.Customers.AddObject(c);
        db.SaveChanges();
        return c;
    }

    // a property is a combination of house and customer and address
    public Property createProperty(string name, int address, int area, int customer, int housetype)
    {
        Property p = new Property();
        if (address > 0 && area > 0 && customer > 0 && housetype > 0)
        {
            p.Address_Id = address;
            p.Area_Id = area;
            p.Customer_Id = customer;
            p.HouseType_Id = housetype;
            p.name = name;
            db.Properties.AddObject(p);
            db.SaveChanges();
            return p;
        }
        else
            return null;
    }

    // deleting a customer and everything connected to it
    public bool deleteCustomer(string CustomerID)
    {
        Customer c = null;
        Person p = null;
        Property pr = null;
        Address a = null;

        c = db.Customers.Where(i => i.custID == CustomerID).FirstOrDefault();

        if (c != null)
        {
            db.DeleteObject(c);
            p = db.People.Where(i => i.Customer_Id == c.Id).FirstOrDefault();
        }
        if (p != null)
        {
            pr = db.Properties.Where(o => o.Customer_Id == c.Id).FirstOrDefault();
            db.DeleteObject(p);
        }
        if (pr != null)
        {
            a = db.Addresses.Where(i => i.Id == pr.Address_Id).FirstOrDefault();
            db.DeleteObject(pr);
            db.DeleteObject(a);
        }
            
           
            db.SaveChanges();

            return true;
    }



}