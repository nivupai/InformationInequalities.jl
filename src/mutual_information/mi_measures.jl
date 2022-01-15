push!( LOAD_PATH, "../" )
import InformationInequalities  # Import the module to  have access to functions

"""
List all conditional Mutual Information expressions for a given number `n` of random variables. Conditional Entropies are of the form `I(X;Y|Z)` aka Mutual information between `X` and `Y` given `Z`. 
```julia-repl
julia> ConditionalMutualInformationList(2,"🍉")
["I(🍉1;🍉2)" "I(🍉2;🍉1)"]
julia> ConditionalMutualInformationList(3)
["I(X1;X2)","I(X1;X2|X3)","I(X1;X3)","I(X1;X3|X2)","I(X2;X1)","I(X2;X1|X3)","I(X2;X3)","I(X2;X3|X1)","I(X3;X1)","I(X3;X1|X2)","I(X3;X2)","I(X3;X2|X1)"]
```
"""
function ConditionalMutualInformationList(m::Int64=2,RV::AbstractString="X")
	y=  [("$(RV)" .* string(i) * ";" * "$(RV)" .* string(j) * "|" * find_subset(m,i,j,RV)[k]) for i=1:m for j =setdiff(1:m,i) for k=1:Int64(exp2(m-2)) ]
	y0=replace.(y,"|" => "| ")
	y1=replace.(y0,"| $(RV)" => "|$(RV)")
	y2=replace.(y1,"| " => "")
	yy = "I(" .* y2 .* ")"
	return yy[:]
end