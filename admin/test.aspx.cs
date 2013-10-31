using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Diagnostics;
using System.Configuration;
using iTextSharp.text.html;


public partial class admin_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnExport_Click(object sender, EventArgs e)
    {
       /* Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=TestPage.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        this.Page.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();

        StyleSheet ST = new StyleSheet();
        ST.LoadTagStyle("td", "color", "#337abe");
        ST.LoadTagStyle("div", "background-color", "#ff8400");
        ST.LoadStyle("td", "style", "font-family:Times New Roman");
        htmlparser.SetStyleSheet(ST);

        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();*/

        HtmlToPdf("Default.aspx", "test.pdf");


       /* Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=TestPage.pdf");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        this.Page.RenderControl(hw);

        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 35f, 0f, 0f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

        pdfDoc.Open();

        //Defining tables 
        //PdfPTable termsTable = new PdfPTable(2);
        //termsTable.SetWidths(new int[2] { 2, 5 });

        //Applying Styles
        StyleSheet ST = new StyleSheet();
        FontFactory.Register("c:\\windows\\fonts\\Corbel.ttf");

        ST.LoadTagStyle("body", "face", "Corbel");
        ST.LoadTagStyle("body", "size", "12pt");
        ST.LoadTagStyle(HtmlTags.P, "face", "Corbel");
        ST.LoadTagStyle(HtmlTags.P, "size", "15pt");
        ST.LoadTagStyle(HtmlTags.H2, "face", "Corbel");
        ST.LoadTagStyle(HtmlTags.H2, "size", "12pt");
        ST.LoadTagStyle(HtmlTags.H2, "align", "center");
        ST.LoadTagStyle(HtmlTags.TD, "background-color", "#337abe");

        htmlparser.SetStyleSheet(ST);

        //Writing to PDF
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();*/

    }


    static void HtmlToPdf(string website, string destinationFile)
    {
        ProcessStartInfo startInfo = new ProcessStartInfo();
        startInfo.FileName = "~/PDFGenerator/wkhtmltopdf.exe";
        startInfo.Arguments = website + " " + destinationFile;
        Process.Start(startInfo);
    }


    protected void lnkExport_Click(object sender, EventArgs e)
    {
        byte[] fileContent = GeneratePDFFile();
        if (fileContent != null)
        {
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-length", fileContent.Length.ToString());
            Response.BinaryWrite(fileContent);
            Response.End();
        }
    }




    public void GeneratePDF()
    {/*
        string strPDFFileName = "~/PDF/test.pdf";
        string strRunArguments = Url + " \"" + strPDFFileName + "\"";

        ProcessStartInfo info = new ProcessStartInfo(wkHTMLtoPDFPath, strRunArguments);
        info.UseShellExecute = false;
        info.RedirectStandardInput = true;
        info.RedirectStandardError = true;
        info.RedirectStandardOutput = true;
        info.CreateNoWindow = true;

        using (Process scr = Process.Start(info))
        {
            scr.WaitForExit(ProcessTimeOut);
            if (!scr.HasExited)
            {
                scr.Kill();
                throw new Exception("Timed out while creating the PDF.");
            }
        }*/
    }




    private byte[] GeneratePDFFile()
    {
        //url of the page we would wanto convert.
        //we dont need to hard code this URL if we want to export current page
        //we could prepare the URL by using HTTPRequest object oo
        //string url = @"http://localhost:54630/PageExportPDF.aspx";
        string url = Request.Url.AbsoluteUri;

        //output PDF file Path
        string filepath = Path.Combine(Server.MapPath("~/PDF"), "test.pdf");

        if (System.IO.File.Exists(filepath))
            System.IO.File.Delete(filepath);

        //variable to store pdf file content
        byte[] fileContent = null;

        System.Diagnostics.Process process = new System.Diagnostics.Process();
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        //set the executable location
        process.StartInfo.FileName = Path.Combine(Server.MapPath("~/PDFGenerator"), "wkhtmltopdf.exe");
        //set the arguments to the exectuable
        // wkhtmltopdf [OPTIONS]... <input fileContent> [More input fileContents] <output fileContent>
        process.StartInfo.Arguments = url + " " + filepath;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.RedirectStandardInput = true;
        //run the executable
        process.Start();

        //wait until the conversion is done
        process.WaitForExit();

        // read the exit code, close process    
        int returnCode = process.ExitCode;
        process.Close();

        /*string file = filepath;
        byte[] buffer = null;

        if (!string.IsNullOrEmpty(filepath))
        {
            
            if (File.Exists(file))
            {
                var openFile = File.OpenRead(file);
                buffer = new byte[(int)openFile.Length];
                // copy the stream (thanks to http://stackoverflow.com/questions/230128/best-way-to-copy-between-two-stream-instances-c)
                while (true)
                {
                    int read = openFile.Read(buffer, 0, buffer.Length);
                    if (read <= 0)
                    {
                        break;
                    }
                    Response.OutputStream.Write(buffer, 0, read);
                }
                openFile.Close();
                openFile.Dispose();

                //File.Delete(file);
            }
        }*/


        //initialize the filestream with filepath
        FileStream fs = new FileStream(filepath, FileMode.Open, FileAccess.Read);
        fileContent = new byte[(int)fs.Length];

        //read the content
        fs.Read(fileContent, 0, (int)fs.Length);

        //close the stream
        fs.Close();

        return fileContent;
    }


}