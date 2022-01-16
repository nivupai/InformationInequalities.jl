module InformationInequalities
using Combinatorics
using Plots
using LinearAlgebra
using Graphs
using GraphRecipes
using LaTeXStrings
# Write your package code here.


include("utils/utils.jl")
include("entropy/entropies.jl")
include("mutual_information/mi_measures.jl")
include("i_measures/imeasures.jl")
include("visualization/ploting.jl")

export ConditionalEntropyList
export ConditionalMutualInformationList
export ElementalMeasures
export Elemental2Canonical
export Elemental2Canonical_H
export Elemental2Canonical_MI
export InformationExpressionToCanonical
export LinearInformationExpressionToCanonical

export entropic_matrix
export find_matrixG
export find_entropic_vector
export unique_entropy_vector
export entropy_vector
export find_entropic_vector
export find_entropic_vector_int

export minimal_EIM_list_canonical
export order_entropic
export order_entropic_expression


export plotEntropyTree
export GeometryConeGamma2
export elementsGamma2



export order_string
export find_subset
export order_entropic1
export numEIM



end
