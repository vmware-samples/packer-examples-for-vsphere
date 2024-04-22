---
icon: material/gitlab
---

# GitLab CI/CD YAML

## :material-gitlab: Generate a CI/CD YAML

1. Use the `make` command that defines the `update-gitlab-ci` target. This is the simpler option if
   your environment is already set up for it.

      ```shell
      make update-gitlab-ci
      ```

2. Or use `gomplate` directly. This requires you to specify the configuration file (`build.yaml`),
   the template file (`build-ci.tmpl`), and the output file (`.gitlab-ci.yml`).

      ```shell
      gomplate -c build.yaml -f build-ci.tmpl -o .gitlab-ci.yml
      ```

???+ example "Example `.gitlab-ci.yml`"

    ```yaml title=".gitlab-ci.yml" linenums="1"
    --8<-- "./.gitlab-ci.yml"
    ```
