using System.Xml.Xsl;
using System.Xml;
void ConvertXSLFOtoHTML()
{
    try
    {
        // XSLT compiler with support for C# script blocks and document() function
        var xslt = new XslCompiledTransform();
        var settings = new XsltSettings(enableDocumentFunction: true, enableScript: true);
        var resolver = new XmlUrlResolver();

        // Base path where your XSL and FO files are stored
        string basePath = AppDomain.CurrentDomain.BaseDirectory;
        string xslPath = Path.Combine(basePath, "Resources", "fo-to-html.xsl");
        string foPath = Path.Combine(basePath, "Resources", "input.fo");
        string outputHtmlPath = Path.Combine(basePath, "output.html");

        // ✅ Fix: Load XSLT using XmlReader (avoids URI errors and allows includes)
        using var xslReader = XmlReader.Create(xslPath);
        xslt.Load(xslReader, settings, resolver);

        // Optional: Add parameters to the XSLT if needed
        var args = new XsltArgumentList();
        // args.AddParam("clientName", "", "Srinath");

        // Transform input.fo → HTML string
        using var stringWriter = new StringWriter();
        using var xmlWriter = XmlWriter.Create(stringWriter, xslt.OutputSettings);
        xslt.Transform(foPath, args, xmlWriter);
        xmlWriter.Flush();

        // Save the result
        string html = stringWriter.ToString();
        File.WriteAllText(outputHtmlPath, html);

        Console.WriteLine("✅ HTML transformation complete.");
        Console.WriteLine($"📝 Output saved to: {outputHtmlPath}");
    }
    catch (XsltException ex)
    {
        Console.WriteLine("❌ XSLT Compile Error:");
        Console.WriteLine($"Message: {ex.Message}");
        Console.WriteLine($"Line: {ex.LineNumber}, Position: {ex.LinePosition}");
        Console.WriteLine($"File: {ex.SourceUri}");
    }
    catch (Exception ex)
    {
        Console.WriteLine("❌ General Error: " + ex.Message);
    }
}

ConvertXSLFOtoHTML();