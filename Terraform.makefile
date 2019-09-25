# Set terraform flag if variable == 'yes'
define __terraform_set_flag_if_yes
	$(if $(shell echo $(2) | grep -w 'yes'),$(shell echo $(1)),$())
endef

# Set terraform flag if variable != 'yes'
define __terraform_set_flag_if_not_yes
	$(if $(shell echo $(2) | grep -w 'yes'),$(),$(shell echo $(1)))
endef

# Set terraform key/value flag if a variable is set
define __terraform_set_key_value_flag
	$(if $(shell echo $(2)),$(shell echo $(1) $(2)),$())
endef

# Set terraform key=value flag if a variable is set
define __terraform_set_key_eq_flag
	$(if $(shell echo $(2)),$(shell echo $(1)=$(2)),$())
endef

# Set terraform --extra-vars flag(s)
define __terraform_set_extra_vars
	$(strip $(foreach 1,$1, $(shell echo -var '$1')))
endef

# Construct a string of arguments to be passed to terraform
define terraform_construct_args
$(strip \
$(call __terraform_set_key_eq_flag,-target,$(terraform_target)) \
$(call __terraform_set_extra_vars,$(terraform_extra_vars)))
endef
