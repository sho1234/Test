using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

public class CSVUtility
{
    private readonly string _filePath;
    private static string _encodingType;
    private static char _delimiter;
    private List<string[]> _csvData;

    public List<string[]> CSVData
    {
        get { return _csvData; }
        private set { _csvData = value; }
    }

    public CSVUtility(string filePath)
    {
        _filePath = filePath;
        _encodingType = "Shift_JIS";
        _delimiter = ',';
        ReadCSV();
    }

    private string[][] ReadCSV()
    {
        try
        {
            _csvData = new List<string[]>();
            StreamReader reader = new StreamReader(_filePath, Encoding.GetEncoding(_encodingType));
            while (reader.Peek() >= 0)
            {
                _csvData.Add(reader.ReadLine().Split(_delimiter));
            }
            reader.Close();
            return _csvData.ToArray();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
    }

    public void ShowCSV()
    {
        foreach (var row in _csvData)
        {
            foreach (var col in row)
            {
                Console.Write(col + "\t");
            }
            Console.WriteLine();
        }
    }

    public void WriteCSV(string fileName)
    {
        List<string> joinCSVData = new List<string>();
        foreach (var row in _csvData)
        {
            joinCSVData.Add(string.Join(",", row));
        }
        File.WriteAllLines(fileName, joinCSVData, Encoding.GetEncoding(_encodingType));
    }
}
