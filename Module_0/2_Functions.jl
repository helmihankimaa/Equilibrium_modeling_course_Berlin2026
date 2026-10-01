# we can define our own functions
# by using the keyword `function`
function mytestfunction() # this function does not have any input
    println("This is just a test.")
end

mytestfunction()

function do_stuff(n) # this function has an input argument
    x = 0
    for i in 1:n # this n is the input to our function
        x += i # this is equal to x = i + x
    end
    return x # and it returns something
end

do_stuff(5), do_stuff(2), do_stuff(10)

# a function can have more than one arugment
# multiple dispatch: chooses which of a function's methods to call based on the number of arguments given, and on the types of all of the function's arguments
function do_stuff(n, start) 
    x = start
    for i in 1:n 
        x += i 
    end
    return x 
end

do_stuff(3,0), do_stuff(3,-10)

function do_stuff(n, start=0; doubleit=false) # we can also specify keyword arguments
    # here we set a default value for the input argument "doubleit"
    # so if you do not set it to true it will be false by default
    x = start
    for i in 1:n
        x += i
    end
    
    if doubleit # if the keyword argument is true
        return 2*x # in that case double our output
    else
        return x # if the keyword argument is false then just return x
    end
end

do_stuff(2, doubleit=false), do_stuff(2, doubleit=true), do_stuff(2, -5, doubleit=false)

function do_stuff(n::Float64; doubleit=false) #we create a version for our function where n is a float number
    # we need a integer number for our for-loop
    # if the input is a float we want that number to be rounded
    x = 0
    n_rounded = round(n) # the `round` function does exactly that 
    for i in 1:n_rounded
        x += i
    end
    
    if doubleit 
        return 2*x 
    else
        return x 
    end
end

do_stuff(2.4, doubleit=false), do_stuff(2.6, doubleit=true)

# functions can also be vectorized (broadcasting)
do_stuff.([4,5,6])

#if our function is really short we can neglect the function keyword
mytestfunction(x) = println("The input x is not specified!") 
mytestfunction(x::Int64) = println("x is an integer!") # the :: behind the variable indicates that a type definition follows
mytestfunction(x::String) = println("x is an string!")
mytestfunction(x::Float64) = println("x is an float!")

mytestfunction(1)

mytestfunction(1.5)

mytestfunction("a")

# now we use a complex number for which we did not define a specilized method
mytestfunction(1 + 2im)

# it says that println is a generic function with 3 methods
println
# here we see that sqrt is defined for a lot of different number types but also to some arrays/matrices
methods(sqrt)

# now you might understand what this error message means
# a "MethodError" always means that the function does not accept this input
sum(nothing)

# also our basic math operations are just functions provided by the Julia Base library
# the plus function for example has 166 different methods
+ 

# this defines an anonymous function
x -> x > 0 #so this is not very helpful yet

# We can use our anonymous function to filter a vector
arr = [-2,-1,0,2,4]

filter(x-> x > 0, arr)

# the alternative would be to write a function and use that as an argument
filter_function(x) = x > 0 # if we only use that function one time it is better to just use an anonymous function
filter(filter_function, arr)

# `map` applies a function to a collection of elements (e.g. an array) elementwise
arr = [1,2,3]
# we already had that example earlier
map(sqrt, arr) # is equal to sqrt.(arr)

# this is especially useful in combination with an anonymous function
map(x-> x^2 - 1, arr)

# this is 
map(sqrt, arr)
# equal to
map(x-> sqrt(x), arr)


# if the operations become too complex to fit in one line we can use the do block syntax

map(arr) do x # instead of define the function in the x-> x style we can handle it like a regular function
    if x > 0
        return sqrt(x)
    elseif x == 0
        return 0
    else
        return sqrt(-x)
    end
end
