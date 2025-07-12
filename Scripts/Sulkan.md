# Sulkan

# Timeline

## Init

I wanted to learn Vulkan and build a 3d renderer in it.
I made the initial project and followed along with vulkan-tutorial.

We have a window, let's go! [42:~~] [Initial commit]

We got vulkan popping up and display the amount of support extensions,
let's go! [Extensions supported]

So to get started on the renderer, I'll need a renderer class,
in which I will store the VkInstance which is a Vulkan object that is a communication layer
between our program and the Vulkan SDK.
[Yaps about more renderer stuff]

[Y validation layers]

[Y physical devices]

I ran into an issue where vkEnumeratePhysicalDevices was returning a device count of 0 for some
reason.

## Device count fixed

I will fix the issue.
It turns out, the root of the issue was that I was passing the first element of the devices vector
instead of the vector itself, and I also was getting the device count and vector in one go, but I 
actually needed to split this call into two, one for getting the count and one for filling the vector.
[Issue fixed]

[Y logical devices]
[Y surfaces]
[Y swapchain]
[Y images]
[Y image views]
[Y shaders]
[Y framebuffers]
[Y command buffers]

TRIANGLE, LET'S GO [TRIANGLE] [tail end of video]

## None

But I don't think I truly understood Vulkan, so I challenged myself to write a document explaining each
part of the graphics pipeline.

## Resizing

[Y recreating the swapchain]

## Vertex buffers

[Y vertex buffers]

Huzzah! Our first triangle but with vertex buffers instead of hard coded vertices in the shader.
[Vertex buffers] [34:~~]

We have now created a staging buffer for the triangle instead of using whatever the fuck we were using.
[Staging buffer] [1:08:~~]

[Y index buffers]

I ran into an issue where the square wasn't showing and the index buffer wasn't working.

## Uniform buffers

I fixed the index buffer issue, it turns out, I wasn't using the correct flags when making the buffer.

## None : Descriptors

So after index buffers, I tried to implement descriptors.
[Y descriptors]

But there was a big issue, the program was crashing, and no matter how hard I tried to fix it, it still
was crashing. So I scrapped all my descriptor work and began all the way back at the triangle commit.
And I slowly built the renderer up and up by copy pasting the new code onto the old one and tried to 
figure out where the crash was coming from, it turns out it was coming from a memcpy call to copy some
data onto uniform buffers. There was a big flaw in my code where I was treating a double void pointer
as if it was a single one but in reality, it was a pointer to a pointer to void instead of being just a 
pointer to void, so I fixed this and it works now, yay!

But when I adjust the shader to use the MVP matrix, then it doesn't show anything, hmmm...
But if it doesn't use the matrix, then it renders fine, so this must be a problem with either the 
transmission of descriptors or something's wrong with the matrix data itself. It turns out, this was really
stupid and I hadn't set the model matrix of the square to identity first. But now it works! [Speen]

## Textures

I will work on adding a texture to the plane.
[Y textures]
Texture coordinates work, huzzah! [Texture coordinates lets go] [1:46:~~]
Textures work, huzzah! [Textures] [1:50:~~]

## None : Depth buffering

[Y depth buffering]
Depth buffering works, nice. [Depth buffering yay]

## Model loading

Tf is this fam [Weird stuff] [55:~~]
Turns out, I was memcpying from the indices vector but not the actual data inside the vector.
I got it working but with no textures. [Model with no textures] [1:25:13]
I am running into an issue where assimp isn't reading my model's texture coordinates.
So it turns out, the texture coordinates do load but not on the model specifically as I tested it out on a 
cube and it worked. 
[Model loading works on cube but not on model]
Now the coordinates load, but they're tweakin out. [Broken texture coordinates]
This was because I followed with the tutorial, the tutorial flipped the Y coordinate of the textures but I 
already had that as an assimp flag, so I just had to remove the flipping of Y and it worked.
Also it turns out my model had something wrong, because I imported into blender, exported it to fbx and it 
worked.

## None : Removal of duplicated vertices

I also added it as a flag that assimp would remove duplicated vertices. [Remove duplicated vertices]
I tried to follow along with the tutorial on how to remove duplicated vertices but it used a hashmap to 
keep track of unique vertices so I made a whole hashmap class just to realize I could do what he did in a 
single line with an assimp flag.

## None : Added FPS counter

I added a new function to the window class to rename the window. And I made an FPS counter to display the FPS
and renamed the window every second to display the FPS. I also turned off vsync by changing the present mode 
in the swapchain.

## None : Multiple object rendering

I wanted to get multiple objects rendering.
I ditched the vector of uniform buffers and descriptor sets in the renderer struct and made a new structure 
called skRenderObject, which is very primitive and only has a vertex buffer, index buffer and a texture, in 
Vulkan's format of course. There's an array of descriptors and uniforms as many times as there are frames in
flight and these descriptors and uniforms are created as the object is added into the scene. I plan to add 
more high level rendering objects such as skMeshRenderer and skSpriteRenderer which build on top of 
skRenderObject. [Multiple objects rendering baby]
