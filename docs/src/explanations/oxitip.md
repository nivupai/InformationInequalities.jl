# Preconditioning interval linear systems

```@contents
Pages = ["oxitip.md"]
```

## Basic concepts of OXITIP

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


## Advantages of preconditioning

Using preconditioning to solve an interval linear system can have mainly two advantages.

### Extend usability of algorithms 

Some algorithms require the matrix to have a specific structure in order to be used. For example Hansen-Bliek-Rohn algorithm requires ``\mathbf{A}`` to be an H-matrix. However, the algorithm can be extended to work to strongly regular matrices using inverse midpoint preconditioning. (Recall that an interval matrix is strongly regular if ``A_c^{-1}\mathbf{A}`` is an H-matrix).

### Improve numerical stability

Even if the algorithms theoretically work