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