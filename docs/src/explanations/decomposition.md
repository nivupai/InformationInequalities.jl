# Information Measures in Canonical form

```@contents
Pages = ["decomposition.md"]
```

# Canonical Represenation
Canonical representation refers to expressiong information expression as entropies and joint entropies. e.g., ``H(X1,X2,...,X_n)``. Elemental expressions can be decomposed to canonical form as follows:
* ``H\left(X_i|\textbf{X}_{\mathcal{N} \backslash \{i\}}\right) = H\left(\textbf{X}_{\mathcal{N}}\right)``
* ``I\left(X_i;X_j|\textbf{X}_{\kappa}\right)= H\left(X_i,\textbf{X}_\kappa\right)+H\left(X_j,\textbf{X}_\kappa\right)-H\left(X_i,X_j,\textbf{X}_\kappa\right)-H\left(\textbf{X}_\kappa\right)``

## Basic concepts

Consider the square interval linear system

```math
\mathbf{Ax}=\mathbf{b},
```

*preconditioning* the interval linear system by a *real* matrix ``C`` means to multiply both sides of the equation by ``C``, obtaining the new system

```math
C\mathbf{Ax}=C\mathbf{b},
```

which is called *preconditioned system*. Let us denote by ``A_c`` the *midpoint matrix* of ``\mathbf{A}``. Popular choices for ``C`` are

- Inverse midpoint preconditioning: ``C\approx A_c^{-1}``
- Inverse diagonal midpoint preconditioning: ``C\approx D_{A_c}^{-1}`` where ``D_{A_c}`` is the diagonal matrix containing the main diagonal of ``A_c``.




### Improve numerical stability

Even if the algorithms theoretically work