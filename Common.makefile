# Helper method for requiring specified executables
#
# EXAMPLE: $(call bin_required,app ls helmfile)
define bin_required
	$(foreach exec,$(1), \
		$(if $(shell which $(exec)),$(), \
			$(error "No $(exec) in PATH")
		) \
	)
endef

define __check_defined
	$(if $(value $1),, \
		$(error Missing required variable `$1`$(if $2, ($2))))
endef

# Require a variable be defined
#
# EXAMPLE: $(call var_required,varname,Description of this required variable)
define var_required
	$(strip $(foreach 1,$1, \
		$(call __check_defined,$1,$(strip $(value 2)))))
endef


# Require a directory exists
#
# EXAMPLE: $(call dir_required,directory_path)
define dir_required
	$(if $(shell ls $1),, \
		$(error Directory "$1" does not exist))
endef
