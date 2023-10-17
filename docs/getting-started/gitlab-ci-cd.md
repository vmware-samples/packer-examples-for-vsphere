---
icon: material/gitlab
---

# GitLab CI/CD YAML

## :material-gitlab: Generate a CI/CD YAML

The GitLab CI/CD YAML (`.gitlab-ci.yml`) can be generated with Gomplate using a template (`./build-ci.tmpl`) and a configuration file in YAML (`./build.yaml`).

```shell
gomplate -c build.yaml -f build-ci.tmpl -o .gitlab-ci.yml
```

or

```shell
make update-gitlab-ci
```

???- example "Example `.gitlab-ci.yml`"
    ```yaml title=".gitlab-ci.yml" linenums="1"
    --8<-- "./.gitlab-ci.yml"
    ```
