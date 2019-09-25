# Terraform Methods
This is a collection of helper methods used when writing Terraform oriented Makefiles. The following is an outline of methods defined in [Terraform.makefile](../Terraform.makefile) and how they are used:

```Makefile
include github.com/powerhome/makelib/Common.makefile
include github.com/powerhome/makelib/Terraform.makefile

# NOTE: Variables show below are optional and do not have to be explicitly defined

# The local project directory containing your configs: i.e., terraform/jenkins
terraform_project=
# A target resource in a project to manage
terraform_target=module.server-name
# Additional variables to pass via: -var var1=var1 -var var2=val2
terraform_extra_vars="var1=val1 var1=var2"

# NOTE: Construct an argument string to pass to terraform
terraform_args=$(call terraform_construct_args)

check:
	$(call bin_required,terraform)

	# Must specify which directory of Terraform configs to target
	$(call var_required,terraform_project,You must specify which project to manage)

	# Make sure the target project exists
	$(call dir_required,$(terraform_project))

	# Make sure the target has a `variables.tf` file
	$(call file_required,$(terraform_variables))

plan: check

	# Get any required modules
	cd $(terraform_project) && terraform get

	# Make the plan
	cd $(terraform_project) && terraform plan $(terraform_args)

apply: check
	cd $(terraform_project) && terraform apply $(terraform_args)

destroy: check
	# NOTE: This will prompt the user before actually destroying
	cd $(terraform_project) && terraform destroy $(terraform_args)

```
