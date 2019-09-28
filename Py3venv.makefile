include github.com/powerhome/makelib/Common.makefile

venv=venv
__stderr=&> /dev/stderr

python3=$(venv)/bin/python3
pip3=$(venv)/bin/pip3

define __python3_ensure_bins
	$(call bin_required,python3)
	$(call bin_required,virtualenv)
endef

# Ensure a Python3 virtual environment exists
define python3_ensure_venv
	$(call __python3_ensure_bins)
	$(if $(shell if [ ! -d $(venv) ]; then echo "."; else echo ""; fi), \
 		$(shell \
			echo "Initializing Python3 virtual environment..." $(__stderr); \
			virtualenv -p python3 $(venv) $(__stderr)), \
 		$(shell echo "Discovered Python3 virtual environment..." $(__stderr)))

	$(shell echo "venv: python3 -> ${python3}" $(__stderr))
	$(shell echo "venv: pip3 -> ${pip3}" $(__stderr))
	$(shell if [ ! -z "${python3_requirements}" ]; then $(pip3) install -r $(python3_requirements) $(__stderr); else true; fi)
endef
