dunnHumby Hiring Challenge (DevOps Engineer)
=======================================================================

As mentioned in the Challenge, I have created the same infrastructure deployment, that will perform all the tasks mentioned in the Challenge.

I have divided the whole infrastructure into 4 different modules to make it easier for us to maintain, and also, if in the future, we need to update any rules or settings in it then we can do it easily.

And before proceeding further, I request you to watch attached video first for better and clear understanding of all modules, requirements and use cases.

----->  Contents of this README file  <-----

1. Understanding the Modules
2. Requirements to run the Terraform Script
3. How to run the Terraform Script?

=======================================================================
1. Understanding the Modules (Video 00:25 - 04:05):
=======================================================================
As I mentioned earlier that, I have divided the whole infrastructure into 4 different modules. Let us now go through each of them briefly to see what function they will perform.

For better understanding please watch the attached video

=======================================================================

a.	Network Module (Video 00:25 - 01:35)

    •	Create the Virtual Private Cloud (VPC) and the subnetwork. 

    •	Add firewall rules, so we can connect with our Virtual Machine via SSH Protocol and connect with our webserver.

    •	Health Check for port 8080

    •	Storing the ID of VPC and the Subnet in output variables so other modules can use it.

b.	Roles Module (Video 01:35 - 02:15)

    •	Create a custom role that only has access to read and write to the bucket.

    •	Create a Service Account on runtime (dynamically) and bind this service account with the custom role created above.

c.	Bucket Module (Video 02:15 - 02:35)

    •	This module will create a bucket with the provided name in the provided region

d.	Instance Module (Video 02:35 - 04:05)

    •	Create a Compute Instance (VM) within the provided VPC and the subnetwork

    •	Allow VM to access read and write to the bucket

    •	Run a start-up script to configure the docker, launch the container and expose it on port 8080.


=======================================================================

=======================================================================
2.  Requirements to run the Terraform Script (Video 04:10 - 06:00):
=======================================================================

a. Enable all the 6 APIs in your GCP account (Video 04:15 - 04:30):

    •	Compute Engine API

    •	Cloud Vision API

    •	Cloud Logging API

    •	Identity and Access Management (IAM) API

    •	Cloud Resource Manager API

    •	Service Usage API

    o	Links for enabling these API's

        https://console.cloud.google.com/apis/api/compute.googleapis.com/

        https://console.cloud.google.com/apis/api/vision.googleapis.com/

        https://console.cloud.google.com/apis/api/logging.googleapis.com/

        https://console.cloud.google.com/apis/api/iam.googleapis.com/

        https://console.cloud.google.com/apis/api/cloudresourcemanager.googleapis.com/

        https://console.cloud.google.com/apis/api/serviceusage.googleapis.com/


b.	Key to the service account that has access to all of the above APIs (Video 04:30 - 05:30):

    • Give the path of the key, in the variables file (vars.tf) of the main module.

        o Replace the value of default with your key path
        
        # Credential of the Owner or the User or the Service Account who will run the script
        variable "credentials" {
            type = string
            default = "path/to/key"     -----------------> Replace with your key path
            description = "Provide the path to your key if it is in different directory"
        }

    

    ├── cred
│   └── key.json    -----------------> Key file
├── main   -----------------> This is the main module 
│   ├── main.tf
│   ├── readme.txt
│   ├── script.sh
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── vars.tf     -----------------> Main variables file, inside this file you have to mention your key with full path.
└── module
    ├── bucket
    │   ├── bucket.tf
    │   └── vars.tf
    ├── instance
    │   ├── instance.tf
    │   └── vars.tf
    ├── network
    │   ├── network.tf
    │   ├── output.tf
    │   └── vars.tf
    └── roles
        ├── output.tf
        ├── roles.tf
        └── vars.tf


c.	Project ID (Video 05:30 - 05:45):

    • Replace the Project ID, in the variables file (vars.tf) of the main module.

        o Replace the value of default with your project_id

        # Project ID inside which the whole Infrastructure will Created
        variable "project_id" {
            type = string
            default = "PROJECT_ID"      -----------------> Replace with your project_id
            description = "Id of the project"
        }

=======================================================================

=======================================================================
3.  How to run the Terraform Script (Video 06:05 - 06:45)?
=======================================================================

    • Unzip the dunnHumby.zip, open the terminal and go inside our main module folder (cd Dunnhumby/main/) 
      and here type the command:

        CMD: terraform init

        This command will initialize the terraform inside your directory

    • To check that, if any syntax error is present or not in your scripts

        CMD: terraform validate

    • To check that all modules working or not

        CMD: terraform plan



    • And if any error is not present in the scripts then run the following command:

        --> Please fufill all the requirements mentioned in step 2 (Requirements to run the Terraform Script)
    
        CMD: terraform apply -auto-approve

        o When the deployment is complete, it will install the docker, pull the image and launch the container, so please wait for at least 30 - 40 seconds before connecting to the webserver.

        o Please wait for 10 seconds after rebooting the instance, so that it can start all services.



    • And to delete the whole deployment type the command

        CMD: terraform destroy -auto-approve

=======================================================================
