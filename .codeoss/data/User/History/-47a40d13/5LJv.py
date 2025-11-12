import asyncio
import os
from contextlib import AsyncExitStack
from dotenv import load_dotenv
from google.adk.agents.llm_agent import LlmAgent
from google.adk.agents.loop_agent import LoopAgent
from google.adk.agents.sequential_agent import SequentialAgent
from google.adk.tools.mcp_tool.mcp_toolset import MCPToolset
from google.adk.tools.mcp_tool.mcp_session_manager import SseServerParams
import logging 
import nest_asyncio 
from typing import Optional
from google.genai import types
import requests
from datetime import datetime, timezone, timedelta
from toolbox_core import ToolboxSyncClient
from google.adk.agents.callback_context import CallbackContext




load_dotenv()

COOLDOWN_PERIOD_SECONDS = 60
COOLDOWN_API_URL = os.environ.get("API_SERVER_URL")
print(f"COOLDOWN_API_URL: {COOLDOWN_API_URL}")



logging.basicConfig(level=logging.INFO)
log = logging.getLogger(__name__)
 
# --- Global variables ---
# Define them first, initialize as None
root_agent: LlmAgent | None = None
exit_stack: AsyncExitStack | None = None


FUNCTION_TOOLS_URL = os.environ.get("FUNCTION_TOOLS_URL")
PUBLIC_URL = os.environ.get("PUBLIC_URL")


print(f"FUNCTION_TOOLS_URL: {FUNCTION_TOOLS_URL}")
print(f"PUBLIC_URL: {PUBLIC_URL}")


#REPLACE-before_agent-function

#REPLACE-setup-MCP
toolFunction =  MCPToolset(
    connection_params=SseServerParams(url=FUNCTION_TOOLS_URL, headers={})
)
#REPLACE-worker-agents
charging_agent = LlmAgent(
      model='gemini-2.5-flash', 
      name='charging_agent',  
      instruction="""
          Your task is to call the 'seismic_charge' .
          You must follow these rules strictly:

          1. You will be provided with a 'current_energy' value from the previous step.
             **If this value is missing or was not provided, you MUST call the tool with 'current_energy' set to 1.**
             This is your primary rule for the first turn.

          2. If a 'current_energy' value is provided, you MUST use that exact value in your cal to seismic_charge.

          3. Your final response MUST contain ONLY the direct output from the 'seismic_charge' tool.
             Do not add any conversational text, introductions, or summaries.
      """,
      tools=[toolFunction]
)
check_agent = LlmAgent(
      model='gemini-2.5-flash', 
      name='check_agent',  
      instruction="""
          You are the voice of the Earth Elemental, a being of immense, gathering power.
          Your sole purpose is to report on the current energy charge and announce the devastating potential of its release.

          You MUST follow this rule:
          The potential damage upon release is ALWAYS calculated as the `current_energy` from the previous step multiplied by a random number between 80-90. but no more than 300.

          Your response should be in character, like a powerful creature speaking.
          State both the current energy charge and the total potential damage you can unleash.
          Unleash the energy when you reached the last iteration (2nd).
      """,
      output_key="charging_status"
)
#REPLACE-loop-agent
root_agent = LoopAgent(
    name="earth_elemental_familiar",
    # Run parallel research first, then merge
    sub_agents=[
        charging_agent, 
        check_agent
    ],
    max_iterations=2,
    description="Coordinates parallel research and synthesizes the results.",
    #REPLACE-before_agent-config
)
#REPLACE - add A2A