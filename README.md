# tf-module-dependson

# Repository for learning Terraform OSS
This repository has been created only for learning purposes to try the `depends_on` meta-argument inside the module block Terraform OSS

### Prerequisites

- [X] [Terraform](https://www.terraform.io/downloads)
- [X] [AWS Account](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fportal.aws.amazon.com%2Fbilling%2Fsignup%2Fresume&client_id=signup&code_challenge_method=SHA-256&code_challenge=goaHJzR6L_4316BbJ-3mYe5YqoOcQY7fKzTaPrN2SyA)

## How to Use this Repo

- Clone this repository:
```shell
git clone git@github.com:dlavric/tf-module-dependson.git
```

- Go to the directory where the repo is stored:
```shell
cd tf-module-dependson
```

- Export your AWS credentials in your terminal:
```shell
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=...
```


- Run `terraform init`, to download any external dependency
```shell
terraform init
```


This is the output of initializing the Terraform code:
```shell
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v4.4.0...
- Installed hashicorp/aws v4.4.0 (self-signed, key ID 34365D9472D7468F)
- Installing hashicorp/null v3.1.0...
- Installed hashicorp/null v3.1.0 (self-signed, key ID 34365D9472D7468F)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

- Apply the changes with Terraform
```shell
terraform apply
```

This is the output for applying the changes:
```shell
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.mynull will be created
  + resource "null_resource" "mynull" {
      + id = (known after apply)
    }

  # module.uses-role.aws_iam_role_policy.example will be created
  + resource "aws_iam_role_policy" "example" {
      + id     = (known after apply)
      + name   = "example"
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "ec2:Describe*",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + role   = "andrii-tfe-test-for-ag"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

null_resource.mynull: Creating...
null_resource.mynull: Creation complete after 0s [id=6324281576771717706]
module.uses-role.aws_iam_role_policy.example: Creating...
module.uses-role.aws_iam_role_policy.example: Creation complete after 1s [id=andrii-tfe-test-for-ag:example]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed
```

- Destroy the resources 
```shell
terraform destroy

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # null_resource.mynull will be destroyed
  - resource "null_resource" "mynull" {
      - id = "6324281576771717706" -> null
    }

  # module.uses-role.aws_iam_role_policy.example will be destroyed
  - resource "aws_iam_role_policy" "example" {
      - id     = "andrii-tfe-test-for-ag:example" -> null
      - name   = "example" -> null
      - policy = jsonencode(
            {
              - Statement = [
                  - {
                      - Action   = [
                          - "ec2:Describe*",
                        ]
                      - Effect   = "Allow"
                      - Resource = "*"
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - role   = "andrii-tfe-test-for-ag" -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.uses-role.aws_iam_role_policy.example: Destroying... [id=andrii-tfe-test-for-ag:example]
module.uses-role.aws_iam_role_policy.example: Destruction complete after 1s
null_resource.mynull: Destroying... [id=6324281576771717706]
null_resource.mynull: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
```

## Reference Documentation

- [Terraform depends_on meta-argument](https://www.terraform.io/language/meta-arguments/for_each)

- [Module depends_on](https://www.terraform.io/language/meta-arguments/depends_on)

- [Resource aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)

- [AWS Account and Access Keys](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html)
