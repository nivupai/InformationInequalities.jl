"""
Each entropy word in an entropic vector is sorted.

#### Examples
```julia-repl
julia> order_entropic("h24-h32-h132-h2")
"h24 - h23 - h123 - h2"

julia> order_entropic("7h32 - h243 - h13701 - h92252")
"7h23-h234-h01137-h22259"

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