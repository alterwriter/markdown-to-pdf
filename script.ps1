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
