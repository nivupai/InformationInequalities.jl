push!( LOAD_PATH, "../" )
import InformationInequalities  # Import the module to  have access to functions

"""
plotEntropyTree(S,...)
```julia-repl
julia>plotEntropyTree("H(X,Y)+1.2 H(X)+7H(X1,X2,X3)")

julia>plotEntropyTree("H(X,Y)+1H(X1,X2)+3H(X1,X2,X3)",curves=:false,nodecolor=:gold,edgecolor=:gray,nodeshape=:rect,nodesize=0.15)
```
"""
function plotEntropyTree(S;kwargs...)
p=plot(Meta.parse(S);kwargs...)
return p
end