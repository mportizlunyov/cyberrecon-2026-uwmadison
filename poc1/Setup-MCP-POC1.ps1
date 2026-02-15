# CyberRECon 2026 UW-Madison
# Developed by Mikhail Ortiz-Lunyov
# February 2026
#
# Setup script to create Proof-of-Concept #1
# Assuming Windows 11, standard Claude Desktop installation
#
# Confirm your sandbox allows file writing!

# This script will install the following:
# - FastMCP (Python) v2

Write-Host "== VERIFYING PACKAGES == == == =="
# Check if nessesary programs are installed
## Python
try {
    python.exe --version
} catch {
    Write-Host "$_"
    Exit $False
}
## Claude Desktop
if (-not (Test-Path (Join-Path $env:APPDATA "Claude"))) {
    Write-Host "$_"
    Write-Host "Claude Desktop NOT installed, please install"
    Exit $False
}

# Install default FastMCP if not installed
try {
    python.exe -m pip install FastMCP
    # Verify installation
    $null = python.exe -m pip show FastMCP
} catch {
    Write-Host "$_"
    Exit $False
}

# Make reminder to edit Claude Desktop Settings
Write-Host "== SETTING UP FastMCP Python == == == =="
Write-Host "Dont forget to add the following in:"
Write-Host "`` %USERPROFILE%\AppData\Roaming\Claude\claude_desktop_config.json ``"
Write-Host "`t`"mcpServers`": {"
Write-Host "`t  `"cyberrecon-mcp`":{"
Write-Host "`t    `"command`":`"python.exe`","
Write-Host "`t    `"args`":[`"C:\\Users\\Mikhail\\Documents\\03_CyberRECon\\2026\\Proof of Concept\\Project\\server.py`",`"1`"]"
Write-Host "`t  }"
Write-Host "`t},"
Write-Host "== == == == == == == == == == == == == =="
# Run Setup-MCP-BOTH.py
python.exe .\..\server.py 1