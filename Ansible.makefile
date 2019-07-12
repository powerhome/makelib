define __ansible_decrypt
	ansible-vault \
	$(call __ansible_set_key_value_flag,--vault-password-file,$(ansible_vault_passfile)) \
	decrypt $(1)
endef

define __ansible_encrypt
	ansible-vault \
	$(call __ansible_set_key_value_flag,--vault-password-file,$(ansible_vault_passfile)) \
	encrypt $(1)
endef

# Decrypt secrets file if not decrypted
define ansible_decrypt
	$(if $(shell head -1 $(1) | grep '$ANSIBLE_VAULT;'),$(call __ansible_decrypt,$(1)),$())
endef

# Encrypt secrets file if not encrypted
define ansible_encrypt
	$(if $(shell head -1 $(1) | grep '$ANSIBLE_VAULT;'),$(),$(call __ansible_encrypt,$(1)))
endef

# Set ansible flag if variable == 'yes'
define __ansible_set_flag_if_yes
	$(if $(shell echo $(2) | grep -w 'yes'),$(shell echo $(1)),$())
endef

# Set ansible flag if variable != 'yes'
define __ansible_set_flag_if_not_yes
	$(if $(shell echo $(2) | grep -w 'yes'),$(),$(shell echo $(1)))
endef

# Set ansible key/value flag if a variable is set
define __ansible_set_key_value_flag
	$(if $(shell echo $(2)),$(shell echo $(1) $(2)),$())
endef

# Set ansible --extra-vars flag(s)
define __ansible_set_extra_vars
	$(strip $(foreach 1,$1, $(shell echo --extra-vars $1)))
endef

# Construct a string of arguments to be passed to ansible
define ansible_construct_args
$(strip \
$(call __ansible_set_key_value_flag,-i,$(ansible_inventory))
$(call __ansible_set_flag_if_not_yes,--check,$(ansible_apply)) \
$(call __ansible_set_flag_if_yes,-vvvv,$(ansible_debug)) \
$(call __ansible_set_flag_if_yes,-K,$(ansible_ask_pass)) \
$(call __ansible_set_key_value_flag,--key-file,$(ansible_ssh_key)) \
$(call __ansible_set_key_value_flag,-u,$(ansible_ssh_user)) \
$(call __ansible_set_key_value_flag,--vault-password-file,$(ansible_vault_passfile)) \
$(call __ansible_set_extra_vars,$(ansible_extra_vars)))
endef
