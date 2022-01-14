# InformationInequalities.jl contribution guidelines

First of all, huge thanks for your interest in the package! ✨

This page has some hopefully useful guidelines. If this is your first time contributing, please read the [pull request-workflow](#Pull-request-workflow) section, mainly to make sure everything works smoothly and you don't get stuck with some nasty technicalities. 

You are also encouraged to read the coding and documentation guidelines, but you don't need to deeply study and memorize those. Core developers are here to help you. Most importantly, relax and have fun!


## Opening issues

If you spot something strange in the software (something doesn't work or doesn't behave as expected) do not hesitate to open a [bug issue](https://github.com/InformationInequalities.jl/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5BBUG%5D).

If have an idea of how to make the package better (a new feature, a new piece of documentation, an idea to improve some existing feature), you can open an [enhancement issue](https://github.com/InformationInequalities.jl/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=%5Bfeature+request%5D%3A+). 

In both cases, try to follow the template, but do not worry if you don't know how to fill something. 

If you feel like your issue does not fit any of the above mentioned templates (e.g. you just want to ask something), you can also open a [blank issue](https://github.com/InformationInequalities.jl/issues/new).

## Pull request workflow

Pull requests are also warmly welcome. For small fixes/additions, feel free to directly open a PR. For bigger more ambitious PRs, it is preferable to open an issue first to discuss it. As a rule of thumb, every pull request should be as atomic as possible (fix one bug, add one feature, address one issue).

### Setup

!!! note
    This is just one way, you can do differently (e.g. clone your fork and add the original repo as `upstream`). In that case, make sure to use the correct remote names

This is something that needs to be done only once, the first time you start contributing

**1.** From the Julia REPL in package mode (you can enter package mode by typing `]`) do

```julia
pkg> dev InformationInequalities
```
