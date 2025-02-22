Calculus is the study of change and accumulation of small quantities to form a bigger whole.
# Functions
---
In calculus, functions are mathematical expressions which are meant to be plotted on a graph.
x^2 is a mathematical expression that would grow exponentially when plotted on a graph.
You input an x position into a function, and the function returns the y position at the specified x position.
# Derivatives
---
A derivative is the slope of a function, or how steep it is. Take two points on a function: a, and b.
We want to calculate the slope between the two, or how far apart the two points are, vertically.
This is simple [[Linear Algebra]], we can subtract both points' x positions, and both points' y positions, we can call these new values the difference in their x and y, or dx and dy for short.
And if we increase dy, we increase the slope or the steepness between the two points, so dy must be proportional to the slope, and if we increase the dx, the slope decreases, so dx must be inversely proportional, we can come up with a formula for this.
dy / dx is the slope between two points.
But that was just two points, we want to measure the slope of the entire function. But how would we do that? Let's just use some rectangles to represent the slope of the function, the higher the function returns the taller the rectangle, and let's set the width of the rectangles to a value called h, which will be just 1 in this example.
So:
derivative = f(x + h) - f(x) / h
f() is the function we want to measure the slope for, x + h is the second point, x is the first point, and h is the width of the rectangles. But this is just an approximation, this won't exactly return the slope of the function because the rectangles are only 1 in width. It's like using a massive paint brush to draw a face, you can't really draw it well, because a face has many details, and a massive paint brush can't draw any detail. So we must use smaller rectangles, wait a second... we can use [[Limits]]. So, lim h -> 0 and our approximation is no longer an approximation but is perfect.
# Integrals
---
Let's say we have a function: f(x) = x^2.
How would we measure the area of the function?
Well like the last example, we can use a bunch of rectangles again.
The area of a rectangle is width * height, so we can sum up all the rectangles' areas.
area = f(x) * dx
f(x) is the height, dx is the width of the rectangle, and again like the previous example, we can use a limit for dx.
But this is an area calculation for just one of the rectangles, we want to sum ALL of the areas up.
How would we do this? What we want to achieve is similar to the sigma operator, but let's just change it a bit to a squiggly line and let's state that it repeats an expression for every possible number. So:
area = ∫ f(x) * dx
And we have the integral.