Title: I made a 2d physics engine from scratch.
Thumbnail: To be worked upon
# Script:
---
So in the previous video, I made a 3d game engine, and I added 3d physics to the engine using the Jolt physics library, but I needed to add 2d physics too, since I want to have both 3d and 2d in the engine. So I thought about using Box2D, which is a super popular physics engine that everyone uses, but I heard a story online about how the developers of Rain World had to build their own physics engine because Unity's physics (which is Box2D), didn't support what they were going for, so I decided on building my OWN physics engine, since I want to make a game like Rain World.
The first part of getting started was to add a sprite renderer component, since 2d rendering doesn't currently exist in the engine. And so I quickly got a test scene up and running. [scene]
And then I made a rigidbody component, and a rigidbody is just a physics object, which doesn't get deformed. [Rigidbody component code]
And I made a system to loop over all rigidbodies, and apply newton's laws to them. d
Velocity is equal to force divided by mass, and position gets incremented by velocity every frame.
AngularVelocity is equal to torque divided by mass, and rotation gets incremented by velocity every frame. [Rigidbody system code]
And they're all multiplied by deltaTime, since that's the time it took for the frame to finish, and if it wasn't multiplied by deltaTime, the physics would run way faster at higher framerates, since there would literally be more physics cycles every second.
Now the dynamics are working, but that was just the easy part, now we're gonna look at collision detection. [Cue the title card]
To keep things simple, I only added an AABB or axis aligned bounding box for now, and if you don't know what that is, it's basically just a box that doesn't rotate, since rotations are hard.
And to detect collisions between two AABBs, I made this function to provide some data for the collision, and this collision data is also called a manifold. [AABB col detection code]
And the final result looks like this: [dynamics and AABB intersections]
As you can see, it doesn't look all that great, it kind of looks like we're floating in water, and the reason this is happening is because I implemented a sloppy solver that just pushes the body upwards whenever a collision is detected. [Show old solver code]
But at least the collision detection works, which is great.
And the way that the collision detection is working right now, is that I'm checking every rigidbody with every other rigidbody to see if they're colliding, this is the most simple solution that you could come up with, but it's also the worst, since if you have four bodies, you'll have to perform 16 checks, even when two bodies are extremely far away, you still have to perform the check for them with the other bodies, since you can never be sure if they're colliding or not. And this solution has a big O of n squared, which just means really bad.
So, how do you come up with a better collision detection algorithm, seriously, I'm asking you because I have no idea-.

And to google, I went, in search for better algorithms and I came across an algorithm called search and prune, where you only search for collision on certain axes, then I came across another called quadtrees, where you divide the world up into boxes, and for any rigidbody, you want to create four more boxes inside the box that the rigidbody is in, and want to descend down this tree, checking for any box that has more than two rigidbodies. But then I wondered what technique Box2D used, and realized that they used AABB trees, AABB trees are a spatial partitioning technique where you enclose every rigidbody inside an AABB, then you enclose two or more rigidbodies inside an AABB that encompasses both of them, and you want to keep going until you have every rigidbody enclosed inside a root AABB. 
This sounded interesting, so I went with it, and I found this paper on AABB trees which was written by Erin Catto, creator of Box2D, the frickin man himself.

And the AABB tree would work like this: we insert a rigidbody into the tree, and the tree finds the best possible sibling rigidbody, and make a new parent AABB for both of them, and adjusts the ancestor AABBs to fit the new parent.
And the way that the tree finds the best sibling, is that it descends down the tree from the root node, and checks both children to see which one would have less perimeter length if they unionized, and the one with less perimeter length is descended down upon, until we reach a leaf node which has the least perimeter length and we can make that the sibling

And so I followed the paper, implementing the AABB tree, and eventually it worked, the tree removes and re-inserts rigidbodies that have moved into it, so it can be updated.
But enough talk, I haven't actually implemented the traversal of this tree to detect collisions which is kind of the entire point of the tree, so I made a function which goes down the tree and any AABB that it finds which has two leaf nodes in it, will be performed a check on, and it will add the manifold to a vector of manifolds which it then returns. I also made a solver function to solve all these manifolds, adjusting the positions of both objects to distance themselves to resolve the penetration. 
And testing it out, it's pretty much working now, [collisions not being detected], wait noo... *it's not working*. And after a day of banging my head against the wall, I realized that with the way my collision detection algorithm works is that it only performs a check on two bodies that are inside an AABB, which means if a body is further up in the AABB tree, it's not going to check if the lower body is colliding with the upper body because they're not in the same node, so I adjusted my algorithm to be recursive in checking for bodies, and it finally works.
And then I added circles, to diversify our collider space a bit, they're pretty cool but they don't roll around which is a large part of a circle's identity. So I added angular velocity to the solver and now they roll around, very cool, [angular rotation].
And while having AABBs is nice, they get kind of boring since they can't be rotated, which isn't very realistic, so instead of having axis aligned bounding boxes, we need to have object oriented boxes, or OBBs. These things can rotate which is just what we want. And I tried really hard to implement these guys, but they just weren't working out for me, either it was having a seizure, **pause**, or it was transcending the mortal plane and phasing through reality, this little guy was just not a big fan of newton and his laws, so I scrapped OBBs. And began work on polygons, Box2D also uses polygons, not OBBs, so I'm really just copying everything from it,
and I represent the polygon as a vector of points in local space, and a vector of points in world space, the local space points don't move, but the world space points do. And the local points get converted to world space when it moves or rotates.
And for the polygon collision detection, I used the seperating axis theorem, which states that if two objects are not colliding, there must be an axis where two points of the objects is seperated.
The way the algorithm works is that I project each point of object 1 with every other point of object 2 on a single line, and see if these two points overlap each other on the line, and if they do the objects are colliding, we re peat this for both objects. And after implementing the algorithm, this is the result. 
The polygons are just squares in this clip, but they can be any convex polygon, since the seperating axis theorem only works for convex polygons.
I swapped one polygon out for a triangle, and huh, that seems a little weird, the triangle's just bouncing around.
I'm gonna be honest here, I have no idea what I did to fix this, but it works now.
Also to improve performance, I added an awake flag, any body whose velocity is less than a certain threshold, they haven't moved, and in the collision detection, if both colliding bodies haven't moved, then they're both put to sleep, but if one has moved and the other hasn't, then the sleeping one is set awake. It's a sloppy solution but it works for now.
And that's pretty much it, thanks for watching, I hope you learned something from this video, I know I did, and if you've made it this far in the video, please consider subscribing or liking the video, as that helps me tremendously, also this project is up on github, it's in the Salmon-Engine repository in include/sm2d, also the engine has changed a lot since this video, because I've been working on it, and hopefully I'll see you in the next video, see ya.
# Timeline:
---
I modified salmon engine to add 2d rendering and made quick 2d scene
I made dynamics
"Checking every pair is not performant"
'Yaps about aabbs and trees'
"I made a reddit post"
"I found this PDF about aabb trees by erin catto, the creator of box2d"
'Yaps about AABB trees and the insertion algorithm'
"I tried to make an AABB tree but it didn't work"
"It worked"
"I made it so it only updates bodies that have moved by removing and reinserting leaves"
"But it doesn't remove the elements from the vector"
"But removing elements breaks the indices of the entire tree"
"I made it so it doesn't do that"
I made a function that recursively searches tree for colisions
"So it's pretty much working now and no.. no.. *in a tired sighing voice*, it's not working :("
"Oh but collisions not being detected oh no"
"My collision detection algorithm is bad and here's why, it only checks for collisions if two leaves are in a single node, meaning if the ground is a leaf of the root node and the two boxes are children of an internal node, then they won't detect collisions with the ground"
I made a reddit post about this
This guy said something that fixed my problem
"This is what he said: you want to check if two internal nodes are also colliding instead of just leaf nodes, and if they are, then check for collisions between their leaf nodes."
"Now we have the foundation of the physics engine pretty much done, all I need to do is to create more colliders and add rotation on collision resolution"
'I added a circle collider, but it gets rendered as an AABB because rendering circles with debug lines is quite stupid if I'm being honest.'
"But there's one thing that's sorely missing, rotations, the collision resolution isn't actually adjusting the rotations, and that's not really realistic."
'Yaps about OBBs'
'I tried to add an OBB collider but it didn't work and it just was tweakin all over the place'
'I turned off gravity trying to fix it' [Show clip of obb box without gravity]
'I tweaked some settings until it fixed itself'
"Atleast it works a little better now" *Objects are phasing through the ground*
"But after a couple days of failing, the best solution I could come up with was to treat the box as all of its points and segments, which I could check against each other, which could work on literally any collider, so I scrapped OBBs and started work on polygon colliders instead."
'Yo look I got AABBs working for polygons, yaps about how I made it work'
'There still isn't any collision tho and that's what I'm gonna implement'
'I tried to implement collision for days but it didn't work'
'One more reddit post later, I realized I was being stupid and testing collision on the same object'
'I got polygon intersection to work yipee'
'Oh no they're broken when intersection with ground'
'I realized that I wasn't normalizing the axis projection where all the points of the polygons get  projecected to'
'YAY it's fixed'
'Oh no they speen'
'Turns out my contact point calculation for the polygons was wrong'
'I fixed it by calculating the contact points correctly instead of incorrectly'
[Show cool physics sim]
'I need to make it faster by setting objects asleep if they stay at the same position'
'I did this by checking if it has moved, rotated or been imposed a force in the last frame'
'I also made it so collisions set things awake'
'But there is a problem now, if the objects are on ground, they will never sleep. I needed to figure out if collisions carried over from last frame'
'I just did a little hack here, where if the angular velocity or the linear velocity is more than a certain threshold, this hasMoved flag gets turned on, and in the collision detection, if two bodies havn't moved then we set their awake flag to false, and if one body has  moved and the other hasn't moved, then we wake both of them up, this is probably quite garbage but I can't be bothered to fix it.' 
'But something weird is going on with the triangle, it's just bouncing around wildly at the minute but eventually does come to a stop, I have no idea what I did to fix this but it's far more stable now.'

'Compilation of nice and cool physics at the end of the video'