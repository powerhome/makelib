# MakeLib
This repository is designed to contain external libraries to be imported as a Git submodule, to provide helper functions while writing Makefiles. Consider this repo as experimental. This currently only includes two helper functions, with the goal of putting any custom `make` functions here for importing in other repositories, rather then duplicating code.

### Using as a Submodule
The following is an example of how to include this repository as a submodule in your project:

```sh
$ cd my-git-project
$ git submodule add git@github.com:powerhome/makelib.git github.com/powerhome/makelib
```

This will add the repository into `github.com/powerhome/makelib`. Using `github.com/powerhome` as the parent folder will make it easier to recognize when you are working with an external PowerHRG project imported as a subproject. You can add this to any path you like, just replace `github.com/powerhome/makelib` in the above to command to whatever path you want relative to your repository.

### Helper Functions
The following are the helper functions defined in `Common.makefile` and how they are used:

```Makefile
include github.com/powerhome/makelib/Common.makefile

some_required_var=
another_required_var=

# Run checks before `do_something`
check_something:
  $(call var_required,some_required_var,This variable is required and will exit if not defined)
  $(call bin_required,my_app my_job) # This must exist in PATH or else it will fail

# Run checks before `do_another_thing`
check_another_thing:
  $(call var_required,another_required_var,This variable is required here)
  $(call bin_required,my_other_app)

# Run checks before actually doing something
do_something: check_something
  /usr/bin/my_app $(some_required_var)
  /usr/bin/my_job $(some_required_var)

# Run checks before actually doing another thing
do_another_thing: check_another_thing
  /usr/bin/my_other_app $(another_required_var)

```
