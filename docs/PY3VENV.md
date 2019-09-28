# Python3 Virtual Environment Methods
This is a collection of helper methods used when writing Makefiles that need a Python3 virtual environment. The following is an outline of methods defined in [Py3venv.makefile](../Py3venv.makefile) and how they are used:

```Makefile
include github.com/powerhome/makelib/Py3venv.makefile

# Automatically install requirements file
python3_requirements=requirements.txt

# Define custom executable paths
ansible_playbook=$(venv)/bin/ansible-playbook

check:
	$(call python3_ensure_venv)

  @echo $(python3) # This will be `venv/bin/python3`
  @echo $(pip3) # This will be `venv/bin/pip3`

run_script:
  $(python3) my/script.py

install_modules:
  $(pip3) install kubernetes

run_ansible:
  $(ansible_playbook) --check my/playbook.yaml

```

### Requirements
You must have `python3` and `python3-virtualenv` installed on the machine. For example:

```sh
# On OSX
$ brew install python
$ pip3 install virtualenv
$ which python3
$ which virtualenv
```

### Constructing the Virtual Environment
When calling `python3_ensure_venv`, if the `./venv` directory does not exist, it will be created using `virtualenv -p python3 venv`. This will automatically set the following variables in your main Makefile:

 - `$(python3)`: Call the Python3 executable in the virtual environment
 - `$(pip3)`: Call the Pip3 executable in the virtual environment
 - `$(venv)`: The base directory of the virtual environment if you want to define your own executable paths
