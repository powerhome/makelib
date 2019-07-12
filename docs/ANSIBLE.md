# Ansible Methods
This is a collection of helper methods used when writing Ansible oriented Makefiles. The following is an outline of methods defined in [Ansible.makefile](../Ansible.makefile) and how they are used:

*NOTE*: See an [example Ansible configuration](#example-configuration) below.

```Makefile
include github.com/powerhome/makelib/Common.makefile
include github.com/powerhome/makelib/Ansible.makefile

# NOTE: Variables show below are optional and do not have to be explicitly defined

# The target host name as defined in your inventory
ansible_host=
# 'yes' or False, run in debug mode
ansible_debug=no
# 'yes' or False, actually apply changes
ansible_apply=no
# 'yes' or False, prompt for a password
ansible_ask_pass=no
# The user to connect with
ansible_ssh_user=
# An SSH private key to try for authentication
ansible_ssh_key=
# Any additional --extra-vars params, space separated
ansible_extra_vars=host=$(ansible_host) @common/secrets.yaml
# Specify an inventory file
ansible_inventory=hosts/APP-Dev

# NOTE: Construct an argument string to pass to ansible
ansible_args=$(call ansible_construct_args)

# Ensure secrets are decrypted prior to running
decrypt: check
	$(call ansible_decrypt,common/secrets.yaml)

# Ensure secrets are encrypted prior to running
encrypt: check
	$(call ansible_encrypt,common/secrets.yaml)

check:
	$(call bin_required,ansible)
	$(call var_required,ansible_host,You must specify the 'ansible_host' variable)

example_task: check decrypt
	ansible-playbook $(ansible_args) playbooks/example-playbook.yaml

```

### Example Configuration
The following is an example configuration that resides in `~/.ansible.cfg`:

```ini
[defaults]
python_interpreter = /usr/bin/env python3
remote_user = root

[ssh_connection]
ssh_args = -i ~/.ssh/id_ansible
```
