gcloud projects list | awk '/PROJECT_ID/{print $2}'
gcloud services enable   run.googleapis.com   artifactregistry.googleapis.com   cloudbuild.googleapis.com
ls
cat pyproject.toml
uv add fastmcp==2.11.1 --no-sync
cloudshell edit server.py
cloudshell edit Dockerfile
gcloud run deploy zoo-mcp-server     --no-allow-unauthenticated     --region=europe-west1     --source=.     --labels=dev-tutorial=codelab-mcp
pwd
cd /home/suyashsaxena015
ls
mv Dockerfile mcp-on-cloudrun/
ls
cd mcp-on-cloudrun/
ls
gcloud run deploy zoo-mcp-server     --no-allow-unauthenticated     --region=europe-west1     --source=.     --labels=dev-tutorial=codelab-mcp
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT     --member=user:$(gcloud config get-value account)     --role='roles/run.invoker'
export PROJECT_NUMBER=$(gcloud projects describe $GOOGLE_CLOUD_PROJECT --format="value(projectNumber)")
export ID_TOKEN=$(gcloud auth print-identity-token)
echo $PROJECT_NUMBER
cloudshell edit ~/.gemini/settings.json
gemini
gcloud run services logs read zoo-mcp-server --region europe-west1 --limit=5
gcloud run deploy zoo-mcp-server     --no-allow-unauthenticated     --region=europe-west1     --source=.     --labels=dev-tutorial=codelab-mcp
export ID_TOKEN=$(gcloud auth print-identity-token)
gcloud config set project storied-groove-473216-u6 
gcloud services enable     run.googleapis.com     artifactregistry.googleapis.com     cloudbuild.googleapis.com     aiplatform.googleapis.com     compute.googleapis.com 
gcloud services enable     run.googleapis.com     artifactregistry.googleapis.com     cloudbuild.googleapis.com     aiplatform.googleapis.com     compute.googleapis.com 
cd && mkdir zoo_guide_agent && cd zoo_guide_agent
cloudshell edit requirements.txt
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
export SERVICE_ACCOUNT="${PROJECT_NUMBER}-compute@developer.gserviceaccount.com"
cloudshell edit .env
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT"   --role="roles/run.invoker"
echo -e "\nMCP_SERVER_URL=https://zoo-mcp-server-${PROJECT_NUMBER}.europe-west1.run.app/mcp/" >> .env
cloudshell edit __init__.py
cloudshell edit agent.py
source .env
# Grant the "Vertex AI User" role to your service account
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT"   --role="roles/aiplatform.user"
# Run the deployment command
uvx --from google-adk adk deploy cloud_run   --project=$PROJECT_ID   --region=europe-west1   --service_name=zoo-tour-guide   --with_ui   .   --   --labels=dev-tutorial=codelab-adk
gcloud run services delete zoo-tour-guide --region=europe-west1 --quiet
gcloud artifacts repositories delete cloud-run-source-deploy --location=europe-west1 --quiet
gcloud config set project storied-groove-473216-u6 
gcloud services enable   run.googleapis.com   artifactregistry.googleapis.com   cloudbuild.googleapis.com   aiplatform.googleapis.com
gcloud config set run/region europe-west1
cd ~
git clone https://github.com/amitkmaraj/accelerate-ai-lab3-starter.git
cd accelerate-ai-lab3-starter
cd ollama-backend
gcloud run deploy ollama-gemma3-270m-gpu   --source .   --region europe-west1   --concurrency 7   --cpu 8   --set-env-vars OLLAMA_NUM_PARALLEL=4   --gpu 1   --gpu-type nvidia-l4   --max-instances 1   --memory 16Gi   --allow-unauthenticated   --no-cpu-throttling   --no-gpu-zonal-redundancy   --timeout 600   --labels dev-tutorial=codelab-agent-gpu
export OLLAMA_URL=$(gcloud run services describe ollama-gemma3-270m-gpu \
    --region=europe-west1 \
    --format='value(status.url)')
echo "�� Gemma backend deployed at: $OLLAMA_URL"
cd ../adk-agent
cloudshell edit production_agent/agent.py
cat << EOF > .env
GOOGLE_CLOUD_PROJECT=$(gcloud config get-value project)
GOOGLE_CLOUD_LOCATION=europe-west1
GEMMA_MODEL_NAME=gemma3:270m
OLLAMA_API_BASE=$OLLAMA_URL
EOF

export PROJECT_ID=$(gcloud config get-value project)
gcloud run deploy production-adk-agent    --source .    --region europe-west1    --allow-unauthenticated    --memory 4Gi    --cpu 2    --max-instances 1    --concurrency 50    --timeout 300    --set-env-vars GOOGLE_CLOUD_PROJECT=$PROJECT_ID    --set-env-vars GOOGLE_CLOUD_LOCATION=europe-west1    --set-env-vars GEMMA_MODEL_NAME=gemma3:270m    --set-env-vars OLLAMA_API_BASE=$OLLAMA_URL    --labels dev-tutorial=codelab-agent-gpu
export AGENT_URL=$(gcloud run services describe production-adk-agent \
    --region=europe-west1 \
    --format='value(status.url)')
echo "🎉 ADK Agent deployed at: $AGENT_URL"
curl $AGENT_URL/health
uv sync
uv run locust -f elasticity_test.py    -H $AGENT_URL    --headless    -t 60s    -u 20    -r 5
gcloud auth list
git clone https://github.com/weimeilin79/agentverse-dataengineer
chmod +x ~/agentverse-dataengineer/init.sh
chmod +x ~/agentverse-dataengineer/set_env.sh
chmod +x ~/agentverse-dataengineer/data_setup.sh
git clone https://github.com/weimeilin79/agentverse-dungeon.git
chmod +x ~/agentverse-dungeon/run_cloudbuild.sh
chmod +x ~/agentverse-dungeon/start.sh
cd ~/agentverse-dataengineer
./init.sh
gcloud config set project $(cat ~/project_id.txt) --quiet
gcloud services enable     storage.googleapis.com     bigquery.googleapis.com     sqladmin.googleapis.com     aiplatform.googleapis.com     dataflow.googleapis.com     pubsub.googleapis.com     cloudfunctions.googleapis.com     run.googleapis.com     cloudbuild.googleapis.com     artifactregistry.googleapis.com     iam.googleapis.com     compute.googleapis.com     cloudresourcemanager.googleapis.com     cloudaicompanion.googleapis.com     bigqueryunified.googleapis.com 
. ~/agentverse-dataengineer/set_env.sh
gcloud artifacts repositories create $REPO_NAME     --repository-format=docker     --location=$REGION     --description="Repository for Agentverse agents"
. ~/agentverse-dataengineer/set_env.sh
gcloud artifacts repositories create $REPO_NAME     --repository-format=docker     --location=$REGION     --description="Repository for Agentverse agents"
. ~/agentverse-dataengineer/set_env.sh
# --- Grant Core Data Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/storage.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/bigquery.admin"
# --- Grant Data Processing & AI Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/dataflow.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/cloudsql.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/pubsub.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/aiplatform.user"
# --- Grant Deployment & Execution Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/cloudbuild.builds.editor"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/artifactregistry.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/run.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/iam.serviceAccountUser"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/logging.logWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT_NAME"   --role="roles/dataflow.admin"
. ~/agentverse-dataengineer/set_env.sh
cd ~/agentverse-dungeon
./run_cloudbuild.sh
cd ~/agentverse-dataengineer
. ~/agentverse-dataengineer/set_env.sh
. ~/agentverse-dataengineer/data_setup.sh
bq mk --connection   --connection_type=CLOUD_RESOURCE   --project_id=${PROJECT_ID}   --location=${REGION}   gcs-connection
. ~/agentverse-dataengineer/set_env.sh
bq --location=${REGION} mk --dataset ${PROJECT_ID}:bestiary_data. ~/agentverse-dataengineer/set_env.sh
bq --location=${REGION} mk --dataset ${PROJECT_ID}:bestiary_data
. ~/agentverse-dataengineer/set_env.sh
export CONNECTION_SA=$(bq show --connection --project_id=${PROJECT_ID} --location=${REGION} --format=json gcs-connection  | jq -r '.cloudResource.serviceAccountId')
echo "The Conduit's Magical Signature is: $CONNECTION_SA"
echo "Granting key to the GCS Archive..."
gcloud storage buckets add-iam-policy-binding gs://${PROJECT_ID}-reports   --member="serviceAccount:$CONNECTION_SA"   --role="roles/storage.objectViewer"
gcloud projects add-iam-policy-binding ${PROJECT_ID}   --member="serviceAccount:$CONNECTION_SA"   --role="roles/aiplatform.user"
echo $BUCKET_NAME
https://console.cloud.google.com/bigqueryhttps://console.cloud.google.com/bigquery
https://console.cloud.google.com/bigquery
echo $BUCKET_NAME
https://console.cloud.google.com/bigquery
echo $BUCKET_NAME
. ~/agentverse-dataengineer/set_env.sh
bq --location=${REGION} mk --dataset ${PROJECT_ID}:bestiary_data. ~/agentverse-dataengineer/set_env.sh
bq --location=${REGION} mk --dataset ${PROJECT_ID}:bestiary_data
echo $BUCKET_NAME
. ~/agentverse-dataengineer/set_env.sh
. ~/agentverse-dataengineer/data_setup.sh
bq mk --connection   --connection_type=CLOUD_RESOURCE   --project_id=${PROJECT_ID}   --location=${REGION}   gcs-connection
echo "${PROJECT_ID}.${REGION}.gcs-connection"
. ~/agentverse-dataengineer/set_env.sh
echo "${PROJECT_ID}.${REGION}.gcs-connection"
. ~/agentverse-dataengineer/set_env.sh
echo "Verifying the existence of the Spellbook (Cloud SQL instance): $INSTANCE_NAME..."
gcloud sql instances describe $INSTANCE_NAME
SERVICE_ACCOUNT_EMAIL=$(gcloud sql instances describe $INSTANCE_NAME --format="value(serviceAccountEmailAddress)")
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL"   --role="roles/aiplatform.user"
. ~/agentverse-dataengineer/set_env.sh
gcloud sql databases create $DB_NAME --instance=$INSTANCE_NAME
. ~/agentverse-dataengineer/set_env.sh
cd ~/agentverse-dataengineer/pipeline
gcloud builds submit --config cloudbuild.yaml   --substitutions=_REGION=${REGION},_REPO_NAME=${REPO_NAME}   .
cd ~/agentverse-dataengineer
. ~/agentverse-dataengineer/set_env.sh
python -m venv env
source ~/agentverse-dataengineer/env/bin/activate
cd ~/agentverse-dataengineer/pipeline
pip install -r requirements.txt
. ~/agentverse-dataengineer/set_env.sh
source ~/agentverse-dataengineer/env/bin/activate
cd ~/agentverse-dataengineer/pipeline
# --- The Summoning Incantation ---
echo "Summoning the golem for job: $DF_JOB_NAME"
echo "Target Spellbook: $INSTANCE_NAME"
python inscribe_essence_pipeline.py   --runner=DataflowRunner   --project=$PROJECT_ID   --job_name=$DF_JOB_NAME   --temp_location="gs://${BUCKET_NAME}/dataflow/temp"   --staging_location="gs://${BUCKET_NAME}/dataflow/staging"   --sdk_container_image="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/grimoire-inscriber:latest"   --sdk_location=container   --experiments=use_runner_v2   --input_pattern="gs://${BUCKET_NAME}/ancient_scrolls/*.md"   --instance_name=$INSTANCE_NAME   --region=$REGION
echo "The golem has been dispatched. Monitor its progress in the Dataflow console."
cd ~/agentverse-dataengineer/
. ~/agentverse-dataengineer/set_env.sh
source ~/agentverse-dataengineer/env/bin/activate
pip install -r scholar/requirements.txt
adk run scholar
. ~/agentverse-dataengineer/set_env.sh
cd ~/agentverse-dataengineer/
echo "Building ${AGENT_NAME} agent..."
gcloud builds submit .   --project=${PROJECT_ID}   --region=${REGION}   --substitutions=_AGENT_NAME=${AGENT_NAME},_IMAGE_PATH=${IMAGE_PATH}
gcloud run deploy ${SERVICE_NAME}   --image=${IMAGE_PATH}   --platform=managed   --labels="dev-tutorial-codelab=agentverse"   --region=${REGION}   --set-env-vars="A2A_HOST=0.0.0.0"   --set-env-vars="A2A_PORT=8080"   --set-env-vars="GOOGLE_GENAI_USE_VERTEXAI=TRUE"   --set-env-vars="GOOGLE_CLOUD_LOCATION=${REGION}"   --set-env-vars="GOOGLE_CLOUD_PROJECT=${PROJECT_ID}"   --set-env-vars="PROJECT_ID=${PROJECT_ID}"   --set-env-vars="PUBLIC_URL=${PUBLIC_URL}"   --set-env-vars="REGION=${REGION}"   --set-env-vars="INSTANCE_NAME=${INSTANCE_NAME}"   --set-env-vars="DB_USER=${DB_USER}"   --set-env-vars="DB_PASSWORD=${DB_PASSWORD}"   --set-env-vars="DB_NAME=${DB_NAME}"   --allow-unauthenticated   --project=${PROJECT_ID}   --min-instances=1
. ~/agentverse-dataengineer/set_env.sh
echo https://scholar-agent"-${PROJECT_NUMBER}.${REGION}.run.app"
. ~/agentverse-dataengineer/set_env.sh
echo https://agentverse-dungeon"-${PROJECT_NUMBER}.${REGION}.run.app"
gcloud auth list
git clone https://github.com/weimeilin79/agentverse-architect
chmod +x ~/agentverse-architect/init.sh
chmod +x ~/agentverse-architect/set_env.sh
chmod +x ~/agentverse-architect/prepare.sh
chmod +x ~/agentverse-architect/data_setup.sh
git clone https://github.com/weimeilin79/agentverse-dungeon.git
chmod +x ~/agentverse-dungeon/run_cloudbuild.sh
chmod +x ~/agentverse-dungeon/start.sh
cd ~/agentverse-architect
./init.sh
gcloud config set project $(cat ~/project_id.txt) --quiet
gcloud services enable     sqladmin.googleapis.com     storage.googleapis.com     aiplatform.googleapis.com     run.googleapis.com     cloudbuild.googleapis.com     artifactregistry.googleapis.com     iam.googleapis.com     compute.googleapis.com     cloudresourcemanager.googleapis.com     secretmanager.googleapis.com
. ~/agentverse-architect/set_env.sh
gcloud artifacts repositories create $REPO_NAME     --repository-format=docker     --location=$REGION     --description="Repository for Agentverse agents"
. ~/agentverse-architect/set_env.sh
# --- Grant Core Data Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/storage.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/aiplatform.user"
# --- Grant Deployment & Execution Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/cloudbuild.builds.editor"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/artifactregistry.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/run.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/iam.serviceAccountUser"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/logging.logWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:${SERVICE_ACCOUNT_NAME}"   --role="roles/monitoring.metricWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:${SERVICE_ACCOUNT_NAME}"   --role="roles/secretmanager.secretAccessor"
gcloud auth list
git clone https://github.com/weimeilin79/agentverse-architect
chmod +x ~/agentverse-architect/init.sh
chmod +x ~/agentverse-architect/set_env.sh
chmod +x ~/agentverse-architect/prepare.sh
chmod +x ~/agentverse-architect/data_setup.sh
git clone https://github.com/weimeilin79/agentverse-dungeon.git
chmod +x ~/agentverse-dungeon/run_cloudbuild.sh
chmod +x ~/agentverse-dungeon/start.sh
cd ~/agentverse-architect
./init.sh
gcloud auth list
git clone https://github.com/weimeilin79/agentverse-architect
chmod +x ~/agentverse-architect/init.sh
chmod +x ~/agentverse-architect/set_env.sh
chmod +x ~/agentverse-architect/prepare.sh
chmod +x ~/agentverse-architect/data_setup.sh
git clone https://github.com/weimeilin79/agentverse-dungeon.git
chmod +x ~/agentverse-dungeon/run_cloudbuild.sh
chmod +x ~/agentverse-dungeon/start.sh
cd ~/agentverse-architect
./init.sh
cd .
cd ..
ls
project_id.txt
rm project_id.txt
cd agentverse-architect/
./init.sh
gcloud config set project $(cat ~/project_id.txt) --quiet
gcloud services enable     sqladmin.googleapis.com     storage.googleapis.com     aiplatform.googleapis.com     run.googleapis.com     cloudbuild.googleapis.com     artifactregistry.googleapis.com     iam.googleapis.com     compute.googleapis.com     cloudresourcemanager.googleapis.com     secretmanager.googleapis.com
. ~/agentverse-architect/set_env.sh
gcloud artifacts repositories create $REPO_NAME     --repository-format=docker     --location=$REGION     --description="Repository for Agentverse agents"
. ~/agentverse-architect/set_env.sh
# --- Grant Core Data Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/storage.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/aiplatform.user"
# --- Grant Deployment & Execution Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/cloudbuild.builds.editor"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/artifactregistry.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/run.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/iam.serviceAccountUser"
gcloud projects add-iam-policy-binding $PROJECT_ID  --member="serviceAccount:$SERVICE_ACCOUNT_NAME"  --role="roles/logging.logWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:${SERVICE_ACCOUNT_NAME}"   --role="roles/monitoring.metricWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:${SERVICE_ACCOUNT_NAME}"   --role="roles/secretmanager.secretAccessor"
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-dungeon
./run_cloudbuild.sh
cd ~/agentverse-architect
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect/
./prepare.sh
cd ~/agentverse-architect/mcp-servers
source ~/agentverse-architect/set_env.sh
echo "The API URL is: $API_SERVER_URL"
# Submit the Cloud Build job from the parent directory
gcloud builds submit .   --config=cloudbuild.yaml   --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_API_SERVER_URL="$API_SERVER_URL"
source ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect
./data_setup.sh
source ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect
./data_setup.sh
source ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect
./data_setup.sh
gcloud services enable     sqladmin.googleapis.com     storage.googleapis.com     aiplatform.googleapis.com     run.googleapis.com     cloudbuild.googleapis.com     artifactregistry.googleapis.com     iam.googleapis.com     compute.googleapis.com     cloudresourcemanager.googleapis.com     secretmanager.googleapis.com
cd ~/agentverse-architect/mcp-servers/db-toolbox
gcloud secrets create tools --data-file=tools.yaml
cd ~/agentverse-architect/mcp-servers/db-toolbox
gcloud secrets create tools --data-file=tools.yaml
cd ~/agentverse-architect/mcp-servers/db-toolbox
. ~/agentverse-architect/set_env.sh
export TOOLBOX_IMAGE=us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:$TOOLBOX_VERSION
echo "TOOLBOX_IMAGE is $TOOLBOX_IMAGE"
gcloud run deploy toolbox     --image $TOOLBOX_IMAGE     --region $REGION     --set-secrets "/app/tools.yaml=tools:latest"     --labels="dev-tutorial-codelab=agentverse"     --args="--tools-file=/app/tools.yaml","--address=0.0.0.0","--port=8080"     --allow-unauthenticated     --min-instances 1
cd ~/agentverse-architect/
python -m venv env
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/mcp-servers
pip install -r diagnose/requirements.txt 
. ~/agentverse-architect/set_env.sh
adk run diagnose
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
echo  DB MCP Server: $DB_TOOLS_URL
echo  API MCP Server: $API_TOOLS_URL
echo  General MCP Server: $FUNCTION_TOOLS_URL
adk web
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
echo  DB MCP Server: $DB_TOOLS_URL
echo  API MCP Server: $API_TOOLS_URL
echo  General MCP Server: $FUNCTION_TOOLS_URL
adk web
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
echo  DB MCP Server: $DB_TOOLS_URL
echo  API MCP Server: $API_TOOLS_URL
echo  General MCP Server: $FUNCTION_TOOLS_URL
adk web
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect/agent
gcloud builds submit .   --config=cloudbuild.yaml   --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_DB_TOOLS_URL="$DB_TOOLS_URL",_API_TOOLS_URL="$API_TOOLS_URL",_FUNCTION_TOOLS_URL="$FUNCTION_TOOLS_URL",_A2A_BASE_URL="$A2A_BASE_URL",_PROJECT_ID="$PROJECT_ID",_API_SERVER_URL="$API_SERVER_URL"
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
pip install -r requirements.txt
adk web
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
adk run earth
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect/agent
gcloud builds submit .   --config=cloudbuild.yaml   --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_DB_TOOLS_URL="$DB_TOOLS_URL",_API_TOOLS_URL="$API_TOOLS_URL",_FUNCTION_TOOLS_URL="$FUNCTION_TOOLS_URL",_A2A_BASE_URL="$A2A_BASE_URL",_PROJECT_ID="$PROJECT_ID",_API_SERVER_URL="$API_SERVER_URL"
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
adk run summoner
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
adk run summoner
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
gcloud builds submit .   --config=cloudbuild-summoner.yaml   --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_FIRE_URL="$FIRE_URL",_WATER_URL="$WATER_URL",_EARTH_URL="$EARTH_URL",_A2A_BASE_URL="$A2A_BASE_URL",_PROJECT_ID="$PROJECT_ID",_API_SERVER_URL="$API_SERVER_URL"
. ~/agentverse-architect/set_env.sh
curl https://summoner-agent"-${PROJECT_NUMBER}.${REGION}.run.app/.well-known/agent.json" | jq
echo https://summoner-agent"-${PROJECT_NUMBER}.${REGION}.run.app"
echo https://agentverse-dungeon"-${PROJECT_NUMBER}.${REGION}.run.app"
git init
git add .
git commit -m 'first commit'
git commit -m "1 commit"
git commit -m "suyash"
git config --global user.email "suyashsaxena015@gmail.com"
git config --global user.name "Suyash Saxena"
git config --list --show-origin | grep -E 'user.name|user.email'
git commit -m "suyash"
git remote add origin https://github.com/Suyashspidy/Agentverse---Google---Startup-Edition.git
git push -u origin main
git add .
git commit -m "initial commit"
git push -u origin main
git branch
git push -u origin master:main
git add .
git init
