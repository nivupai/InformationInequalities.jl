using InformationInequalities
using Documenter
using Plots
using LinearAlgebra
using Random


DocMeta.setdocmeta!(InformationInequalities, :DocTestSetup, :(using InformationInequalities); recursive=true)

makedocs(;
    modules=[InformationInequalities],
    authors="Nivedita Rethnakar et al.",
    repo="https://github.com/nivupai/InformationInequalities.jl/blob/{commit}{path}#{line}",
    sitename="InformationInequalities.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://nivupai.github.io/InformationInequalities.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorials" => [
            "Canonical Decompositions" => "tutorials/canonical.md",
            "Entropic Space" => "tutorials/entropic2d.md"
        ],
        "Explanations" => [
            "Canonical Decomposition" => "explanations/decomposition.md",
            "oXitip: Machine Proof Checker" => "explanations/oxitip.md"
        ],
        "References" => "references.md",
        "Contributing" => "CONTRIBUTING.md"
    ],
)

deploydocs(;
    repo="github.com/nivupai/InformationInequalities.jl",
    devbranch="main",
    push_preview=true
)
