push!( LOAD_PATH, "../" )
import InformationInequalities  # Import the module to  have access to functions

"""
List down all conditional Entropy expressions for a given number `n` of random variables. Conditional Entropies are of the form `H(X,Y|Z)` 
```julia-repl
julia> ConditionalEntropyList(2,"🍉")
["H(🍉1)" "H(🍉1|🍉2)" "H(🍉2)" "H(🍉2|🍉1)"]

julia> ConditionalEntropyList(2)
["H(X1)" "H(X1|X2)" "H(X2)" "H(X2|X1)"]

julia> ConditionalEntropyList(3,"dice💠")
["H(dice💠1)"
"H(dice💠1|dice💠2)"
"H(dice💠1|dice💠2,dice💠3)"
"H(dice💠1|dice💠3)"
"H(dice💠2)"
"H(dice💠2|dice💠1)"
"H(dice💠2|dice💠1,dice💠3)"
"H(dice💠2|dice💠3)"
"H(dice💠3)"
"H(dice💠3|dice💠1)"
"H(dice💠3|dice💠1,dice💠2)"
"H(dice💠3|dice💠2)"]
```
"""
function ConditionalEntropyList(m::Int64=2,RV::AbstractString="X")
	y=  [("$(RV)" .* string(i) *  "|" * find_subset(m,i,[],RV)[k]) for i=1:m for k=1:Int64(exp2(m-1)) ]
	y0=replace.(y,"|" => "| ")
	y1=replace.(y0,"| $(RV)" => "|$(RV)")
	y2=replace.(y1,"| " => "")
	yy = "H(" .* y2 .* ")"
	return yy[:]
end