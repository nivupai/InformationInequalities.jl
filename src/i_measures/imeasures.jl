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
	yI=ConditionalMutualInformationList(n,RV)
	yH=ConditionalEntropyList(n,RV)
	y=[yH;yI][:]
	return y	
end

"""
For a given number `n` of random variables, list down the maximum number of elemental information measures in minimal canonical form. 
```julia-repl
julia> u,v,m,n=numEIM(2)
```
"""
function numEIM(n::Int64=2)
	~,~,k,l=minimal_EIM_list_canonical(n)
	return k,l
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


"""
LinearInformationExpressionToCanonical(A)
```julia-repl
julia>LinearInformationExpressionToCanonical("I(X;Y|Z)-2.3H(U,V)-2H(u)")
"1H(X,Z)+1H(Y,Z)-1H(X,Y,Z)-1H(Z)-2.3H(U,V)-2H(u)"
```
"""
function LinearInformationExpressionToCanonical(A)
    A1=replace(A,"-"=>"+-","+I("=>"+1I(","-I("=>"+-1I(","+H("=>"+1H(","-H("=>"+-1H(")
    A2=split.(A1,"+")
    A3=InformationExpressionToCanonical.(A2)
	# A4=prod(A3) 
	A4=""
	for ii=1:length(A3)
		A4= A4 * "+" * A3[ii]
	end
	A5=replace(A4,"+-"=>"-")
	return A5
end



"""
For a given number `n` of random variables, list down all the elemental information measures and their corresponding entropic decompositions. The entropic vectors are identified with the prefix `h` and follows lexicographic mapping. e.g., `H(X1,X3,X7)=h137`. Note that, for now this lexicographic mapping works only for `n < 10`.  
"""
function entropy_vector(n::Int64,RV::AbstractString="X")
	X=Elemental2Canonical.(ElementalMeasures(n,RV))
	Y=sort(replace.(X,","=>"","X"=>"",")"=>"","("=>"","H"=>"h"))
	return Y
end

"""
For a given number `n<10` of random variables, list down all the unique elemental information measures and their corresponding entropic decompositions. The entropic vectors are identified with the prefix `h` and follows lexicographic mapping. e.g., `H(X1,X3,X7)=h137`. Note that, for now this lexicographic mapping works only for `n < 10`.  
"""
function unique_entropy_vector(n::Int64=3)
    EMeasures=Elemental2Canonical.(ElementalMeasures(n))
    EMnumber=(replace.(EMeasures,","=>"","X"=>"",")"=>"","("=>"","H"=>"","+"=>",","-"=>","))
    y=[];
    for kk in 1:length(EMnumber)
        y=[y;"h" .* unique(sort(join.(sort.(digits.(parse.(Int64,split(EMnumber[kk],",")))))))]
    end
    Hfull=y;
    Hminimal = unique(Hfull)
    return EMeasures,Hfull,Hminimal
end


function find_entropic_vectorInt(n::Int64=3,entropicVector="1h12-1h2")
	# vv=toy_entropic_matrix(n)[5]
	x= entropicVector * "+"
		listE=unique_entropy_vector(n)[3]
	   sortedListE="h" .* string.(sort(parse.(Int64,replace.(listE,"h"=>"")),rev=true))
	G=zeros(1,length(listE))

	for idx=1:length(listE)
		mx=match(Regex("([-|+]?\\d$(sortedListE[idx])[-|+]+)"),x) # special quantifier Z to identify the end word

	if(mx == nothing)
		G[idx]=0
	else
		mz=match(r"([-|+]?\dh)",mx.captures[1])
		G[idx]= parse(Int64,replace(mz.captures[1],"h"=>""))	
	end
		end
	return G[:]
end

"""
Find the Entropic matrix `G`` for a given `n`
```julia-repl
julia> entropic_matrix(3)
```
"""
function entropic_matrix(m::Int64=2)
	Q=minimal_EIM_list_canonical(m)[2]
	Qtmp=replace.(Q,r"^\+h" => s"1h") # Substitute the first +h
	Qtmp1=replace.(Qtmp,r"\+h" => s"+1h") # Substitute all +h
	Qout=replace.(Qtmp1,r"\-h" => s"-1h")
	return Qout	
end



"""
For a given number `n` of random variables, list down all the elemental information measures in minimal canonical form. 
```julia-repl
julia> u,v,m,n=minimal_EIM_list_canonical(2)
```
"""
function minimal_EIM_list_canonical(n::Int64=2)
	x=entropy_vector(n);
	x2=order_entropic_expression.(order_entropic.(x))
	y=unique(x2)
	return x,y,length(x),length(y)
end

"""
Each entropy word in an entropic vector is sorted.

#### Examples
```julia-repl
julia> order_entropic("h24-h32-h132-h2")
"h24 - h23 - h123 - h2"

```
"""
function order_entropic(s::AbstractString="Hello world")
	
	s0=replace(s,"h"=>"h ","+"=>" + ","-"=>" - ")
	x=split(s0," ") # Split into words delim=" "
	
	Y=""
	for wIdx = 1:length(x)
		# w=x[wIdx] # word
		y=string(sort([a for a in x[wIdx]])...)  # sort each word
		Y= Y * " " * y 
	end
	Yout=replace(Y,"h "=>"h"," " =>"")
	
	return Yout
end


"""
Express an entropic expression in the lexicographic order of entropic vectors
```julia-repl
julia> order_entropic_expression("h12-h32-123")
```
"""
function order_entropic_expression(X::AbstractString="h12-h32-123")
	Y=join.(sort.(split.(replace.(X,"-h"=>" -h","+h"=>" +h","h"=>" +h")," ")))
	return Y
end




"""
Find the Entropic matrix `G` for a given `n`
```julia-repl
julia> find_matrixG(3)
```
"""
function find_matrixG(n::Int64=3)
	L=length(entropic_matrix(n))
	K=length(unique_entropy_vector(n)[3]) # Number of unique entropic dimensions
	Gv=[]
	# @show L
	for idx=1:L
		U = entropic_matrix(n)[idx]
	    gg = find_entropic_vector(n,U)
		# @show n,L,idx, gg
		Gv=[Gv;gg]
		# Gm[idx,:]=gg
	end
	G=reshape(Gv,K,L)
	H0=Int.(parse.(Float64,string.(G)))'
    H=Int.(H0)
	return H,K,L
end


function find_entropic_vector_int(n::Int64=3,entropicVector="1h12-1h2")
	x= entropicVector * "+"
		listE=unique_entropy_vector(n)[3]
	   sortedListE="h" .* string.(sort(parse.(Int64,replace.(listE,"h"=>"")),rev=true))
	G=zeros(1,length(listE))

	for idx=1:length(listE)
		mx=match(Regex("([-|+]?\\d$(sortedListE[idx])[-|+]+)"),x) # special quantifier Z to identify the end word

	if(mx == nothing)
		G[idx]=0
	else
		mz=match(r"([-|+]?\dh)",mx.captures[1])
		G[idx]= parse(Int64,replace(mz.captures[1],"h"=>""))	
	end
		end
	return G[:]
end

"""
Given a linear expression in canonical form, it finds the co-ordinates in the entropic space `Γ`
"""
function find_entropic_vector(n::Int64=3,entropicVector="1h12-1h2")
	x= entropicVector * "+"
	listE=unique_entropy_vector(n)[3]
	sortedListE="h" .* string.(sort(parse.(Int64,replace.(listE,"h"=>"")),rev=true))
    G=zeros(1,length(listE))
	for idxx=1:length(listE)
	    mx=match(Regex("([-|+]?\\d*[.]?\\d*$(sortedListE[idxx])[-|+]+)"),x)

	    if(mx == nothing)
		    G[idxx]=0.0
	    else
		# mz=match(r"([-|+]?\dh)",mx.captures[1])
		    mz=match(r"([-|+]?[\d]*[.]?[\d]*h)",mx.captures[1])
		    G[idxx]= parse(Float64,replace(mz.captures[1],"h"=>""))	
	    end
	end
    return G[:]
end

"""
Γ₂ geometry. This is the simplest case with two random variables (say `X,Y`) forming a geometry in three dimension. The geometric space is spanned by entropy vectors `H(X)`, `H(Y)` and `H(X,Y)`. Γ₂ is a 3D cone in the positive orthant.
This function is used for visualizing the entropic space in 3D.
"""
function GeometryConeGamma2(x,y,z)
	H=[ 0.0   0   1
 		-1   1   1
  		1  -1   0
  		0   1   0
  		1   0  -1]
	X=(0.0,0.0,0)
	Y=[]
	Z=[]
	p = 0.0
	idx=1
	if(-z+y+x ≥0 && z -y ≥ 0 && z -x ≥ 0 && z ≥0 && y≥0 && x ≥ 0)
		p=1.0
		
		idx,X=[X;x]
		 Y=[Y;y]
		# Z=[Z;z]
		# (x,y,z)
		# Z=push!(Z,z)
	end
	if(-z+y+x ≥0)
		if ( z -y ≥ 0) 
			if(z -x ≥ 0)
				if(z ≥0)
					if (y≥0)
						if (x ≥ 0)
							Y=push!(Z,tuple(x,y,z))
						end
					end
				end
			end
		end
	end
	
	return Y
end

"""
Set of discrete points in `Γ₂`	 confined within a hypercube 
"""
function elementsGamma2(;rmin::Float64=0.0,rmax::Float64=1.0,rstep::Float64 = 0.1)
	x = rmin:rstep:rmax
    y = rmin:rstep:rmax
    z = rmin:rstep:rmax
	vol = [GeometryConeGamma2(ix,iy,iz) for ix in x, iy in y, iz in z]
	U=vol[findall( x -> x != [], vol )]
	V=hcat(U...)
	W=hcat(collect.(V)...)
	return W
end

"""
    E,UE,V,λ =entropic_terms(S::AbstractString)

Find the additive entropic terms in the canonical expression. This function is internally used in `simplifyH(S::AbstractString)`.
#### Arguments
- S  = Any linear Information Expression. These are linear combination of ``I(X_1,...X_k;Y_1,..Y_l|Z_1,...Z_n)`` and ``H(X_1,X_2,...X_m|Z_1,..Z_n)``
#### Output
- E  = Constituent Information measures in S
- U = The distinct (unique) elements from E
- V = The individual elements of S 
- λ = The scaling coefficients of U (i.e., ``V=λ^T E``)


#### Examples
```julia-repl
julia> S="I(X;Y)-H(X,Y|Z)-3H(X,Y)+2I(X;Y)"
julia> E,UE,V,λ=entropic_terms(S) 
["I(X;Y)" "H(X,Y|Z)" "H(X,Y)" "I(X;Y)"],
["I(X;Y)" "H(X,Y|Z)" "H(X,Y)"],
["1I(X;Y)" "-1H(X,Y|Z)" "-3H(X,Y)" "2I(X;Y)"],
[1.0 -1.0 -3.0 2.0]
```
"""
function entropic_terms(S::AbstractString)
	A0= "+" * S
	A1= replace(A0,"+H"=>"+1H","-H"=>"-1H")
	A2= replace(A1,"+I"=>"+1I")
	A2a= replace(A2,"-I"=>"-1I")
	A2b= replace(A2a,"-"=>"+-")
	A3=replace(A2b,"++"=>"+")
	A4=split(A3,"+")
	V=A4[2:end]

	E=[match(r"([H|I]?\(.*)",i).captures[1] for i in V]
	λ=parse.(Float64,[match(r"([-|+]*\d*[.]?(\d*)?)",i).captures[1] for i in V])
	UE=unique(E)
	
	return E,UE,V,λ	
end



"""
    C=minimalE(V,U,λ)

This function is internally used in `simplifyH(S::AbstractString)`.
### Arguments
- ``E``  = Constituent Information measures in ``S``
- ``U`` = The distinct (unique) elements from ``E``
- ``V`` = The individual elements of ``S`` 
- ``λ`` = The scaling coefficients of ``U`` (i.e., ``V=λ^T E``)

### Output
- C = Simplified Information Expression as a linear combination of ``U``

#### Examples
```julia-repl
julia> S="7H(X,Y|Z1,Z2)+2H(X,Y)-4H(X,Y)+H(Z)-3H(X,Y|Z1,Z2)"
julia> E,U,V,λ=entropic_terms(S) 
julia> Z= minimalE(V,U,λ)
"+4.0H(X,Y|Z1,Z2)-2.0H(X,Y)+H(Z)"
```
"""
function minimalE(V,UE,λ)
	Z=""
	for u in UE
		Λ0=sum(λ[occursin.(u, V)])
		Λ = round(Λ0,digits=3)
		if Λ ≠ 0
			Y="+" * string(Λ) * u
		else
			Y="" 
		end
		Z=Z*Y
	end
	P=replace(Z," "=>"","+-"=>"-","++"=>"+")
	C=replace(P,"-1.0H"=>"-H","+1.0H"=>"+H","-1.0I"=>"-I","+1.0I"=>"+I")
	return C
end



"""
Express an Information Expression in the simplest form (algebraically).
#### Examples
```julia-repl
julia> simplify("I(X;Y)-H(X,Y|Z)-3H(X,Y)+2I(X;Y)")
"+3.0I(X;Y)-H(X,Y|Z)-3.0H(X,Y)"

julia> simplify("3I(X;Y|Z)-H(X,Y|Z)-3I(X;Y|Z)-3H(X,Y|Z)+H(X1,X2)")
"-4.0H(X,Y|Z)+H(X1,X2)"
```
"""
function simplify(S)
	E,UE,V,λ =	entropic_terms(S)
	M=minimalE(V,UE,λ)
	return M
end


"""
Express an Information Expression in the simplest form (algebraically). This is used in conjunction with the canonical expression.
#### Examples
```julia-repl
julia> 
```
"""
function simplifyH(S)
	E,UE,V,λ =	entropic_terms(S)
	M=minimalE(V,UE,λ)
	return M
end


