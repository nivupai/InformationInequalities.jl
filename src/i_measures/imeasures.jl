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


"""
    MutualInformation_ElemToCanon(s::String="I(Xi;X🐬|π)")
Convert a mutual information expression s to elemental form.
If `s` is unspecified, it performs a default expression.
##### Examples
```julia-repl
julia> Elemental2Canonical("I(Xi;X🐬|π)")
"H(Xi,π)+H(X🐬,π)-H(Xi,X🐬,π)-H(π)"
```
"""
function Elemental2Canonical_MI(s::String="I(Xi;X🐬|π)")
	s0=replace(s," " =>"")
	if (occursin(r"\|", s0))
		m1=match(r"(I.+;)",s0)
		m2=match(r"(;.+\|)",s0)
		m3=match(r"(\|.+\))",s0)
		a1=replace(m1.captures[1],"I("=>"",";"=>"")
		a2=replace(m2.captures[1],";"=>"","|"=>"")
		a3=replace(m3.captures[1],")"=>"","|"=>"")
	
		P1="H(" * a1* "," * a3 * ")"
		P2="H(" * a2* "," * a3 * ")"
		P3="H(" * a1 * "," * a2 * "," * a3 * ")"
		P4="H(" * a3 * ")"
		C= P1 * "+" * P2 * "-" * P3 * "-" * P4
	else
		m1=match(r"(I.+;)",s0)
		m2=match(r"(;.+\))",s0)
		a1=replace(m1.captures[1],"I("=>"",";"=>"")
		a2=replace(m2.captures[1],";"=>"",")"=>"")
	
		P1="H(" * a1* ")"
		P2="H(" * a2*  ")"
		P3="H(" * a1 * "," * a2 *")"
		C= P1 * "+" * P2  * "-" * P3
	end
	return C
end


"""
Elemental2Canonical_H(s::String="I(Xi;X🐬|π)")
Convert a Entropy or Conditional entropy expression s to elemental form.
If `s` is unspecified, it performs a default expression.
##### Examples
```julia-repl
julia> Elemental2Canonical_H("H(Xi,X🐬|π,γ)")
"H(Xi,X🐬,π,γ)-H(π,γ)"
```
"""
function Elemental2Canonical_H(s::String="H(ρ12|Xπ)")
s0=replace(s," " =>"")
if (occursin(r"\|", s0))
    m = match(r"([H-I]\(.*\|([^\)]*)\))", s0)
    y=replace(m.captures[1], '|' => ',') * "-H($(m.captures[2]))"
else
    y=s
end
return y
end



"""
    Elemental2Canonical(s::String="I(Xi;X🐬|π)")
Convert elemental Information measure to canonical form.
If `s` is unspecified, it performs a default expression.
##### Examples
```julia-repl
julia> Elemental2Canonical("I(Xi;X🐬|π)")
"H(Xi,π)+H(X🐬,π)-H(Xi,X🐬,π)-H(π)"

julia> Elemental2Canonical("H(Xi,X2|π,β)")
"H(Xi,X2,π,β) - H(π,β)"

julia>Elemental2Canonical("I(Xi;X2,ρ,🍎|Zπ,β,🍩)")
"H(Xi,Zπ,β,🍩)+H(X2,ρ,🍎,Zπ,β,🍩)-H(Xi,X2,ρ,🍎,Zπ,β,🍩)-H(Zπ,β,🍩)"
```
"""
function Elemental2Canonical(s::String="I(Xi;X🐬|π)")
	s0=replace(s," " =>"")
	if(startswith(s,"I"))
		C=Elemental2Canonical_MI(s)
	elseif(startswith(s,"H"))
		C=Elemental2Canonical_H(s)
	else
		error("$(s) is an invalid Information measure. Information expression must be of the form H(...) or I(...); e.g. H(Xi,X🐬|π)")
	end
	return C
end




#=
"""
	InformationExpressionToCanonical(F::AbstractString="-2.32I(X;Y|Z1,Z2)")
Convert a single scaled Information measure to its canonnical decomposition form. elemental Information measure to canonical form.
If `F` is unspecified, it performs on a default expression.

##### Examples
```julia-repl
julia> InformationExpressionToCanonical("2.32I(X;Y🍎|Z1,Z2)")
"2.32I(X;Y🍎|Z1,Z2)"

julia> InformationExpressionToCanonical("3H(β😄,Y🍎|Z1,Z2)")
"3H(β😄,Y🍎|Z1,Z2)"
```
"""
=#
function InformationExpressionToCanonical(F::AbstractString="-2.32I(X;Y|Z1,Z2)")
	# Do check and pick only one Iexpr H() or I() with scaling
    
	 kk=match(r"(^[+|-]?[H|I][(])",F)  #Check if starts with bare I() or H(
	if kk != nothing # starts with bare I() or H(
		sExpr=replace(string(F),"-I("=>"I(","-H("=>"H(")
		# sCoef="1"
		# kk.match[1]
		ρ = (kk.match[1]=='-') ? -1 : 1
		
		sCoef = string(ρ)
		 Elemental2Canonical(sExpr)
		# @show sCoef=(kk.match[1]=='-') ? "-1" : "1"
	else
	
	strIH=r"([H|I]+\([\w](.)*[\)])"
	strN=r"([-|+]?[\d]*[\.]?[\d ?]*)"
	Mexp=match(strIH,F)
	Mcoef=match(strN,F)

	sExpr=string(Mexp.captures[1])
	sCoef=string(Mcoef.captures[1])
	scalar=parse(Float64,sCoef)
	end
	CanExpr=Elemental2Canonical(sExpr)
	Z0=replace(CanExpr,"H(" =>sCoef *"H(")
	Z1=replace(Z0,"--"=>"+")
	Z=replace(Z1,"+-"=>"-")
	
	
	return Z
end