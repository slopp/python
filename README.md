# Python bindings for R

The `python` package defines a simple interface that lets R easily interact
with and manipulate many Python objects. It's derived from a fork of the superb
https://github.com/rstudio/tensorflow project (the `rpy` branch).

## Differences with https://github.com/rstudio/tensorflow

The intention of the `python` package is to provide a simpler interface between
R and Python compared to the more specialized Tensorflow R package.
The `python` package:

- removes tensorflow-specific objects and methods. 
- defers evaluating Python objects, allowing R programs to directly use Python object methods from R
- automatically converts R objects to corresponding Python ones when it can (just like the Tensorflow package)
- adds limited support for sparse matrix objects (compressed column oriented sparse matrices for now)
- treats R numeric vectors as 1-d numpy arrays when possible instead of Python list objects (users can append Python's tolist() method to yield Python lists if they wish)

## Why a separate project?

Now that these packages have begun to diverge somewhat, I decided to sever the
fork relationship to let users report issues specific to the `python` package,
distinct from the Tensorflow package.

Note that the low-level function namespaces are compatible between packages, so
that both may be loaded and used together (the user must prefix the `import()`
function with the desired package name however).

# Requirements and installation

R and the Rcpp package version >= 0.12.7 are required.  Python version 2 or 3
and the Python development headers and the numpy library are required. The Python
requirements may be satisfied on a Debian-like Linux operating system with,
for instance:
```
sudo apt-get install python-dev python-numpy
```

Install the package using the R `devtools` package with
```{r}
devtools::install_github("bwlewis/python")
```

# Examples

Import the numpy library:
```{r}
library(python)
np = import("numpy")
```
TAB completion works on most Python objects.
For instance, try typing `np$<TAB>` to see a list of available numpy methods.

Create an R matrix and copy it into a Python Numpy array object:
```{r}
set.seed(1)
x = matrix(rnorm(9), nrow=3)
p = np$array(x)
print(p)
```
```
[[-0.62645381  1.5952808   0.48742905]
 [ 0.18364332  0.32950777  0.73832471]
 [-0.83562861 -0.82046838  0.57578135]]
```
That output above was printed by Python. Again, we can use TAB completion to
see what Python methods are available for our Numpy array:
```
p$<TAB>

p$T             p$byteswap      p$cumsum        p$flat          p$min           p$ravel         p$shape         p$tobytes
p$all           p$choose        p$data          p$flatten       p$nbytes        p$real          p$size          p$tofile
p$any           p$clip          p$diagonal      p$getfield      p$ndim          p$repeat        p$sort          p$tolist
p$argmax        p$compress      p$dot           p$imag          p$newbyteorder  p$reshape       p$squeeze       p$tostring
p$argmin        p$conj          p$dtype         p$item          p$nonzero       p$resize        p$std           p$trace
p$argpartition  p$conjugate     p$dump          p$itemset       p$partition     p$round         p$strides       p$transpose
p$argsort       p$copy          p$dumps         p$itemsize      p$prod          p$searchsorted  p$sum           p$var
p$astype        p$ctypes        p$fill          p$max           p$ptp           p$setfield      p$swapaxes      p$view
p$base          p$cumprod       p$flags         p$mean          p$put           p$setflags      p$take
```
