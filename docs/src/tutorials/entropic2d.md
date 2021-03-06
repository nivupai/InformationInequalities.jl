# Eigenvalue computations
# Generator matrix
```@example EntropicMatrix
    using InformationInequalities
    n=3
    G,K,L=find_matrixG(n)
    transpose(G)
```
Note that the generator matrix is ``K \times L`` 

Pictorial view for `n=3`:
```@example EntropicMatrixPlot
    using InformationInequalities
    using Plots,LinearAlgebra
    n=3
    G,K,L=find_matrixG(n)
    heatmap(transpose(G),xaxis=nothing,yaxis=nothing,legend=nothing,color=:viridis)
    savefig("heatmapH3a.svg"); # hide 
```
![](heatmapH3a.svg)


Pictorial view for `n=4`:
```@example EntropicMatrixPlot4
    using InformationInequalities
    using Plots,LinearAlgebra
    n=4
    G,K,L=find_matrixG(n)
    #heatmap(transpose(G),aspectratio=1,color=:viridis)
    heatmap(transpose(G),xaxis=nothing,yaxis=nothing,legend=nothing,color=:viridis)
    savefig("heatmapH4a.svg"); # hide 
```
![](heatmapH4a.svg)

Pictorial view for `n=6`:
```@example EntropicMatrixPlot6
    using InformationInequalities
    using Plots,LinearAlgebra
    n=6
    G,K,L=find_matrixG(n)
    #heatmap(transpose(G),aspectratio=1,color=:viridis)
    heatmap(transpose(G),xaxis=nothing,yaxis=nothing,legend=nothing,color=:viridis)
    savefig("heatmapH6a.svg"); # hide 
```
![](heatmapH6a.svg)


Pictorial view for `n=7`:

![](./../assets/heatmapH7a.svg)

# Singular values of the Entropic Space
The singular values of the generator matrix follows some structure.

```@example eigsEntropic
using LinearAlgebra;
using InformationInequalities
using Plots
	scatter(svdvals(find_matrixG(2)[1]),label="Γ2")
    scatter!(svdvals(find_matrixG(3)[1]),label="Γ3")
    scatter!(svdvals(find_matrixG(4)[1]),label="Γ4")
    scatter!(svdvals(find_matrixG(5)[1]),label="Γ5")
    ylabel!("λ")
savefig("eigsEntropic.svg"); # hide
```
![](eigsEntropic.svg)


Interesting thing to notice is among the ``2^n-n`` singular values of the generator matrix  of ``\lambda_{n}``, ``n`` are inheited from ``\lambda_{n-1}``. The new  eigenvalue is ``n\sqrt{2}``.

```@example eigsSqrt2
using LinearAlgebra;
using InformationInequalities
[n*√2 for n=1:10]
```

!!! note
    A fascinating thing here is that, for a given ``n`` the number of random variables, the entropy space ``\Gamma_{n}``, the singular values of the generating matrix ``G`` are such that ``n`` of them are distinct from those of ``\Gamma_{n-1}`` but the rest (overwhleming majority that) are integer multiples of ``\sqrt{2}``.

## Eigenvalues 



!!! note
    At the moment, `ShannonMatrix` is not rigorous, that is the computations for the non-interval eigenvalue problem solved internally are carried out using normal non-verified floating point computations. Julia internally has slight difference in floating point precision for some of the singular values when ``\sqrt{2}`` and its multiples are evaluated. TBD

To demonstrate the functionality, let us consider the following interval matrix

```@example eigs1
using InformationInequalities

A = [3 2 1
     2 2 2
     0 1 2]
```



To get a qualitative evaluation of the enclosure, we can simulate the solution set of ``\mathbf{A}`` using Montecarlo, as it is done in the following example

```@example eigs1
using InformationInequalities
using LinearAlgebra;
using Random; # hide
Random.seed!(42) # hide
using Plots
N = 1000

evalues = zeros(ComplexF64, 4, N)

for i in 1:N
    evalues[:, i] = eigvals(rand(4,4))
end

rpart = real.(evalues)
ipart = imag.(evalues)

plot(; ratio=1, label="closure")
scatter!(rpart[1, :], ipart[1, :]; label="λ₁")
scatter!(rpart[2, :], ipart[2, :]; label="λ₂")
scatter!(rpart[3, :], ipart[3, :]; label="λ₃")
scatter!(rpart[4, :], ipart[4, :]; label="λ₄")
xlabel!("real")
ylabel!("imag")
savefig("eigs1.png") # hide
```

![](eigs1.png)

Internally, the generical interval eigenvalue problem is