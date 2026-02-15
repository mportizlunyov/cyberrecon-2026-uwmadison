# CyberRECon 2026 UW-Madison Proof of Concepts
Developed by **Mikhail Ortiz-Lunyov**

## \#1: MCP from intruding Windows 11 device
![PoC1 Diagram](./img/CyberRECon%202026%20PoC1%20White.png)
In this Proof of Concept, we will have an *Intruder* Windows 11 Pro device running a local MCP server via stdio.

## \#2: MCP from local linux server
![PoC2 Diagram](./img/CyberRECon%202026%20PoC2%20White.png)
In this Proof of Concept, we will have a local server run an **unauthenticated** MCP server over HTTP, with the *Intruder* Windows 11 device.


This repository has several files, intended for different OSes:
 - Setup-MCP-POC1.ps1: A PowerShell 7+ script for setting up PoC1
 - Setup-MCP-POC2.sh : A Bash script for setting up PoC2

The following software is used:
 - BASH
 - Batch (cmd.exe)
 - PowerShell 7+
 - Python 3+
   - FastMCP 2.14+