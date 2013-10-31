using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EmployeeManager
/// </summary>
public class EmployeeManager
{
    hctDBEntities db = new hctDBEntities();

	public EmployeeManager()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    // Generate employee code
    public string generateEmployeeId()
    {
        string num = "";
        Employee c = null;
        bool chk = true;

        // keep creating employee ids if they already exist
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

            c = db.Employees.Where(i => i.empID == num).FirstOrDefault();
            if (c != null)
                chk = true;
            else
                chk = false;
        } while (chk == true);

        return num;
    }

    // get list of DTO employees
    public List<EmployeeDTOTable> getEmployees()
    {
        using (var context = new hctDBEntities())
        {
            List<Employee> cl = context.Employees.OrderBy(i => i.Id).ToList();
            List<EmployeeDTOTable> dl = new List<EmployeeDTOTable>();

            foreach (Employee c in cl)
            {
                EmployeeDTOTable cdt = new EmployeeDTOTable();
                cdt.EmployeeID = c.empID;
                cdt.FirstName = c.fname;
                cdt.LastName = c.lname;
                cdt.Status = c.status;
                cdt.Email1 = c.email1;
                cdt.HomePhone = c.homePhone;
                cdt.MobilePhone = c.mobilePhone;
                cdt.Rate = String.Format("{0:0.00}", c.rate);

                ;
                dl.Add(cdt);
            }
            return dl;
        }
    }

    // get list of DTO employee by its id
    public EmployeeDTO getEmployeeById(string id)
    {
        Employee e = db.Employees.Where(i => i.empID == id).FirstOrDefault();
        Address a = db.Addresses.Where(x => x.Id == e.Address_Id).FirstOrDefault();
        EmployeeDTO ed = new EmployeeDTO();

        if (e != null)
        {
            ed.EmployeeID = e.empID;
            ed.AddressID = e.Address_Id;
            ed.FirstName = e.fname;
            ed.LastName = e.lname;
            ed.Status = e.status;
            ed.Type = e.type;
            ed.Rate = e.rate.ToString();
            ed.WorkPhone = e.workPhone;
            ed.HomePhone = e.homePhone;
            ed.MobilePhone = e.mobilePhone;
            ed.HireDate = e.hireDate.ToString();
            ed.RemoveDate = e.removeDate.ToString();
            ed.Rate = e.rate.ToString();
            ed.Email1 = e.email1;
            ed.Email2 = e.email2;

            ed.Bldg = a.bldg.ToString();
            ed.Unit = a.unit.ToString();
            ed.Street = a.street;
            ed.City = a.city;
            ed.Postal = a.postal;

            return ed;
        }
        else
            return null;
    }

    public bool updateEmployee(string EmployeeID, int AddressID, string FirstName, string LastName, string Status,
                               string HomePhone, string WorkPhone, string MobilePhone, string Email1, string Email2, string Bldg, string Unit, string Street, string City,
                               string Postal)
    {
        Employee c = db.Employees.Where(i => i.empID == EmployeeID).FirstOrDefault();
        Address a = db.Addresses.Where(sx => sx.Id == AddressID).FirstOrDefault();

        c.status = Status;
        c.fname = FirstName;
        c.lname = LastName;
        c.email1 = Email1;
        c.email2 = Email2;
        c.homePhone = HomePhone;
        c.workPhone = WorkPhone;
        c.mobilePhone = MobilePhone;
        db.SaveChanges();

        if (Bldg != "" && Bldg != null)
            a.bldg = Convert.ToInt32(Bldg);
        else
            a.bldg = null;

        if (Unit != "" && Unit != null)
            a.unit = Convert.ToInt32(Unit);
        else
            a.unit = null;
        a.street = Street;
        a.city = City;
        a.postal = Postal.ToUpper();
        db.SaveChanges();

        db.SaveChanges();

        if (c != null && a != null)
            return true;
        else
            return false;
    }

    public EmployeeDTO createEmployee(string fName, string lName, string status, string type, string rate,
                                   string home, string work, string mobile, string email1, string email2, string bldg,
                                    string unit, string street, string city, string postal)
    {
        Employee c = new Employee();
        c.empID = generateEmployeeId();
        c.fname = fName;
        c.lname = lName;
        c.status = status;
        c.rate = Convert.ToDecimal(rate);
        c.hireDate = DateTime.Now;
        c.removeDate = null;
        c.type = type;
        c.workPhone = work;
        c.homePhone = home;
        c.mobilePhone = mobile;
        c.email1 = email1;
        c.email2 = email2;

        Address a = createAddress(bldg, unit, street, city, postal);
        c.Address_Id = a.Id;

        db.Employees.AddObject(c);
        db.SaveChanges();
        
        EmployeeDTO cd = null;

        if (c != null) cd = getEmployeeById(c.empID);

        if (c != null && a != null)
            return cd;
        else
            return null;
    }

    public Address createAddress(string bldg, string unit, string street, string city,
                                        string postalcode)
    {
        Address a = new Address();
        a.bldg = Convert.ToInt32(bldg);
        if (unit != null && unit != "")
            a.unit = Convert.ToInt32(unit);
        a.street = street;
        if (city != null && city != "")
            a.city = city;
        a.postal = postalcode.ToUpper();
        db.Addresses.AddObject(a);
        db.SaveChanges();
        return a;
    }

    // deleting a customer and everything connected to it
    public bool deleteEmployee(string EmployeeID)
    {
        Employee c = db.Employees.Where(i => i.empID == EmployeeID).FirstOrDefault();
        Address a = db.Addresses.Where(i => i.Id == c.Address_Id).FirstOrDefault();

        if (c != null && a != null)
        {
            db.DeleteObject(a);
            db.DeleteObject(c);
            db.SaveChanges();

            return true;
        }
        else
            return false;
    }
}