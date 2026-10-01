###     Performance in julia
###     You can find the most important notes on performance in julia at https://docs.julialang.org/en/v1/manual/performance-tips/

rng = 1:1:100_000_000

###     Measuring performance (keep in mind compile time, and variation): 
@time sum(rng);      # measures time 

###     Most important things first: performance crititcal code should always(!!!) be inside functions, only using local variable scope. 
###     Julia code is compiled to native code using LLVM (you can see a "human readible" version of the native code using @code_native). During this procedure, julia runs type inference.  
###     A global variable may change type at any time, and hence running code in global scope makes it hard for the compiler to provide highly optimized code. 
###     See the following example, where : 

function sum_global()
    s = 0.0
    for i in rng
        s += i
    end
    return s
end;

@time sum_global();

function sum_local(rng)
    s = 0.0
    for i in rng
        s += i
    end
    return s
end;

@time sum_local(rng);

###     How can I improve slow code?
###     Performance critical code should always use locally scoped variables, where the type can be inferred. 
###     You can see if types can be inferred from your code using the @code_warntype macro: 
@code_warntype sum_global();        # We can see, that julia is not able to infer the types of several variables
@code_warntype sum_local(rng);      # Here, julia is able to infer types

###     You can also share knowledge with the compiler using type annotation. However, using locally scoped variables should be preferred (if possible)
function sum_global_annot()
    s = 0.0
    for i in rng::StepRange{Int64, Int64}
        s += i
    end
    return s
end;

@time sum_global_annot();           # This function is fast as well
@code_warntype sum_global_annot();  # We can see that type inference during compile time works


#### See also a quick instruction of why multiple dispatch is very nice: 
# If we had defined our own struct myRNG (essentially the same as rng from before, but now with a name), 
# we could build on the existing fast implementation of sum (without even knowing that it exists). 
# We simply have to adhere to some basic functions that an AbstractRange should have. 
# This allows to write very generic code that is still fast, and does not require to reimplement everything from scratch. 
# Kind of cool, right? 

import Base: getindex, length, first, last, step # import some basic functions to overload 
struct myRNG{T} <: AbstractRange{T} # define our new range
    start::T
    stop::T
    step::T
    name::String
end
function Base.length(r::myRNG{T}) where T # define a length function for our range
    return Int(((r.stop - r.start)/r.step) + 1)
end
function Base.getindex(r::myRNG{T}, i::Int) where T # define a getindex function for our range
    r.start + (i-1)*r.step
end
Base.first(r::myRNG) = r.start # define a first function for our range
Base.last(r::myRNG) = r.stop # define a last function for our range
Base.step(r::myRNG) = r.step # define a step function for our range

my_rng = myRNG(1,100_000_000,1,"some_name");

@time sum(my_rng);
@time sum(rng);
@time sum_local(rng);
@assert sum(my_rng) == sum(rng) == sum_local(rng);