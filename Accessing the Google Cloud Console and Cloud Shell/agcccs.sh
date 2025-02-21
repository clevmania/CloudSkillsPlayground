# Create a storage bucket
gcloud auth list
export REGION="${ZONE%-*}"

echo "Creating A Bucket"
gsutil mb -l $REGION gs://$DEVSHELL_PROJECT_ID

gsutil uniformbucketlevelaccess set off gs://$DEVSHELL_PROJECT_ID

# Create a virtual machine
echo "Creating A Virtual Machine"
gcloud compute instances create first-vm --zone=$ZONE --project=$DEVSHELL_PROJECT_ID --machine-type=e2-micro --tags=http-server


# Create a service account
echo "Creating A Service Account"

gcloud iam service-accounts create test-service-account --display-name="test-service-account"
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/editor

export REGION="${ZONE%-*}"

gcloud storage buckets create gs://$DEVSHELL_PROJECT_ID-clevmmania --location=$REGION

gcloud compute zones list | grep $REGION

gcloud config set compute/zone $ZONE

MY_VMNAME=second-vm

gcloud compute instances create $MY_VMNAME \
--machine-type "e2-standard-2" \
--image-project "debian-cloud" \
--image-family "debian-11" \
--subnet "default"

gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"


gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer


gsutil cp gs://cloud-training/ak8s/cat.jpg cat.jpg

gsutil cp cat.jpg gs://$DEVSHELL_PROJECT_ID

gsutil cp gs://$DEVSHELL_PROJECT_ID/cat.jpg gs://$DEVSHELL_PROJECT_ID-clevmmania/cat.jpg

gsutil acl get gs://$DEVSHELL_PROJECT_ID/cat.jpg  > acl.txt
cat acl.txt

gsutil acl set private gs://$DEVSHELL_PROJECT_ID/cat.jpg

gsutil acl get gs://$DEVSHELL_PROJECT_ID/cat.jpg  > acl-2.txt
cat acl-2.txt

gcloud auth activate-service-account --key-file credentials.json

gsutil cp gs://$DEVSHELL_PROJECT_ID/cat.jpg ./cat-copy.jpg

gsutil cp gs://$DEVSHELL_PROJECT_ID-clevmmania/cat.jpg ./cat-copy.jpg

gcloud config set account $USER_ID

gsutil cp gs://$DEVSHELL_PROJECT_ID/cat.jpg ./copy2-of-cat.jpg

gsutil iam ch allUsers:objectViewer gs://$DEVSHELL_PROJECT_ID