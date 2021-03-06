
![](docs/src/assets/logo1.svg)

| **Pkg Info** | **Build status** | **Documentation** | **Citation** | **Contributing** |
|:------------:|:----------------:|:-----------------:|:------------:|:----------------:|
|![version][ver-img][![license: MIT][mit-img]](LICENSE)|[![CI][ci-img]][ci-url][![codecov][cov-img]][cov-url]|[![docs-stable][stable-img]][stable-url][![docs-dev][dev-img]][dev-url]|[![bibtex][bib-img]][bib-url][![zenodo][doi-img]][doi-url]| [![contributions guidelines][contrib-img]][contrib-url]|


## Overview

This package contains routines to perform Information Theoretic measures. The priliminary build up of this tool is to validate, prove and analyze Information Inequalities. This can be used both for rigorous computations and analysis of Information measures and expressions. 

If you use this package in your work, please cite it as

```
@software{nrethnakar2022,
author = {
            Nivedita Rethnakar and
            Raymond W Yeung
            Suhas Diggavi
         },
title  = {InformationInequalities.jl: Exploring Information Theoretic Inequalities},
month  = {1},
year   = {2022},
doi    = {10.5282/zenodo.5363564},
url    = {https://github.com/nivupai/InformationInequalities.jl}
}
```

## Features

**Note**: The package is still under active development and things evolve quickly (or at least should)

- enclosure of the solution 
- exact characterization of the entropic space
- verified proof and ``\LaTeX`` rendering in display
- enclosure of singularvalues of the entropic space generator matrix
- Further work

## Installation

Open a Julia session and enter

```julia
using Pkg; Pkg.add("InformationInequalities")
```

this will download the package and all the necessary dependencies for you. Next you can import the package with

```julia
using InformationInequalities
```

and you are ready to go.

## Documentation
- [**STABLE**][stable-url] -- Documentation of the latest release
- [**DEV**][dev-url] -- Documentation of the current version on main (work in progress)

The package was also presented at BLA! The theoretical basis for this work is developed by Raymond W Yeung. A related video is available [here](https://youtu.be/QHEV9Ie6spo) and the slides [here](https://youtu.be/QHEV9Ie6spo). Other references are TBD

[![Raymond Yeung 2020 talk](https://img.youtube.com/vi/QHEV9Ie6spo/0.jpg)](https://youtu.be/QHEV9Ie6spo)

## Quickstart

Here is a quick demo example from one of the InformationInequalities function. This shows the canonical decomposition and computational tree.

```julia
using InformationInequalities
using Plots
E="3I(X;Y|Z)+2H(X|Y,Z)"
A=LinearInformationExpressionToCanonical(E)
```
``-H(X,Y,Z) + 3 H(X,Z) + H(Y,Z) - 3 H(Z)``.

To plot an Information expression as a tree graph in Entropy co-ordinates,
```julia
using InformationInequalities
using Plots
E="3I(X;Y|Z)+2H(X|Y,Z)"
A=plotIE(E)
```
![](./docs/src/assets/ex1_gplot.svg)

## Contributing

If you spot something strange in the software (something doesn't work or doesn't behave as expected) do not hesitate to open a [bug issue](https://github.com/InformationInequalities.jl/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5BBUG%5D).

If have an idea of how to make the package better (a new feature, a new piece of documentation, an idea to improve some existing feature), you can open an [enhancement issue](https://github.com/InformationInequalities.jl/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=%5Bfeature+request%5D%3A+). 

If you feel like your issue does not fit any of the above mentioned templates (e.g. you just want to ask something), you can also open a [blank issue](https://github.com/InformationInequalities.jl/issues/new).

Pull requests are also very welcome! More details in the [contributing guidelines](https://nivupai.github.io/InformationInequalities.jl/stable/CONTRIBUTING/)



## References

An excellent introduction to Information Measures is
R W Yeung, TBD, 2019, available [here](https://www.bla.du/xx.pdf)

See also the complete list of [references](https://nivupai.github.io/InformationInequalities.jl/dev/references) for the concepts and algorithms used in this package.

## Related packages

- TBD

## Acknowledgment

The development of this package started during TBD.

[ver-img]: https://img.shields.io/github/v/release/nivupai/InformationInequalities.jl
[mit-img]: https://img.shields.io/badge/license-MIT-yellow.svg

[ci-img]: https://github.com/nivupai/InformationInequalities.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/nivupai/InformationInequalities.jl/actions

[cov-img]: https://codecov.io/gh/nivupai/InformationInequalities.jl/branch/main/graph/badge.svg?token=mgCzKMPiwK
[cov-url]: https://codecov.io/gh/nivupai/InformationInequalities.jl

[stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[stable-url]: https://nivupai.github.io/InformationInequalities.jl/stable

[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://nivupai.github.io/InformationInequalities.jl/dev

[bib-img]: https://img.shields.io/badge/bibtex-citation-green
[bib-url]: ./CITATION.bib

[doi-img]: https://img.shields.io/badge/zenodo-DOI-blue
[doi-url]: https://doi.org/10.5281/zenodo.5363563

[contrib-img]: https://img.shields.io/badge/contributing-guidelines-orange
[contrib-url]: https://nivupai.github.io/InformationInequalities.jl/stable/CONTRIBUTING/

[style-img]: https://img.shields.io/badge/code%20style-blue-4495d1.svg
[style-url]: https://github.com/invenia/BlueStyle

# InformationInequalities

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://nivupai.github.io/InformationInequalities.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://nivupai.github.io/InformationInequalities.jl/dev)
[![Build Status](https://github.com/nivupai/InformationInequalities.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/nivupai/InformationInequalities.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/nivupai/InformationInequalities.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/nivupai/InformationInequalities.jl)
