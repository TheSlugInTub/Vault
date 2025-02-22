Title: Making an FPS game from scratch
Thumbnail: Screenshot of game with text: 'No engine' (Placeholder)
### Script:
---
So I've made a couple 3d first person games in the past, but they were made in Unity which is a game engine which does a lot of stuff for you, but today I'm not gonna use a game engine, I'm gonna be building a first person shooter completely from scratch in C++ and OpenGL.
[Title screen with cool music and coding in the background]
First I had to set up a new C++ project which was relatively simple, and I want this engine to have an entity component system architecture, if you don't know what that means it means that we have entities which are IDs, we can attach components to these entities which are just data, and make systems to loop over entities with specific components, it's very fast and efficient and also organizes data very cleanly, which is why I'll be using it. I implemented a basic entity component system in the ecs.h file of the engine, following this amazing article online: [placeholder]
We have a scene which holds all the entities and we can create entities and add components which are structs to them, I also have a little scene view here which can loop over all the entities in a scene with certain components. But with all the boring foundation stuff set aside, let's get into rendering.
I'll be using OpenGL for the rendering here, because it's pretty much the only graphics API I've used and I'm lazy and don't want to learn anything else.

I used Glad which is a OpenGL loader, and GLFW which is a windowing library to get the window up and running and voila [shows black window], we have our first window.
But the window is just black, because well I haven't rendered anything to the window
And so instead of rendering a triangle, or a square or any other basic primitive, I deciced to render a whole 3d model, yeahhh and for this I will need to import models, and I used the assimp library to do exactly that. I tried to make it work and uhhh that doesn't look too good [model_loading], I fixed it, and we have a car in the scene, wait where's it going, I really don't know where that car's headed, it's driving on the wrong lane too!
Now I have rendering done, so the obvious next step is physics, to make a proper 3d game you'll need physics. But the thing is I'm dumb, I don't know a single thing about physics and never paid much attention in school. Therefore I just used an existing physics engine which is Jolt Physics, it's pretty good and it works well. 
I switched the scene out for a box and a ground, slapped together an integration of Jolt into the engine, and look at that, beautiful, isn't it?
So the lesson learned here is don't do school and copy other people's work.

[Debug rendering of rigidbodies]I also made a little tool to render the rigidbodies so I actually know where the colliders are, because that's pretty important.

[Capsule colliders] Then I added BEAN, which is gonna be the player.
[Viewport bug] I don't really know what's happening here, I must've been tripping when I made this.

And I started on what any good 3d engine needs, lighting. In the engine, I'm gonna have real-time lighting and shadow casting, and the shadows will work like this, we take 6 snapshots of all around the light source, and then we take the depth values of each of these textures and store them in a cubemap called the depthCubemap. And using this map we can calculate whether a point is in shadow or not, it's a whole bunch of calculations and math but with that all aside, we have working shadows now.
This may look easy when condensed down like this but this took me DAYS to figure out and you could not believe my joy when it finally worked.

[Cool shader effect] And then I just messed around with some shader effects, this is one that makes everything really grainy, it's also running at 2 frames per second because my laptop just absolutely sucks.
[Droopy shader effect] Here's one that makes everything droopy, it looks like you're having a stroke or something.
[Chromatic abberation] I really like this one, it adds chromatic abberation which looks super cool, I'll probably use this for some potion effect or something.

The rendering looks really cartoony at the minute because there's no smoothening in the shadows, it's either you're in shadow or you're not. To make it look a bit realistic, [Phong lighting] I added some basic phong lighting in the fragment shader following this tutorial on learnopengl.com, and it looks much better now, I also left out speculars not because I'm lazy but I don't think the game's style is going to need them.
But one thing that I AM going to need is animations, y'know for the enemies.
And for doing this, I followed this brilliant tutorial on learnopengl.com which details on how to get skeletal animations working with assimp which is the model importing library that I'm using.
And let's just test out the first attempt, [Broken animation] uhhh... what the hell is that abomination.
[Tiny lil man] Alright, second take, wait where is he, ohh look at him doing his little dance, he's adorable.
[Skeletal animation] And I've got skeletal animation working now which is great!

And after getting the skeletal animation working, I pretty much had all the tools I was going to need to make the first person shooter game, which I think I forgot about, a while ago

So, it's time to actually work on the game!
And the first step is player movement, [Crappy movement] which I quickly knocked out, ig- ignore that... [Jumping and player movement] that's more like it!

But there's one thing that's sorely missing here, a gun.
[Gun modelling] So I quickly whipped up a model of a gun in blender, which was totally not inspired by anything, completely original.
And then imported into the game, it was surprisingly easy to do this, which I'm kind of shocked since anything I code immediately breaks within two seconds
But the gun isn't all that useful sitting here out in the open, it needs to be a view model, and for this I would need to compute the inverse of the view matrix which is the camera's matrix and apply that to the model matrix of the gun, why do we need to do this?
It's because the inverse of any matrix cancels its transformation and so multiplying that with the gun's model matrix will get the gun in front of the camera and there we go, we have the gun in front, I also added a texture onto it.
I swapped out the floor for one that better fits the vibe I'm going for and also added an orange light that follows the player, I was trying to emulate Devil Daggers here which is a very good game, also the tile model is ripped straight from Devil Daggers but don't tell anyone that.. alright?
I made a quick little animation for the gun and a bullet model and got the bullet instantiating out of the gun. But it's just shooting out big black bullets, which doesn't really make a whole lot of sense, if I'm being honest. 
Then I got the shooting functionality to work by spawning a lot of bullets and giving them a force towards the camera's front vector, and randomized the force so that the bullets don't just pile up in one line.
A crucial part of most videogames is sound, and so I had to get that up and running in the engine.
For this I used OpenAL which is pretty much just OpenGL but for sound, I used the openal-soft implementation and quickly got sound up and running without much hassle, I also copied the gun sound effect from my previous game because why not.
I also added this little guy, he doesn't do much currently but he's actually an enemy and when you kill him, he dies. I added bullet collision detection which took way too long for me to add.
He doesn't really look much like an enemy right now, so I went on sketchfab and browsed some models until I came across this one, it's pretty good and also has a low poly count, so I imported it in and... you ok there buddy? You seem a bit down here... I don't think he's alright. [kills him]

Next I rigged him up and animated him in blender. 
Then I flipped him upright, and got him animating properly.
But the game is just a bit boring right now, there's no consequence for anything and I added what I had to add, DEATH.
I made it so you have a 3 health and when your health reaches 0, the game just crashes, which gives a good incentive to not die.
And fighting just one enemy is pretty lame, and you know what's better than one enemy? More than one enemy, I just made a spawner that spawns enemies after a set amount of time. And with this the game is pretty much done, it's very simple and very janky and very broken. But it's mine and that's what matters. I learnt a lot from this experience and hopefully you enjoyed this video. I also made a little particle system while writing this script, it looks really cool and uhh bye.