# Contributing Guidelines

Thank you for your interest in contributing to our project. Whether it's a bug report, new feature,
correction, or additional documentation, we greatly value feedback and contributions from our
community.

Please read through this document before submitting any issues or pull requests to ensure we have
all the necessary information to effectively respond to your bug report or contribution.

## Reporting Bugs and Suggesting Enhancements

We welcome you to use the [GitHub issues][gh-issues] to report bugs or suggest enhancements.

When filing an issue, please check existing open, or recently closed, issues to make sure someone
else hasn't already reported.

Please try to include as much information as you can using the issue fo. Details like these are
incredibly useful:

- A reproducible test case or series of steps.
- Any modifications you've made relevant to the bug.
- Anything unusual about your environment or deployment.

## Contributing via Pull Requests

Contributions using pull requests are appreciated.

**Before** sending us a pull request, please ensure that:

1. You [open a discussion][gh-discussions] to discuss any significant work with the maintainer(s).
2. You [open an issue][gh-issues] and link your pull request to the issue for context.
3. You are working against the latest source on the `develop` branch.
4. You check existing open, and recently merged, pull requests to make sure someone else hasn't
   already addressed the problem.

To open a pull request, please:

1. Fork the repository.
2. Modify the source; please focus on the **specific** change you are contributing.
3. Ensure local tests pass.
4. Updated the documentation, if required.
5. Sign-off and commit to your fork [using a clear commit messages][git-commit]. Please use
   [Conventional Commits][conventional-commits].
6. Open a pull request, answering any default questions in the pull request.
7. Pay attention to any automated failures reported in the pull request, and stay involved in the
   conversation.

GitHub provides additional document on [forking a repository][gh-forks] and [creating a pull request][gh-pull-requests].

### Contributor Flow

This is an outline of the contributor workflow:

- Create a topic branch from where you want to base your work.
- Make commits of logical units.
- Make sure your commit messages are [in the proper format][conventional-commits] **and** are signed-off.
- Push your changes to the topic branch in your fork.
- Submit a pull request. If the pull request is a work in progress, please open as draft.

> [!IMPORTANT]
> This project **requires** that commits are signed-off for the [Developer Certificate of Origin][dco].

Example:

```shell
git remote add upstream https://github.com/<org-name>/<repo-name>.git
git checkout --branch feat/add-x develop
git commit --signoff --message "feat: add support for x
  Added support for x.

  Signed-off-by: Jane Doe <jdoe@example.com>

  Ref: #123"
git push origin feat/add-x
```

### Formatting Commit Messages

We follow the conventions on [How to Write a Git Commit Message][git-commit] and [Conventional Commits][conventional-commits].

Be sure to include any related GitHub issue references in the commit message.

Example:

```markdown
feat: add support for x

Added support for x.

Signed-off-by: Jane Doe <jdoe@example.com>

Ref: #123
```

### Staying In Sync With Upstream

When your branch gets out of sync with the `vmware-samples/develop` branch, use the following to
update:

```shell
git checkout feat/add-x
git fetch --all
git pull --rebase upstream develop
git push --force-with-lease origin feat/add-x
```

### Updating Pull Requests

If your pull request fails to pass or needs changes based on code review, you'll most likely want to
squash these changes into existing commits.

If your pull request contains a single commit or your changes are related to the most recent commit,
you can simply amend the commit.

```shell
git add .
git commit --amend
git push --force-with-lease origin feat/add-x
```

If you need to squash changes into an earlier commit, you can use:

```shell
git add .
git commit --fixup <commit>
git rebase --interactive --autosquash develop
git push --force-with-lease origin feat/add-x
```

Be sure to add a comment to the pull request indicating your new changes are ready to review, as
GitHub does not generate a notification when you `git push`.

## Finding Contributions to Work On

Looking at the existing issues is a great way to find something to contribute on. If you have an
idea you'd like to discuss, [open a discussion][gh-discussions].

## Licensing

See the [LICENSE][license] file for our project's licensing. We will ask you to confirm the
licensing of your contribution.

We may ask you to sign a [Contributor License Agreement (CLA)][cla]
for larger changes.

[cla]: http://en.wikipedia.org/wiki/Contributor_License_Agreement
[dco]: https://probot.github.io/apps/dco/
[conventional-commits]: https://conventionalcommits.org
[gh-discussions]: https://github.com/vmware-samples/packer-examples-for-vsphere/discussions
[gh-forks]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo
[gh-issues]: https://github.com/vmware-samples/packer-examples-for-vsphere/issues
[gh-markdown]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github
[gh-pull-requests]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request
[git-commit]: https://cbea.ms/git-commit
[license]: LICENSE
