using InformationInequalities
using Documenter

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
    ],
)

deploydocs(;
    repo="github.com/nivupai/InformationInequalities.jl",
    devbranch="main",
)
