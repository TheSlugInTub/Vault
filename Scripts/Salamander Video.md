Title: Making an island exploration game in my own engine.
Thumbnail: To be determined.

# Script
---


# Timeline
---

So my previous engine (Salmon Engine) which was in C++ was taking really long to compile. 
I was really starting to get annoyed at was the compilation speed, it took about a minute for every single goddamn change to compile.
So I did what any sane person would do, I rewrote the whole engine in C. I made all the basic utilities like a vector class,
and I also tried adding cimgui to the project  but I just couldn't get it to work with the project, so I made my own C bindings for ImGui, 
I also made C bindings for nlohmann::json library, since I couldn't find agood json library for C. 
The only thing I didn't write in C was the ECS. Since writing an ECS in C is the best way to waste a year of your life.

I used assimp to import the models as assimp has a C API.
And I couldn't get the models to work for a day or two but then I realized that I wasn't even using the 3d shader, how silly.
And now we have a very nice chicken.
[model rendering working les go]

I also integrated Jolt physics into the engine with the joltc library which are C bindings for Jolt.

I tried to get shadows to work but OpenGL kept giving me this error that there was a syntax error on line 1 with a p being there.
I checked the vertex shadow shader and there was no p so I was a bit confused. Then I printed the vertex shader code to check it in the engine, 
and alas, there's a p there, I tried removing the first line in the shader. But alas I checked it again and the p was STILL THERE!
[why is there a p there]
So I solved it, the p was coming from me not initializing the buffer in which the shader code sits, always intialized your buffers, kids!

Then I made multiple lights work but I was getting very low framerates, I wondered why this was happening so I reduced my main file
to literally just showing a black screen and the FPS was 170. This is very strange as the FPS on doing nothing should be in the thousands,
not a 170. So I tried removing the glClear which clears the screen and now I WAS getting thousands of FPS. This was very weird indeed.
So I made a post on reddit and learned that my GPU is just garbage. See, I'm using a 4th generation core i5 which was made in the triassic
era and I don't actually have a dedicated GPU so I'm using intel integrated graphics which are slow as hell.
And the reason it was taking so long to render a black screen is that OpenGL is just wasting a lot of time waiting for my GPU to finish 
drawing a black screen and so the main thread is paused until the GPU sends a frame back. On faster GPUs, we don't have to wait as long.
So, for now I'm just gonna ignore this and you'll have to see my potato laptop rendering frames at 2 FPS.

After this, I got a bit sidetracked and played Pathologic 2 for 2 weeks straight.

But after returning, I tried to get the movement working. I made a player component, the draw function and serializers. And the player system,
which detects input and adds to the player velocity using Jolt functions. I also added a jump when you press the space key.
But we don't want this to happen, the player shouldn't be an astronaut so I performed a raycast to see if there's anything below the player 
and if there is, only then can they jump. But it was always returning true for some reason. Until I realized that the raycast was actually 
detecting the player. And I fixed this by starting the ray cast a bit below the player. And the jump works fine now, incredible.

So I've been yapping for some time and haven't actually explained to you, what I plan with this game.
What I want this game to be is a movement based game where you throw leaves, and can dash through those leaves in the air. It's kind of similar
to A Short Hike but instead of feathers, it's leaves.
So I made an object spawn out of the camera whenever you pressed right click and added a force to the object in the direction of the camera's 
front vector. That worked pretty nicely, but the leaves don't actually have a model, they're just green boxes.
So I whipped an absolutely trash leaf model in blender; which I scrapped anyway and downloaded a model off sketchfab.
Then I attached the mesh renderer to the leaf. Nice.
But I also want the ability to dash through them, and for that, I'll need another ray cast. This time, I'll be doing it in the camera's front 
vector to see if there is a leaf object in front of the camera.
This initially didn't work out too great, because the ray cast was, you guessed it, being stopped by the player collider.
This was quite simple to fix because all I had to do was to change the raycast filter function to only detect leaf objects. And now it works. 
Huzzah! [Spawning of leaves]

Then I ran into an issue where leaf dashes wouldn't push you forward horizontally, they would only propel you into the air.
This turned out to be because I was setting the linear velocity each frame for movement without factoring in any external forces. So I did the 
cheapest thing I could think of, which was to disable movement in the air. I'll make a better fix later on.

Another issue I was running into was that throwing leaves while walking would make them go backwards. The thing I did to fix this was to 
add the current player velocity to the leaves which is realistic.

But the movement felt very off and slippery, and the character controller I was using for my previous Unity games was a controller made 
by Leprawel, I really liked this controller and liked how it felt, so I decided to study the code and made a pseudo code script to 
understand it. And then I integrated the code into my own game, and now it feels very good. One thing I had to add was deceleration since that 
wasn't present in the controller. The way the deceleration works is that you get pushed in the opposite direction of your velocity, and this 
deceleration force is amplified further if you're standing still.

[SWITCHUP]

The rotations on the box were looking off, and not entirely accurate to reality, so I switched from euler angles to quaternions for rotations 
in my transform struct.

[UNDO SWITCHUP]

Up until now, the amount of leaves that the player can spawn are unlimited, but obviously this is pretty broken and would break the game,
so I needed some way to limit, so I made a set number of leaves that the player can spawn, and if you spawn them, you lose a leaf.
The leaves regenerate based on a timer, which is very similar to a short hike.

But I don't actually have a way of displaying this information to the player, and for that I need UI. So I haven't actually implemented UI in 
the engine yet. But that'll be pretty since, (Ctrl+c, Ctrl+v). Luckily, I have an enormous backlog of previous engines to build off of.

The text rendering is also pretty nice, I used freetype for the text rendering, and it even handles newlines which is pretty nice, it also
centers itself.

So then I made a little leaf sprite in asprite, and programmatically generated leaf entities and added a image component to them.
