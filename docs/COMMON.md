# Common Methods
The following is an outline of methods defined in [Common.makefile](../Common.makefile) and how they are used:

```Makefile
include github.com/powerhome/makelib/Common.makefile

host=
state=

check:
  # Make sure certain executables are available
  $(call required_bin,app helmfile example)

  # Make sure required variables are set
  $(call required_var,host,You must specify the host variable)
  $(call required_var,state,You must specify the state variable)

modify_host_state:
  example modify_host host=$(host) state=$(state)

```
