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


"""
plotIE(S,...)
```julia-repl
julia>PlotIE("H(X,Y)+7H(X1,X2,X3)")

julia>plotIE("I(X;Y)+2I(X;Y|Z)",curves=:false)
```
"""
function plotIE(S;kwargs...)
Z= LinearInformationExpressionToCanonical(S)
p=plot(Meta.parse(Z);kwargs...)
return p
end

"""
PlotInformationExpression(S,...)
```julia-repl
julia>PlotInformationExpression("H(X,Y)+7H(X1,X2,X3)")

julia>PlotInformationExpression("I(X;Y)+2I(X;Y|Z)",curves=:false)
```
"""
function plotInformationExpression(S;kwargs...)
Z= LinearInformationExpressionToCanonical(S)
p=plot(Meta.parse(Z);kwargs...)
return p
end

