Collision detection is all about detecting collisions between objects.

# Phases
---
There are two phases to collision detection, the broad phase and the narrow phase.
The broad phase is responsible for breaking the scene down into chunks that the narrow phase can work through. 
The broad phase forms a hiearchy of objects, there are many data structures that the broad phase can occupy but let's just assume that you're using a binary tree for simplicity. Every object is a leaf node in the binary tree, and objects that are near eachother will get placed in a parent node, and parent nodes that are close together will get placed in another parent node and so on and so on.

This is all being done because checking each object against every other object is a waste of computational power because an object needs to check against every other object, including ones that are nowhere near it, and this creates an algorithm that is O(n²) which is bad.

The narrow phase then checks if objects are actually colliding, this requires more expensive checks and the narrow phase goes through the binary tree of objects and only performs tests on leaf nodes that are inside a parent node

# Broad Phase Algorithm
---
To make a 2d broad phase collision system, I'll be using a binary tree of AABBs, each leaf will be represented with an AABB and parents will also be represented as an AABB.
The tree will not be constructed per se, but you will be able to add leaf nodes into the tree and the tree will sort these leaf nodes and make parent nodes for them.
The insertion algorithm will follow a structure like this:
1. Find best sibling for the new leaf
2. Make a parent internal node for the new siblings
3. Propogate updates up the tree to make the AABBs encompass their children

## Finding the best sibling
First of all, I would like to make a function that computes the cost of a tree

```cpp
float ComputeCostOfTree(const Tree& tree)
{
	float cost = 0.0f;
	for (int i = 0; i < tree.nodes.size(); ++i)
	{
		if (tree.nodes[i].isLeaf == false)
		{
			cost += AABBPerimeter(tree.nodes[i].box);
		}
	}
}
```

This makes it so the cost of a tree is directly related to the surface area of all the AABBs in it.
Why is the cost of a tree being calculated like this? I have no idea, it makes it more efficient for ray casting I guess since the chances of a ray colliding with a tree are proportional to the surface area of the tree.
But now we have a simple goal in mind, to find the sibling that adds least cost to the tree.

![[Tree.png | 400]]

Take this tree for example, we want to insert a leaf node: L into the tree, evaluating the cost of inserting L into every single node is costly, and completely unneeded.
We can speed up the search by evaluating just two nodes at a time, because a parent node that is worse than another parent on its level will not have any children that would be any better than the better parent's.
I want to introduce a notion here, the union of two AABBs is an AABB that encompasses both of them.
I'm too lazy to summarize the algorithm here, just look up Box2D insertion algorithm.
# Manifold
---
A data structure in a physics engine that stores the information about a collision is called the manifold, it can have many things, penetration depth, the contact point and the:
## Collision normal
The collision normal is the direction in which the 1st body will get pushed at the resolution of collision, the other body will get pushed in the opposite direction.
If a ball gets in a giant stationary rock, the collision normal for their collision will be a vector that starts from the circle's center and points outward from the rock, this force will get imposed on both the ball and the rock, but it won't do much to the rock, since it has a much greater mass
