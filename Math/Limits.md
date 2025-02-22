Limits are very useful mathematical terms
A limit is defined as this: lim a -> b
Where a approaches b.
Let's say you make a function that computes the highest possible value that can result in a division.
How would you define it?
To get the highest possible result for a division, you need to divide by the smallest number, let's say that the function is like this:
f(x) = x / 0.00000000001
But the divisor is not small enough here, it can still go smaller, hmmm... well let's set it to 0.
But that would mean a division by zero, which is an undefined number.
If only we had a number that approaches zero, but never actually gets set to it. Almost like there's a limit to how low that number can go. Wait... we can use a limit!
lim d -> 0
f(x) = x / d
'd' approaches zero but isn't actually zero, meaning that the function would return the highest possible value for a division, which is infinity (I think, idk tho).