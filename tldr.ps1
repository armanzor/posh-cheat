# Get tldr content from https://cht.sh
$param1 = $args[0]
$uri = "https://cht.sh/$param1"
# Write-Host $uri     # Debug
(Invoke-WebRequest -UseBasicParsing -Uri $uri).Content
