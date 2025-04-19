# Programming lessons

## Box2D

I was once struggling to get bodies moving in Box2D. Turns out, I was skipping to create colliders,
I was checking if the shape was valid and if not, skip creating the shape, which was very stupid.
Also you need to add a shape to a body for it to properly interact with the world.

Don't erase the box2d bodies of a scene after you clear the scene dumbo!

DONT FORGET TO NULL THE IDS YOU DUMBO!!

DONT DESTROY THE BODY BEFORE YOU DESTROY THE SHAPE YOU DUMMY!

## OpenGL

don't render something without doing shader.use() first.

check whether the camera has drifted too far from your keyboard mashing before deciding that something isn't rendering.

## Jolt

Whenever doing a raycast, check whether the ray is detecting the raycaster before saying that it always returns true

## General
 
PLEASE CHECK IF A LIBRARY .DLL or .LIB IS ACTUALLY CORRECTLY COMPILED BEFORE DEBUGGING DUE TO A PROBLEM RELATING TO IT.

