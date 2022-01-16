"""
Each entropy word in an entropic vector is sorted.

#### Examples
```julia-repl
julia> order_entropic1("h24-h32-h132-h2")
"h24 - h23 - h123 - h2"

julia> order_entropic1("7h32 - h243 - h13701 - h92252")
"7h23-h234-h01137-h22259"

```
"""
function order_entropic1(s::AbstractString="Hello world")
	
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
Each word in a sentence (string) is sorted alphabetically.

#### Examples
```julia-repl
julia> order_string("This is a sorted sentence; Who is 1 and two  ")
" This is a deorst ;ceeennst Who is 1 adn otw  "

```
"""
function order_string(s::AbstractString="Hello world")
	
	s0=replace(s,"+"=>" + ","-"=>" - ")
	x=split(s0," ") # Split into words delim=" "
	
	Y=""
	for wIdx = 1:length(x)
		# w=x[wIdx] # word
		y=string(sort([a for a in x[wIdx]])...)  # sort each word
		Y= Y * " " * y 
	end
	Yout=replace(Y," " =>" ")
	
	return Yout
end

"""
	find_subset(n::Int64,p,q,RV::AbstractString="X")

Given `i` and `j` compute `Κ ⊆ \U1d4a9 \\{i,j}`; i.e., all non exclusive subsets. `i,j` can also be empty (i.e. []), in which case the non-empty superset gets listed. An optional prefix can be added (default is `X`).  
#### Examples
```julia-repl
julia>find_subset(4,1,3,"X")
["" "X1" "X1,X2" "X1,X2,X5" "X1,X5" "X2" "X2,X5" "X5"]

julia>find_subset(4,1,3,"")
["" "1" "1,2" "1,2,5" "1,5" "2" "2,5" "5"]

julia> find_subset(5,4,3,"🍒")
["" "🍒3" "🍒3,🍒4" "🍒4"]

julia> find_subset(5,[],[],"🍓")
["🍓1" "🍓1,🍓2" "🍓1,🍓2,🍓3" "🍓1,🍓3" "🍓2" "🍓2,🍓3" "🍓3"]
```
"""
function find_subset(n::Int64,p,q,RV::AbstractString="X")
	s="$(RV)" .* string.(1:n)
	s1="$(RV)" .* string(p)
	s2="$(RV)" .* string(q)
	PowerSet = collect(powerset(s,1,n)) # Skip empty set
	setXk=[]
	for kk = 1:Int64(exp2(n)-1)
		subSet1 = vcat(PowerSet[kk,:][1])
		subSet2 = setdiff(subSet1,[s1,s2])
		setXk=[setXk; join(subSet2,",")]
	end
	
	return sort(unique(setXk))
end