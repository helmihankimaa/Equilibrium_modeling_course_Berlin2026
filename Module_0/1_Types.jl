# Julia uses dynamic typing. This means that you don't need to declare the type of a variable when you create it. 
# Essentially, Julia will figure it out for you.

my_age = 26
typeof(my_age)

my_height = 1.95
typeof(my_height)

my_char = 'c'
typeof(my_char)

my_bool = false
typeof(my_bool)

# Julia also supports Unicode, so you can use latex-like variable names: 
# this is especially practical for mathematical formulas: 
α = 0.5 # just type \alpha and hit tab

# So far, we have only seen primitive types. However, there also exist more complicated types (see below for an explanation). 

🚂 = "locomotive" # just type :steam_locomotive and hit tab
typeof(🚂)

# Symbol is a data type used in the background of julia, as it is more efficient than strings. 
# It plays an important role in metaprogramming, but we will not discuss much of that. 
# You may think of it as a "string that is immutable" for now.
my_symbol = :lb
typeof(my_symbol)

# Converting is also possible
String(my_symbol)
Symbol(🚂)
Float64(my_age)
convert(Float64, my_age)

# Arrays are a collection of elements of some types: 
my_vector = [1,2,3]
typeof(my_vector)

# a two dimensional array is a matrix
my_matrix = [1 2 3; 4 5 6; 7 8 9]
typeof(my_matrix)

# ask for the dimension of an array
ndims(my_matrix)
# get the size of the respective dimensions
size(my_matrix)
# the number of elements inside a container (despite their dimension)
length(my_matrix)

## Some Basic math: 
2+2

x1 = 5
x2 = 2

my_sum = x1 + x2
my_product = x1 * x2
my_quotient = x1 / x2
my_power = x1^x2

# Order of operations:
x1 + 1 * x2
(x1 + 1) * x2

# Linear Algebra: 
my_vector' * my_matrix
my_matrix * my_vector
my_vector * my_matrix # Errors

# Type hierarchy
# Julia defines abstract supertypes
Float64 <: AbstractFloat <: Real <: Number <: Any
Float64 <: AbstractFloat <: Complex

# It also defines concrete types (e.g. Float64 from above)
# Essentially, all concrete types consist of different compositions of primitive types (see https://docs.julialang.org/en/v1/manual/types/)
struct Dog
    name
    age::Int
    is_happy::Bool
end
# Fields with no type annotation default to Any, and can accordingly hold any type of value.
d1 = Dog("Fido", 3, true)
fieldnames(typeof(d1))
# structs are immutable: once created, their fields cannot be changed.
d1.age = 4 # throws an error

# Mutable structs are composite types that can be changed after creation.
mutable struct Cat
    name
    age::Int
    is_happy::Bool
end
c1 = Cat("Whiskers", 2, false)
c1.age = 3 # works fine

struct MyVec
    data::Vector{Float64}
end

v1 = MyVec([1.0, 2.0, 3.0])
v1.data[1] = 10.0 # works fine, as the vector itself is a mutable struct, only MyVec is immutable
v1.data = [4.0, 5.0] # throws an error, as we try to change the field of the immutable struct to a new underlying vector. 

# Be careful, keep in mind the distinction of call by value vs call by reference: 

# call by value: 
a = 2
b = a
b += 1
a # still 2
b # now 3

# call by reference:
c = [1, 2, 3]
d = c
d[1] += 1
c # now [2, 2, 3]
d # also [2, 2, 3]

# Parametric types are also possible: 
abstract type AbstractPoint{T} end
struct Point2D{T} <: AbstractPoint{T}
    x::T
    y::T
end

p1 = Point2D(1.0, 2.0)
ps = Point2D(1, 2)
# Similarly, you can also define abstract parametric types:
Point2D{Float64} <: AbstractPoint{Float64}
Point2D{Float64} <: AbstractPoint{Real} # Is false, since julias types are invariant.

# Tuples: 
# tuples are close to immutable structs, but with unnamed fields: 
mytuple = (1,2,3)
typeof(mytuple)
mytuple[1]

namedtuple = (a=5, b=4)
namedtuple.a

# Dicts (unordered, and with keywords): 
mydict = Dict("key1" => 3, "key2" => 1, "key3" => 0)