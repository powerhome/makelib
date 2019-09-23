# Common Methods
The following is an outline of methods defined in [Common.makefile](../Common.makefile) and how they are used:

```Makefile
include github.com/powerhome/makelib/Common.makefile

host=
state=

check:
  # Make sure certain executables are available
  $(call bin_required,app helmfile example)

  # Make sure required variables are set
  $(call var_required,host,You must specify the host variable)
  $(call var_required,state,You must specify the state variable)

  # Make sure a directory exists (can be relative or absolute)
  $(call dir_required,my/required/path)
  $(call dir_required,/my/absolute/path)

  # Make sure a file exists (can be relative or absolute)
  $(call file_required,my/relative/file.yaml)
  $(call file_required,/my/absolute/file.yaml)

modify_host_state:
  example modify_host host=$(host) state=$(state)

```
