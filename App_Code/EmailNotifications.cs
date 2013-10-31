using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net.Mail;
using System.Net.Mime;
/// <summary>
/// THIS MANAGER CLASS WILL HANDLE ALL AUTO EMAIL
/// NOTIFICATIONS TO BE SENT EITHER TO THE USER
/// OR TO THE MANAGER
/// </summary>
public class EmailNotifications
{
    // ALL ABOUT EMAIL AND ENCRYPTION

    // ENCODE THE ESTIMATE CODE INTO A BASE64 ARRAY
    public string base64Encode(string data)
    {
        byte[] encData_byte = new byte[data.Length];
        encData_byte = System.Text.Encoding.UTF8.GetBytes(data);
        string encodedData = Convert.ToBase64String(encData_byte);
        return encodedData;

    }

    // DECODE THE RECEIVED ESTIMATE CODE INTO A USABLE STRING
    public string base64Decode(string data)
    {

        System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
        System.Text.Decoder utf8Decode = encoder.GetDecoder();

        byte[] todecode_byte = Convert.FromBase64String(data);
        int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
        char[] decoded_char = new char[charCount];
        utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
        string result = new String(decoded_char);
        return result;

    }

    // EMAIL SETTINGS
    public bool sendEmail(string recipient, string estimateCode, string fileattach, string completefile)
    {

        string pathtoinvoice = "http://www.hct.aaronalquiza.com/PDF/";

        pathtoinvoice += fileattach;

        // must encode esimate code here
        string encodedString = base64Encode(estimateCode);

        // get the host name, slap in the encrypted estimate code
        String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
        String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "/");


        // to use another page for confirm, change the string here
        //string finalUrl = strUrl + "NLD/selfserve/confirm.aspx?estimateCode=" + encodedString;


        // create the actual email

        //MailAddress FromMailAddress = new MailAddress("bts630team8@hotmail.com");

        MailAddress FromMailAddress = new MailAddress("contact@aaronalquiza.com");
        MailAddress ToMailAddress = new MailAddress(recipient);
        MailMessage MailMsg = new MailMessage();

        MailMsg.From = FromMailAddress;
        MailMsg.To.Add(ToMailAddress);
        // attach the filename
        Attachment data = new Attachment(completefile,
                         MediaTypeNames.Application.Octet);

        MailMsg.Attachments.Add(data);
        MailMsg.IsBodyHtml = true;
        MailMsg.Subject = "The Home Cleaning Team : Your Quote has been created";

        // create a clickable link for the encrypted estimate code
        MailMsg.Body = @"
                 <html>
                    <style>
                           body { text-align:left }
                           table { width:90%; border:1px solid #337abe; }
                           td { border:1px solid #C6C6C6; margin-top:1px; margin-left:1px; }
                           th { border:1px solid #282828; background-color:#CCCCCC; }
                           div.title { width:80%; background-color:#CCCCCC; }
                           div.emailmessage { padding:15px; border:1px solid #282828; width:80%; }
                           h2 { font-size:1.5em; color:#337abe; font-weight:600 }
                           h3 { font-size:1.1em; color:#337abe }
                           img.logo { width:auto; }
                           img.invoice { width:90%; margin:auto; }
                            p { width:80%; text-align:left }
                    </style>
                     <body>
                        <img class='logo' src='http://www.hct.aaronalquiza.com/Styles/img/hctlogo.png' />
                        <div class='title'><h2>Quote from the Real Time Quote System</h2></div>
                        <div class='emailmessage'>
                         <br/>
                         <p><strong>Thank you for trying out the Real Time Quote System.</strong></p>
                         <br/><h3>Your Quote code is: &nbsp;" + estimateCode +

                         @" </h3>
                            <br/>
                            <p>Embedded in this email is the Service details of your quote. If the summary image
                                isn't visible in this email, you can find the attached copy. Your next step will be to register if
                                you haven't already; or to book your quote's job date.</p>
                         
                            <h3>SERVICE DETAIL SUMMARY</h3>
                            <img class='invoice' src='" + pathtoinvoice + @"' alt='Image not viewable (please download the attached copy)' />
                        <br/><br/>
                            <p>If you're not yet registered, please click here: </p>
                            <p>If you've registered and want to set the job, please click here </p>
                        <br/>
                        </div>
                        <h4>Please contact us if you have questions:</h4>
                        <div class='footer'>
                            <p>Jacob Brettler<br/>
                                Founder, The Home Cleaning Team<br/>
                            Phone: 647-704-6153<br/>
                            Email Address: jacobbrettler@gmail.com</p>
                        </div>
                        <br/>
                        <br/>
                        </body>
                </html>";

        // here, insert a table of all their selection, and the total price and time.

        SmtpClient MailSender = new SmtpClient();
        //MailSender.EnableSsl = true;



        // ... new ...

        MailSender.Host = "aaronalquiza.com";
        MailSender.Port = 25;
        MailSender.UseDefaultCredentials = false;
        MailSender.Credentials = new System.Net.NetworkCredential("contact@aaronalquiza.com", "radflo768768");
        MailSender.EnableSsl = false;

        try
        {
            MailSender.Send(MailMsg);
            return true;
        }
        catch
        {
            return false;
        }
    }
}