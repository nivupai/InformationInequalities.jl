push!( LOAD_PATH, "../" )
import InformationInequalities  # Import the module to  have access to functions

"""
List of Elemental Information measures (EIM) for a given `n` number of random variables. EIM comprise of conditional entropies `H(X1...,Xn|Y1...Ym)` and conditional mutual information `I(X₁...Xₙ;Y₁....Yₘ|Z₁...Zₖ)` measures.

```julia-repl
julia> ElementalMeasures(2)
["H(X1)","H(X1|X2)","H(X2)","H(X2|X1)","I(X1;X2)","I(X2;X1)"]

julia> ElementalMeasures(3,"🐘")
["H(🐘1)"
"H(🐘1|🐘2)"
"H(🐘1|🐘2,🐘3)"
"H(🐘1|🐘3)"
"H(🐘2)"
"H(🐘2|🐘1)"
"H(🐘2|🐘1,🐘3)"
"H(🐘2|🐘3)"
"H(🐘3)"
"H(🐘3|🐘1)"
"H(🐘3|🐘1,🐘2)"
"H(🐘3|🐘2)"
"I(🐘1;🐘2)"
"I(🐘1;🐘2|🐘3)"
"I(🐘1;🐘3)"
"I(🐘1;🐘3|🐘2)"
"I(🐘2;🐘1)"
"I(🐘2;🐘1|🐘3)"
"I(🐘2;🐘3)"
"I(🐘2;🐘3|🐘1)"
"I(🐘3;🐘1)"
"I(🐘3;🐘1|🐘2)"
"I(🐘3;🐘2)"
"I(🐘3;🐘2|🐘1)"]
```
"""
function ElementalMeasures(n::Int64=2,RV::AbstractString="X")
	yI=ConditionalMutualInformation(n,RV)
	yH=ConditionalEntropy(n,RV)
	y=[yH;yI][:]
	return y	
end