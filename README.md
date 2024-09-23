# M2PDF-WIN

Automate your markdown conversion to PDF

Requirements:
* Pandoc: [https://pandoc.org/installing.html](https://pandoc.org/installing.html)
* LaTeX: [https://latex-project.org/get/](https://latex-project.org/get/)

Run as command in Powershell:

```
# Get all directories containing Markdown files
 $directories = Get-ChildItem -Directory -Recurse

 foreach ($dir in $directories) {
     # Collect all Markdown files in the current directory
     $mdFiles = Get-ChildItem -Path $dir.FullName -Filter *.md | ForEach-Object { $_.FullName }

     if ($mdFiles.Count -gt 0) {
         # Define the output PDF file name based on the directory name
         $outputFile = Join-Path -Path $dir.FullName -ChildPath "$($dir.Name).pdf"

         # Display the list of files being processed
         Write-Host "Merging the following files into ${outputFile}:" -ForegroundColor Green
         $mdFiles | ForEach-Object { Write-Host $_ }

         # Use Pandoc to merge all files into one PDF using XeLaTeX
         pandoc $mdFiles -o $outputFile --pdf-engine=xelatex

         Write-Host "${outputFile} has been created." -ForegroundColor Yellow
     } else {
         Write-Host "No Markdown files found in $($dir.FullName)." -ForegroundColor Red
     }
}
```

**Explanation:**
1. **Get-ChildItem -Directory -Recurse**: This retrieves all subdirectories recursively.
2. **Loop through each directory**: The script iterates over each directory.
3. **Collect Markdown files**: It collects all .md files in the current directory.
4. **Check for Markdown files**: If any Markdown files are found, it defines the output PDF file name based on the directory name.
5. **Merge and Convert**: It uses Pandoc to merge the Markdown files into a single PDF file in the same directory.
6. **Output messages**: Displays messages indicating which files are being processed and when the PDF is created.

