Trigonometry is the study of triangles.

## Right Triangle
---
Possibly the most important triangle in the history of triangles is the right triangle. I don't really know why but google says that they're important for finding the area of polygons and finding distances.
There are three sides to a right triangle. 

## The Hypotenuse
---
The only diagonal side in a right triangle is called the hypotenuse, it connects the top and bottom sides of a right triangle.
Pythagoras once famously said:
$a² + b² = c²$
$c$ is the hypotenuse, $a, b$ are opposite and adjacent sides of the triangle
Why is this useful? You might ask, well it's useful for a variety of things, mainly finding the shortest distance between things. 

## Sin, Cos and Tan
---
Sin, Cos, and Tan are useful trigonometric functions related to a right triangle.
They are comparisons between the sides of a right triangle.
$sin = opp/hyp$
$cos = adj/hyp$
$tan = opp/adj$

Let's take a circle, one with radius 1. Any point that lies on the rim of the circle will have its distance from the center be exactly 1. Take any point on the circle, and form a right triangle from the center to the point, the adjacent side will be sitting on the x-axis. The hypotenuse of this right triangle will be 1 since the radius of the circle is 1, sin just tells us the height of the opposite side of this triangle. Cos tells us the width of the adjacent side to this triangle.
![[SinAndCos.PNG | 200]]
Sin takes a parameter though, an angle on the circle. An angle of 0 degrees would lie on the right most point on the circle, and an angle of 90 degrees would lie on the upmost point on the circle.

Calling the sin function every frame with an increasing angle, which can be any number, let's put time there. The sin function can only give values between 1 and -1 since 1 is the radius of the unit circle, so the angle (time) will be going round and round the unit circle in sin's point of view. And sin will give a wave that oscillates up and down, this is called a sin wave which is very useful in computer science. Cosine also does the same thing but gives the x position instead.

And let's say we want to measure the slope (which you can learn in [[Calculus]]) of an angle, we can plot the angle on a circle, we can put a right triangle with one of its points in the center of triangle, and the second one on the angle we want to measure.
And wouldn't you know it, the slope of the angle is proportional to its angle, but there's one small problem, when the angle is pi/2 (or perpendicular to 0 rad), the slope of the angle would be infinite, because the triangle would need to be infinitely thin and infinitely tall, and this is called tangent function or tan for short.
And all of these trigonometric functions take an angle, plot it on a circle, make a right triangle out of it, and return the ratios between the three sides of the right triangle.

Sin, cos, and tan take in an angle and return ratios between the three sides of the right triangle it forms, but there's also another lineage of functions that do the opposite, they take in a ratio, and return the angle on the unit circle, these functions are called arcsin, arccos, and arctan.

## Getting the distance between two vectors
---
Let's take two vectors: [2, 1] and [6, 5]
How do we find the distance between these two vectors?
One way we can do this is to make a right triangle whose sides or corners sit on these two vectors.
And then we can find the distance by finding the hypotenuse of this triangle.
The opposite side of the right triangle's distance will be x1 - x2.
And the adjacent side of the right triangle's distance will by y1 - y2.
Which is [4, 4] or [-4, -4] but it won't matter which one it is, since we're squaring them.
Squaring both of them gives 16.
And then we can just add both numbers which gives us 32.
Since this is squared (according to my main man Pythagoras), we'll have to take the squared root of this which gives us: 5.656
This is the Euclidian Distance Formula which is a forked version of Pythagoras' theorem. 

### EXERCISE!!
How would you calculate the distance between two circles with a set radii?
>You subtract their radii from the distance provided by the formula

