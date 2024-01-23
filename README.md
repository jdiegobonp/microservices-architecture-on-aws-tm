# About this project
It was created for learning reasons, and the scope was adopted and the following boilerplate project [Here](https://github.com/hashicorp/microservices-architecture-on-aws) to a schema based on Stack addressed by Terramate. 

# Microservices Architecture on AWS
The following is a foundation of a microservices architecture proposed by Hashicorp. The problem it solves is communication among application components, which is a common challenge in this kind of architecture. This project was taken through a Terramate project, creating a bootstrap and application layer to divide the responsibilities and dependencies in each resource.

## The Architecture
Take a look on [this](https://github.com/hashicorp/microservices-architecture-on-aws/blob/main/images/section-1-architecture.png).

## Getting Started

### Prerequisites
1. Have an AWS Account.
2. Install HashiCorp Terraform (1.7.0) and Terramate (0.4.4).
3. Have the AWS CLI Installed.
4. Create an AWS IAM User with Admin or Power User Permissions.
5. this user will only be used locally
6. Configure the AWS CLI with the IAM User from Step 4.
- Terraform will read your credentials via the AWS CLI
- Other Authentication Methods with AWS and Terraform

### Using this Code Locally
1. Clone this repo to an empty directory.
2. Run `terramate run -- terraform plan` to see what resources will be created.
3. Run `terramate run -- terraform apply` to create the infrastructure on AWS!
4. Open your Consul Server's Load Balancer (output as consul_server_endpoint).
5. Run bash scripts/post-apply.sh and follow the instructions OR open your terraform statefile and copy your Consul Bootstrap Token. Use this to Login to the Consul UI.
- It may take a few moments for all of the services to come on line.
6. Click on Services in the side navigation.
7. Select our "Client" service and then click on the Topology tab.
8. Find the red arrow lines between the client service and the fruits / vegetables services. Click on one of the red arrows to reveal a dialogue box that will ask if you'd like to create an intention. Click Create.
9. Navigate to your Client Application Load Balancer (output as client_alb_dns) to confirm that everything is working.
- It may take a few moments for the new intentions to be recognized.
10. Run `terramate run --reverse terraform destroy` when you're done to get rid of the infrastructure.