---
icon: lucide/git-pull-request
---

# Contributing Guidelines

We greatly value feedback and contributions from our community.

Please review this document before submitting any issues or pull requests to ensure we have all the
necessary information to effectively collaborate on your contribution.

--8<-- "docs/community/issues-guidance.md"

## Pull Requests

Use GitHub pull requests to propose changes to the project using the following guidelines.

!!! warning

    Pull requests that do not follow the guidelines may be closed by the maintainers
    without further review.

**Before** submitting a pull request, ensure that:

1. You have [opened a discussion][gh-discussions] to discuss any **significant** work with
   the maintainer(s). This ensures that your contribution is aligned with the
   project's direction and avoids unnecessary work.
2. You have identified or [opened an issue][gh-issues]. This ensures that your contribution
   focuses on a specific topic and avoids duplicating effort.
3. You have forked the repository. Refer to the [GitHub documentation][gh-forks] for help.
4. You are working against the latest source on the `develop` branch. You may need to
   rebase your branch against the latest `develop` branch.
5. You have created a topic branch based on `develop`. Do not work directly on the
   `develop` branch.
6. You have modified the source in logical units of work focused on the specific change
   you are contributing.
7. You have followed the existing style and conventions of the project.
8. You have updated the documentation when required.
9. You have run `make docs-build` when changing documentation.
10. You have validated the affected templates and tested representative image builds.
11. You have used [Conventional Commits][conventional-commits] format for commit messages.
12. You have signed off and committed your changes [using clear commit messages][git-commit].

When opening a pull request, ensure that:

1. You title your pull request using the [Conventional Commits][conventional-commits] format.
2. You provide a detailed description of the changes in the pull request template.
3. You open any work-in-progress pull requests as a draft.
4. You mark the pull request as ready for review when it is ready to be reviewed.
5. You follow the status checks for the pull request to ensure that all checks are passing.
6. You stay involved in the conversation with the maintainers.

!!! tip

    If you have any questions about the contribution process, open a [discussion][gh-discussions].

## Contributor Flow

This is an outline of the contributor workflow:

```shell
git remote add upstream https://github.com/vmware/packer-examples-for-vsphere.git
git checkout -b feat/add-x develop
git commit --signoff --message "feat: add support for x
  Added support for x.

  Signed-off-by: Jane Doe <jdoe@example.com>

  Ref: #123"
git push origin feat/add-x
```

### Formatting Commit Messages

Follow the conventions on [How to Write a Git Commit Message][git-commit] and use
[Conventional Commits][conventional-commits].

Be sure to include any related GitHub issue references in the commit message.

```markdown
feat: add support for x

Added support for x.

Signed-off-by: Jane Doe <jdoe@example.com>

Ref: #123
```

### Stay In Sync With Upstream

When your branch gets out of sync with the `upstream/develop` branch, use the
following commands to update it:

```shell
git checkout feat/add-x
git fetch --all
git pull --rebase upstream develop
git push --force-with-lease origin feat/add-x
```

### Updating Pull Requests

If your pull request fails to pass or needs changes based on code review, you will
most likely want to squash these changes into existing commits.

If your pull request contains a single commit or your changes are related to the
most recent commit, you can amend the commit:

```shell
git add .
git commit --amend
git push --force-with-lease origin feat/add-x
```

If you need to squash changes into an earlier commit, use:

```shell
git add .
git commit --fixup <commit>
git rebase --interactive --autosquash upstream/develop
git push --force-with-lease origin feat/add-x
```

When resolving review comments, mark the conversation as resolved and note the commit
SHA that addresses the review comment. This helps maintainers verify the issue has been
resolved.

Request a review from the maintainers when you are ready for a follow-up review.

[conventional-commits]: https://conventionalcommits.org
[gh-discussions]: https://github.com/vmware/packer-examples-for-vsphere/discussions
[gh-forks]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo
[gh-issues]: https://github.com/vmware/packer-examples-for-vsphere/issues
[git-commit]: https://cbea.ms/git-commit
