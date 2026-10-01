### Loops ###

## For loop
# range as an iterator
for i in 1:5
    println("The current iteration is $i")
end

myarr = [5,10,12]

# `eachindex` also returns an efficient iterator (warning about offset arrays!)
for i in eachindex(myarr)
    println(i)
end

# we can also iterate over the values of an array
for x in myarr
    println("The current value is $x")
end

# or over both index and value: 
for (idx,val) in enumerate(myarr)
    println("The current iteration is $idx and value is $val")
end

# in a multidimensional array the iterator works column-wise (Julia is column-major, in contrast to e.g. C)
myarr = hcat(myarr, [1,2,3])
for (position,value) in enumerate(myarr)
    println("The current iteration is $position and value is $value")
end

## While loop
i = 10
while i>=1
    println(i)
    i -= 1
end

# we can also define a variable locally with the let block (different scopes): 
i = 10
let i=1 
    while i<=5
        println(i)
        i += 1
    end
end
println(i)

# Some logic: 
1 == 1.0
2 != 2
!(2 == 2)
x = 2
mylist = [1,2,3,4]
# check if an element is in an array
x in mylist
x = 10
x in mylist


## subseting arrays based on a condition
# initiate an array with booleans
fill(true, 3)

boolarray = [true, false, true, false]
# use a boolean array to subset another array
mylist[boolarray]

bitarray = [1,2,3,4] .>= 3
mylist[bitarray]
mylist[mylist .>= 3]

## controling code flow with "if"
if true
    println("This is true")
end

if false
    println("This is not true")
end

# if, else, elseif
x = 5
if x >= 1
    println("x is greater than 0")
elseif x == 0
    println("x is zero")
else
    println("x is smaller than 0")
end

# short form for if statement
x = -1
x >= 0 ? (y = "positive") : (y = "negative")

# Short Circuit evaluations: 
x = 1
# && is an "and"
x > 0 && println("x is greater than zero")

x = -11
# || is an "or "
x <= 0 || println("x is greater than zero")

# break
for i in 1:5
    println(i)
    if i > 3
        break
    end
end