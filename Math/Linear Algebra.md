Linear algebra composes of vectors and matrices, vectors are a three dimensional point in space, and can also be used as a direction, and matrices are a row of numbers. A matrix4x4 is just 4 rows and 4 columns of numbers, making it 16 numbers. 
i-hat and j-hat are the basis vectors, they are the default vectors which the space is built upon. i-hat is a value of (1.0, 0.0). And j-hat is a value of (0.0, 1.0).
## Linear Transformations
--------------------------------------------------------------------------
Linear transformations are a transformation of the basis vectors. The transformation must not leave any vector curved, it must keep all grid lines parallel and evenly spaced, hence the name "linear transformation". A linear transformation can be described using with a matrix2x2, or any size matrix but for this example, I'm going to be using a 2x2 matrix:
[a, b]
[c, d]
And now let's multiply a vector by this matrix, this would give us a new vector that was transformed by the matrix. Let's take a vector of [2, 3].
And let's take a matrix of:
[1, 2]
[0, 1]
We would multiply the first element of the vector by a, and the second element by b, and then add those together, and that would be the first element of our new vector, which would be 8. Similarly, we would then multiply the first element of the vector by c, and the second element by d, which is the second element of our new vector which would be 3. So our new vector which was multiplied by the matrix would be: [8, 3].

And if we did this transformation on the basis vectors, the a and c is where i-hat will land, and the b and d is where j-hat will land; the basis vectors dictate the position of every other vector in the vector space, so the only thing needed to describe a linear transformation is where the basis vectors end up.
A matrix is just a set of weights to apply to a vector.
## Matrix Multiplication
--------------------------------------------------------------------------
To multiply two matrices, we'll need two matrices. Let's take a matrix, let's call it M1, who looks like this:
[1, -2]
[1, 0]
And let's take another matrix, let's call it M2, who looks like this:
[0, 2]
[1, 0]
This is going to be a lot like multiplying a vector by a matrix, but four times. We'll use this formula:
$[a, b] * [e, f]$
$[c, d]  * [g, h]$
=
$[a*e + b*g,  a*f + b*h]$
$[c*e + d*g,  c*f + d*h]$

If you still don't grasp this concept fully, then check out this website: http://matrixmultiplication.xyz.
## The Determinant
--------------------------------------------------------------------------
The determinant is a number which represents how much space has been squished down or stretched out by a linear transformation. Let's take a transformation:
[3, 0]
[0, 2]
This transformation would stretch i-hat by a factor of 3, and j-hat by a factor of 2. Imagine a square with a length of 1x1, resting it's edges on i-hat and j-hat. The transformation would stretch this square by 3x2, making it 6. So the determinant of this transformation should be 6.
Computing the determinant is quite simple with this formula:
$a*d - b*c$
This given transformation scales a and d, so multiplying them would give the determinant. A transformation could also scale b and c, so we have to multiply those as well and subtract it from the first part. A determinant of zero would indicate that all of space has either been squished down to a line or onto a single point.
## Inverse Matrices and Terminology
--------------------------------------------------------------------------
The inverse of a matrix would reverse it's linear transformation. For example, let's take this matrix:
[1, 1]
[0, 1]
This matrix is called a shear and it tilts j-hat in the x-direction. To reverse the effect that this transformation has had on space, we will need it's inverse matrix which would look like this:
[1, -1]
[0, 1]
This would be useful for solving a problem where you know the matrix that a vector has been multiplied by and you know the output vector, but not the vector itself. So, you would inverse the matrix that the vector has been multiplied by to get the value of the vector.

The length of a vector is the distance between its tip and its tail. (The two points of a vector).
The length of a vector: [1, 1] would be the square root of 2, since a right triangle with sides of length 1's hypotenuse will also be the square root of 2. This topic is covered at greater depth in [[Trigonometry]]. 
Finding a vector's length is a lot like finding the hypotenuse of a right triangle, it pretty much is.
Square all components of the vector, add them, and take the square root of the result.

Nullspace is a term which means that if a transformation's determinant is zero and it squishes all of space down to either a line or a single point, the line of vectors in the direction it gets squished in would all be null, all these vectors are called nullspace.
The rank of a transformation denotes its dimensions. A transformation which would leave 2d space as 2d and all the vectors would have a space, would have a rank of 2, which means it is 2-dimensional. This is the best a 2d transformation can get. A transformation that squishes 3d space down to a 2d plane, would also have a rank of 2. This is not ideal as we would want 3d space to remain 3d, but this wouldn't be as bad as a transformation with a rank of 1, which would squish space down to a single point.
### Footnote: Non-square matrices
The most important non-square matrix we'll be talking about is the 1x2 matrix. Which looks like this:
[1, 2]
It just looks like a rotated vec2x2. And if you apply this matrix as a linear transformation, it will squish all of 2d space down to a number line. I-hat will be at the number 1, and j-hat will be at the number 2. 
## The Dot Product and The Cross Product
--------------------------------------------------------------------------
The dot product of two given vectors can be found by this formula:
$$vec1.x * vec2.x + vec1.y * vec2.y$$
And the dot product has a geometric interpretation. If you project the first vector onto the line of the second vector, multiplying the length of this projection and the length of the second vector, you get the dot product. But when the projection is pointing in the opposite direction of the second vector, the dot product will be negative.

**SUMMARY**: The dot product is pretty much how close the vectors' tips are to eachother. If the two vectors are perpendicular to eachother, the dot product is 0, and if they're on the opposite directions, then the dot product will be -1.

The cross product is a mostly 3d thing, and the cross product of two vectors can be imagined as a parallelogram between the two vectors, imagine the tail of the first vector moving over to the tip of the second vector, and the second vector's tail moving over to the tip of the first vector; this forms a parallelogram. To compute the area of this parallelogram, we can form a matrix with i-hat's coordinates as the first vector's coordinates, and j-hat's coordinates as the second vector's coordinates. Then we just compute the determinant of this matrix. The intuition for this comes from the fact that the determinant of a transformation of i-hat and j-hat should be the same as this matrix.
Now all of what I've said was mathematically fine but it was technically not the cross product. The true cross product is something that combines two 3d vectors and forms another 3d vector. This 3d vector's length will be the area of the parallelogram, and the vector's direction will be perpendicular to the parallelogram, but which way? Point your index finger in the direction of the first vector and point your middle finger in the direction of the second vector; when you point your thumb up, it should reveal what way the 3d vector should be in.
## Eigenvectors and Eigenvalues
--------------------------------------------------------------------------
Take any linear transformation and think of a vector in space, the direction the vector sits in is called the span. And if the linear transformation is applied, then most vectors get knocked off their span. But some vectors don't. For example, take this transformation:
[3, 1]
[0, 2]
In this transformation, a vector of (1, -1), will remain on it's span, it will only get stretched by a factor of 2. In this transformation, this vector would be an eigenvector, and it's eigen value would be 2, since it was lengthened by a factor of 2. 