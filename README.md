# Powerhome MakeLib
This repository is designed to contain external libraries to be imported as a Git submodule, to provide helper functions while writing Makefiles. Consider this repo as experimental. This currently only includes two helper functions, with the goal of putting any custom `make` functions here for importing in other repositories, rather then duplicating code.

#### [**Documentation**](docs/README.md)
You can [read the docs](docs/README.md) to get a better understanding of how to use this library.

### Using as a Submodule
The following is an example of how to include this repository as a submodule in your project:

```sh
$ cd my-git-project
$ git submodule add git@github.com:powerhome/makelib.git github.com/powerhome/makelib
```

This will add the repository into `github.com/powerhome/makelib`. Using `github.com/powerhome` as the parent folder will make it easier to recognize when you are working with an external PowerHRG project imported as a subproject. You can add this to any path you like, just replace `github.com/powerhome/makelib` in the above to command to whatever path you want relative to your repository.

#### Using a Specific Branch
If you would like to test a development branch of this repository, you can modify your `.gitmodules` configuration file:

```
[submodule "github.com/powerhome/makelib"]
    path = github.com/powerhome/makelib
    url = git@github.com:powerhome/makelib.git
    branch = my_development_branch
```

You can then update your local copy by running:

```
$ git submodule update --recursive --remote
```
