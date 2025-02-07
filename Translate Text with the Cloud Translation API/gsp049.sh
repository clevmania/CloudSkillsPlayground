# Create an API key
echo "Creating API KEY..."

gcloud services enable apikeys.googleapis.com

gcloud alpha services api-keys create --display-name="awesome" 

KEY_NAME=$(gcloud alpha services api-keys list --format="value(name)" --filter "displayName=awesome")

API_KEY=$(gcloud alpha services api-keys get-key-string $KEY_NAME --format="value(keyString)")

echo $API_KEY

# Display summary
echo "========================================"
echo "Key created successfully!"
echo "========================================"