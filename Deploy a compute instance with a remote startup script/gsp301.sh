# Colors for output messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to output messages in blue
info_message() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

# Function to output messages in green
success_message() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

# Function to output messages in red
error_message() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# Start of script
info_message "Starting the script..."

gsutil mb gs://$DEVSHELL_PROJECT_ID

gsutil cp gs://sureskills-ql/challenge-labs/ch01-startup-script/install-web.sh gs://$DEVSHELL_PROJECT_ID

gcloud compute instances create quickgcplab --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --machine-type=n1-standard-1 --tags=http-server --metadata startup-script-url=gs://$DEVSHELL_PROJECT_ID/install-web.sh

gcloud compute firewall-rules create allow-http \
    --allow=tcp:80 \
    --description="awesome lab" \
    --direction=INGRESS \
    --target-tags=http-server

# End of script
success_message "All tasks have been completed successfully!"