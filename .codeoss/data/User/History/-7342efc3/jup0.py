from google.adk.agents.remote_a2a_agent import AGENT_CARD_WELL_KNOWN_PATH
from google.adk.agents.remote_a2a_agent import RemoteA2aAgent
from google.adk.agents.sequential_agent import SequentialAgent
from google.adk.agents.llm_agent import LlmAgent
import os
from google.adk.tools import load_memory
from google.adk.tools.tool_context import ToolContext

from typing import Dict, Any, Optional

# Assume these environment variables are set
FIRE_URL = os.environ.get("FIRE_URL", "http://fire.example.com")
WATER_URL = os.environ.get("WATER_URL", "http://water.example.com")
EARTH_URL = os.environ.get("EARTH_URL", "http://earth.example.com")

print(f"FIRE_URL: {FIRE_URL}")
print(f"WATER_URL: {WATER_URL}")
print(f"EARTH_URL: {EARTH_URL}")


#REPLACE-remote-agents
fire_familiar = RemoteA2aAgent(
    name="fire_familiar",
    description="Fire familiar",
    agent_card=(
        f"{FIRE_URL}/{AGENT_CARD_WELL_KNOWN_PATH}"
    ),
)

water_familiar = RemoteA2aAgent(
    name="water_familiar",
    description="Water familiar",
    agent_card=(
        f"{WATER_URL}/{AGENT_CARD_WELL_KNOWN_PATH}"
    ),
)

earth_familiar = RemoteA2aAgent(
    name="earth_familiar",
    description="Earth familiar",
    agent_card=(
        f"{EARTH_URL}/{AGENT_CARD_WELL_KNOWN_PATH}"
    ),
)
#REPLACE-save_last_summon_after_tool

#REPLACE-orchestrate-agent





from agent_to_a2a import to_a2a

PUBLIC_URL = os.environ.get("PUBLIC_URL","http://0.0.0.0:8080")

if __name__ == "__main__":
    import uvicorn
    a2a_app = to_a2a(root_agent, port=8080, public_url=PUBLIC_URL)
    uvicorn.run(a2a_app, host='0.0.0.0', port=8080)
