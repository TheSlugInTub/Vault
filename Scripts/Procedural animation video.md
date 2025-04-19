Title: Recreating Rain World's procedural animation system in my game
Thumbnail: To be worked upon

# Script:
---

So, I've been playing a lot of a game called Rain World recently, it's amazing and you should play it. But one of the things that fascinates me most about it 
are the procedural animations. The creatures in Rain World are not animated by a sprite sheet, but they're animated by code, a standard Rain World creature 
is made up of a couple body parts which act as springs and sprites are attached to these body parts to render creatures. I really liked this approach since I
didn't have to draw character animations, which I'm really bad at.
So today, I'm going to be making some procedural animations for my game. [Intro]

So for this little recreation, I am going to be using my own game engine and my own physics engine, which I devloped in my last two videos. The Rain World devs
used Unity, but Unity's boring, and making stuff from scratch is cool.
So the first step in getting started on this is to make a couple points which are going to be the different parts of the body, I added a legs endpoint here to 
control the end position of the legs.
And whenever the legs would get too distant from the original body position, then we would find a new endpoint on the collider which the player is standing on.
But how would I detect the collider?
I thought about doing a raycast down from underneath the leg roots, but raycasts are a bit hard, so I just added upon what was already there in my physics engine
and added a sensor flag to my collider struct, if this flag is set, in the collision detection, a value of sensorCollider would get set to the collider which it 
collided with, this was pretty easy to set up. But then it turned out that the sensors were too close together and were actually detecting themselves, this was 
obviously not very good, so I changed up the logic a bit to make them ignore each other. And they work now, nice. I also added a little change to make sure that 
the legs would dangle in the air if the sensors weren't sensing anything.

I then added a rigidbody, a collider and a sprite renderer to the player object. I then rendered his little legs as two lines.
But there is one notable thing this fella is missing... his arms! So I need to add those, I added them as a rope simulation, and the rope can have an endpoint
that it can snap to, to simulate grabbing items. I copied the simulation over from my previous game engine, always recycle code, kids, it's good for the development enviroment.
And testing it out... [Sensors not detecting second polygon] why is that happening? 
So turns out that the sensors weren't detecting colliders properly, which is pretty weird, since that's their entire purpose!!
The reason this was happening is because the sensors is because in the collision detection, the colliding flag of the sensors would get updated to true or false, based on 
if it has collided with the other collider or not. But since this is run for each collider the sensor collides with. If it's actually colliding with a collider but then 
it gets run on a collider that it isn't colliding with, the 'colliding' flag gets reset, even though it's actually colliding.
My solution to this was to set the colliding flag off each frame, and then I can turn it on if it collides with something.
They work now, great!

But here, I realized something... this doesn't look like Rain World at all!! This is utter garbage. The player isn't dynamic, and the legs look horrendous.

So grim and demotivated, I looked towards something which I should've thought about since the very beginning, springs. Any dynamic physics body, or soft animal
is entirely composed of springs that pull, push and maintain the shape of the body. But for that, I will need to implement circle collisions, it's pretty embarassing,
but I haven't actually made the circle-polygon-test yet [Show image of circle-polygon-test with TODO]
And the first attempt didn't go too great, but it almost never does and I eventually got them working.

Then I made a function for adding a spring-force to a body, which maintains a rest length, between several rigidbodies.
And this was the result: [Joints]
Made them smaller: [Smol joints]
But then I realized I couldn't make the head stay on top of the body with springs, so instead of springs I replaced the connections of the body parts with smooth
interpolation.
But our guy's lookin a bit limbless right now so we need to give him some legs! For the previous legs, I was just using two points a root point which was static and an endpoint,
this didn't look too realistic of course because not many of us walk like this: [funny clip]
So instead of 2 points, I'm going to use a whopping 3 points! And these 3 points will be controlled by inverse kinematics, and for the IK, I implemented the FABRIK algorithm.
And the FABRIK algorithm is actually pretty simple, for a series of lines and an endpoint, it starts at the end and places the end of the line at the endpoint, then we put the
direction of the vector towards the base of where it came from, we repeat this for the next lines and put them at the end of the first vector and point them towards their 
base position as well. 
We do a second pass of this but instead of starting at the end of the list of lines, we start at the front. That's why it's called forward and backward reaching inverse kinematics 
and not forward reaching inverse kinematics, which would be FRIK!
With all this theory aside, let's put it into practice.
And that doesn't look too good, does it?
This was happening because all the points were -nan(ind) for some reason.
This was just a silly mistake in the code because I resize the vector of points but I don't actually initialize them to anything.
So I just initialized each point in the vector and it works now.
Then I attached this IK to the legs and it looks great!
But one thing I don't like about this technique is that both legs move at the exact same time, since they only need to move as far away from their leg roots. Since they move
at the exact same speed of course this was going to happen. So I added a static bool of which leg is active and a timer to ensure each leg has to wait before its own turn.

And I added a leg collider which is a circle to make us get off the ground, also I made a new spring function that is much simpler than the previous one and also works a lot better 
and it's much more stable since it doesn't actually use the physics system, it just bypasses it but don't tell anyone that, shh..

After approximately two seconds of testing, I realized that the head just goes right through any collider, and I needed to find a way for it to... not.. do that, so I thought
and I thought for a while and after some more thinking, I came up with something: resLinks. resLinks or resolution links are a way for a body to get the same resolution as 
another body, which means if a collision is detected for a body, the collision will get resolved for that body and if a resLink is active the resLinked body will also get the same
resolution as the base body. It's useful for linking springs together. And also this is coming completely out of my arse, I made this up in two seconds.
So with this stupid  idea, it sort of worked, which is really I could hope for.
Then I added some sprites to the different springs of the body making it look more like a Slug Cat, and leg rendering. The legs are just rendered as a 3-point line, nothing fancy.
I also added some cute eyes which blink every 3 seconds.
And just look at this little goober, he looks adorable!

Now time to get my hands on some hands, I added the hands as another array of two IK solvers. With an endpoint a couple inches away from the player.
There are two bools dictating if a hand is free or not. And the hand doesn't render if it's not holding something... actually I was too lazy to make that look good so,
I just made the endpoint inside the body whenever it's not holding something, so it wouldn't be visible.
But what's the point of hands if there's nothing to get your hands on? So I added two sensors to the hands to detect stuff, and whenever the sensors come across a body with a
body with a physics ID of 500, only then does the sensor sense anything. And the body get's its position put into an array of heldObjects and gets held in the hand.
You can also throw the item by pressing x.
Another thing I wanted to add was crawling, since it's pretty cool. I added a player state enum to control what state the player is in.
And made the springs go either left or right depending on the player direction, instead of up to make the player look like he's standing up.
You can crawl by pressing the down arrow, and get back up again by pressing up arrow. The speed also decreases.

One final thing I wanted to add was shadows, since I really like the shadows and lighting system in Rain World, and the shadows in that game are actually pretty simple.
Or atleast I think that based on this tweet by the lead programmer. The first step is to take a grab pass of all the rendered sprites,
You have to loop over all the pixels in that sprite and the background texture, and if a pixel has a color that's anything other than black, we have a shadow there, and
can dim that background pixel to create a little shadow.
We also have a depth texture to indicate which parts of the background are nearer or farther away from the camera, and we offset the shadow position 
based on that depth value.
But for shadows on a background, I would need a background in the first place, so I quickly whipped this abomination up in aseprite in like 5 minutes, and also created 
a depth texture, the red color channel indicates depth here.
And for the technique I was going to use, I would need to render every drawn sprite to a framebuffer, I then pass the frame buffer texture to a background shader which 
will do the shadow calculations and then I would render the frame buffer as a quad that covers the screen because I don't want all non-background sprites to not be visible.
And voila! We have faux shadows. This took me two days to add.

And this is pretty much where I got, as of late. This has been a super cool and fun project for me. And if you want to see me develop this game further, 
and do more cool stuff like this in the future, then please like and subscribe to the channel
to help me out, as that pushes this video in the algorithm. So, hopefully you enjoyed this video, and I'll see ya in the next, see ya.

# Timeline:
---
I was inspired by rain world, to make a biomechanical explosive rat idea. 
Yaps about the idea.
I'm gonna use my own engine and my own physics engine for this game.
I began work on the IKsolver in my own engine.
I added sensors to sm2d because I needed to do a circle cast with the ground.
The sensors were detecting themselves so I needed to stop that.
They work now!
yipee!
I also made a little change so that legs dangle in the air when the sensors aren't colliding.
I then added a rigidbody to the player.
I then added a sprite and rendering to the player and added legs.
I decided to make a rope simulation for the hands, I used verlet integration for the simuation.ther
Yaps about the simulation.
The first result didn't look so great. [Broken legs and arms]
And look! Now it works!
And then when I try to step on a different polygon, the sensors don't recognize it anymore... great! [Sensors not detecting second polygon]
I realized that the BVH representation of the sensors were not moving. [BVH nodes of sensors not updating]
This was because the sensors were not awake and bodies that aren't awake don't get their BVH node updated, so I added a check to the update skipping to make sure sensors don't get their updates skipped. [Sensors fixed]
But I had no way of checking if the sensors were actually colliding with something or not which is weird because that's its entire PURPOSE.
Because when I tried to set a flag called colliding off when a collision is not detected, it would override when the flag is turned on so it becomes useless.

I fixed this by setting the flag off each frame and letting the collision detection turn the flag on, on sensors that are actually colliding. [Turn sensors' flags off each frame]
And now it works well, very nice!!!
I also fixed the movement in that there's a max speed, acceleration and deceleration instead of just increasing the velocity each frame you hold 
down the arrow keys. [Leg IK working and proper player movement]
I then realized that what I am doing is completely trash and everything I've done so far is utter garbage.
I took a closer look at Rain World, and used dnSpy to look at its code and wrote a little document detailing on how the procedural animation works for the slugcat. 
It was a bit too complex for me to understand most of it but I got the general idea.
So this time I actually needed to implement circle collisions and the first try wasn't too great. [Broken circle collisions]
I got them working les go! [Working circle collisions]
Then I made joints [Joints]
Made them smol [Small joints]
But then I realized that I couldn't make the head stay on top with the joints working the way they are, so I replaced the joint with smooth interpolation to the head position.
Then I implemented actual inverse kinematics with the FABRIK algorithm.
Yaps about fabrik.
So with all that theory aside, let's actually put it into practice!
IK wasn't working, I realized that all the points were -nan(ind)
I realized that this was because I had resized the vector to the size, but hadn't initialized any of the points. [Broken IK]
I got it working les go [Working IK]
I attached the IK to the legs and now they work with IK, great! [Working LEG IK working]
But clearly there is a problem, the legs both move at the same time, this isn't realistic so let's fix it!

I added a static bool and a timer to make sure that one leg can't move if the other is moving.
I also added a leg collider that is just a singular circle, to make sure that we keep away from the ground. I also added this new spring function 
which is a lot simpler and using it on the different parts of the body, it looks great! [Added leg collider and better body spring movement]
And then I did all of this, all the Ik, all the endpoint bullshit just to realize THAT THE LEGS IN RAIN WORLD ARE JUST ANIMATED SPRITES,
THE GAME DOESN'T EVEN USE INVERSE KINEMATICS!!
But I think it looks good and it's less effort than making 50 sprites anyway.

But then I realized something, you just phase through a wall when you walk through it with your upper body, at this point I was really close 
to giving up here, because there were just so many problems and little bugs that popped up that I needed to fix or I couldn't fix them at all.
And this is just what comes with building your own engine, it's not bug tested at all, and it's a steaming pile of spaghetti code.
So just as I was about to give up, I had an idea: res links, res links or resolution links are a little thing I came up with on the spot that links two rigidbodies' 
collision resolutions so if one body's collision manifold was resolved, the resLinked body would also get resolved. And with this simple little idea, 
it sort of worked, and got my motivation back up. [Commit before resLinks]

I then added sprites and white legs to the character, making it look more like a slugcat, 
and also added a blinking animation and just look at this little goober, he looks adorable [Added sprites]
I tried to add handIK but got this result: [Broken hands]
And then I made the hands shorter and I added items, which have a physics ID of 500, I added an item sensor,
which only detects rigidbodies with an ID of 500, and made you pick them up with putting the item in the endpoint of the selected hand, 
and the hand only shows up if you're picking them up, just like in Rain World. [Fixed hands with picking up and throwing items]

Then I made crawling, I added a new player state enum and the spring forces get applied to the side when the player is crawling, 
you can crawl by pressing the down arrow key and and you crawl way slower than you walk, then you can stand back up again by pressing the up arrow key.
Your legs and ands also go in a different root position when you crawl. [Crawling and continuous tile placement in tilemaps]

Then I tried to replicate the shadows and lighting of Rain World. Rain World actually has a pretty simple shadow system,
or atleast I think that based on this tweet by lead programmer. You have to take a grab pass of all the rendered sprites,
loop over all the pixels in that sprite and the background texture, and if a pixel has a color that's anything more than black, we have a shadow there.
We also have a depth map to indicate which parts of the background are nearer or farther away from the camera, and we offset the shadow position 
based on that depth value.
For this I would need to render every drawn sprite to a framebuffer, I then pass the frame buffer texture to a background shader which will do the shadows
calculations and then I would render the frame buffer as a quad that covers the screen because I don't want all non-background sprites to not be visible.
And voila! We have faux shadows. This took me two days to add.

And then I needed to make some levels of course, so I researched how Rain World does its beautiful levels and it basically 
takes a collage out of hand-drawn elements and mashes it 
together into a .png whose red channel has pallette information and this .png is colored in real-time with a pallette png.

So I made a new project using salmon engine called RatEditor which will be the level editor of Bombratter. [Fixed up the project]
In the project I made three panels, one for the tilemap which is kind of useless, one for the tray which holds the layer [Slightly working tilemap placement]
of the tile you're placing, and one for the actual tiles that the editor is going to render out in the .png.
I made a system which asks you for textures to render the tilemap with. You then place down these dummy textures into the tilemaps to act 
as simplified walls/materials.
And then I made a screen width and screen height parameter to control the size of the final image.
I used the stb_image_write.h library, I know it's not particularly fast or efficient but it's simple, ok? And that's all that matters.
And finally we have an image rendering to a .png!!! [FINALLY, OUTPUT PNG LETS GO!!]

And then I also added so you could hold P to place down a box of tiles for conveniance. [Tilemap box placement]
I also made it so you can delete tiles within a box by holding down P and delete, and add them back with P and O.
My fingers are completely cramped now, but that's just the cost of having an unfinished, poorly documented and poorly designed internal level editor. 
**DON'T WORRY I'M GONNA POLISH IT UP AND MAKE YOU ABLE TO USE IT** [Tilemap box removal]

And then I made the tile texture into this weird red abomination, now you might be wondering 'What the hell is this?' But this is tile is 
actually going to be colored in by the game in real-time by a palette. A palette is a .png which stores the colors of how everything is going to look.
I only have the sky box color, the plants color and the terrain colors at the moment, but I'm sure I will add more in the future.
And I wrote a little document explaining how the level png's red channel is going to be used for the palette information.
If the red channel is below 80, then we divide it by 5 and get the corresponding terrain color in the second row of the palette.
And I spent WAY too long trying to get it to work. But it was just not working. I tried to use GLSL's texelFetch but it was just returning empty,
[Broken palette rendering]
and I looked upon stackoverflow, reddit, and god forbid... even the second page of google, yeah I was desperate.
But after all this, I realized that the texture coordinates in texelFetch are REVERSED, this means that instead of 1,1 being at the top-left, it's at the bottom-left.
But after fixing that up, it works now. [Fixed palette rendering!] And hey look at that, I can even adjust the colors

And then I made rule tiles for the terrain. And if you don't know what rule tiles are, they are tiles that adjust their texture based on the tiles around them.
I whipped up 13 tile textures for all the combinations I need. And made some logic to check every tile to see if there is a tile above,
below, to the right, to the left or to 
the corners of the tile, ok.. I know it's O(n2) but it's an internal tool ok? It doesn't need to be fast.
So if there is a tile in any of the directions, set that direction in a directions array. And we do some logic to
check what texture a tile should be for its directions.
And testing it out... It doesn't work. Obviously, why would it. And I spent about a day or two wondering where in my life, did I go so wrong? [Broken as ever]
And then I finally realized that I missed two lines of code in this function, of course I did.  [Fixed logic tiles]

And then I wanted to add tile colliders so I could actually interact with the world.
The technique I'm going to use for this is that I loop over each pixel of the background image, and if the pixel's red channel is below or equal to 80, then 
the whole 16x16 tile was a collider.
And I store a map of tile colliders in a 2d grid. I then merge these colliders, so there aren't just a million colliders for each tile. 
And I finally create entities and add colliders to them. But as you might expect by now, the code didn't work.
And I spent yet another two days on the tile colliders trying to understand why the game was crashing... 
EACH... GODDAMN... TIME I tried to run the code. And it was a different error each time too.
Something was going wrong with the image data I was looping over which was supposed to be the background sprite. 
But after using stb_image_write to inspect this data. IT WAS THE GODDAMN PALETTE TEXTURE AND NOT THE BACKGROUND SPRITE.
And then finally it worked. [Fix broken tile colliders]

But then I realized something, my custom physics engine is very unstable, and it would be a bad move to go forward with it, 
because it's not ever gonna be as good as Box2D. So I started integration on Box2D into the engine.
So it took about two days to get the box2d integration working, and it's all in the physics_2d.h and physics_2d.cpp files of the engine.
And also I spent about two hours wondering why it kept crashing, with, you guessed it, a different error each time.
This time it turned out that I wasn't intitializing my pointers to null, so they got filled in random gibberish.
Initialize your pointers kids, it'll save you 4 hours of debugging. [Working Box2D integration]
And then I added box2d rigidbodies and colliders instead of sm2d and it worked well! I still need to use box2d for the player tho.
[Working Box2D items and level colliders but not the player]

Then I began to port all of the player sm2d code to Box2D, and for the longest time I wondered why it kept crashing when i added springs, but then I realized
that I was making the springs before I even created the bodies (calling the start sys), which was very stupid.

But one thing I was really starting to get annoyed at was the compilation speed, it took about a minute for every single goddamn change to compile.
So I did what any sane person would do, I rewrote the whole project in C. I made all the basic utilities like a vector class, and I also tried adding cimgui to the project 
but I just couldn't get it to work with the project, so I made my own C bindings for ImGui, I also made C bindings for nlohmann::json library, since I couldn't find a 
good json library for C. The only thing I didn't write in C was the ECS. Since writing an ECS in C is the best way to waste a year of your life.
