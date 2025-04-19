# OpenGL

OpenGL is a graphics API. OpenGL is a standard that has been made by the brilliant minds over at Khronos
which would be a set of functions and an interface for the programmer, that is then implemented by 
grphiacs cards manufacturers. Most GPUs and devices support OpenGL as it has become very popular.

An implemntation of the OpenGL API is available in many languages but today we are going to use C++.

# Chapter 1: Setup

So before writing main.cpp, you should write a window class with GLFW that sets up the window.
OpenGL just interacts with the graphics card, it doesn't create the window for us.

And setting up main, we should have something like this:

```cpp 
int main()
{
    Window window("SlugGL", 800, 600); // Title, width, height

    glViewport(0, 0, 800, 600);

    while (!window.ShouldClose())
    {
        glClear(GL_COLOR_BUFFER_BIT);

        window.Update(); // Swap buffers, poll events
    }

    window.Terminate();
}
```

The glViewport function tells OpenGL what resolution to render at.
The first two arguments specify where the lower left corner should be at, that is the origin of the 
viewport. The second two arguments specify the resolution.
The glClear is a function that clears a buffer, we are clearing the color buffer.
The color buffer is what is ultimately displayed onto the screen.
We clear it every frame since we don't want each frame to pile up like paint on a canvas.

If you see a very boring black screen, then you did things right!

# Chapter 2: Triangle

## The Graphics Pipeline

The graphics pipeline is a series of steps that 3d coordinates take to become pixels on the screen.
The pipeline is divided into two parts, the first take your 3d coordinates and turn them into 2d 
coordinates (project them) because the window is a 2d buffer of pixels. The second half turn them 
into pixels on your monitor.

These tasks of the pipeline run on many thousands of cores on the GPU which all run little programs
called shaders. Shaders specify how to handle the vertices, fragments, and geometry, they are written in 
GLSL. We will write our own.

## Buffers

The pipeline takes as input vertex data in 3d space. We can create vertex data by allocated memory on the 
GPU and storing our data there. We do this via Vertex Buffer Objects (VBO).

A vertex is a list of numbers that can specify whatever the hell you want, position, colors, or texture
coordinates. 

Make your list of vertices first:

```cpp 
float vertices[] = {-0.5f, -0.5f, 0.0f,
                     0.5f, -0.5f, 0.0f,  
                     0.0f,  0.5f, 0.0f};
```

These are just positions in my case. You can format this data any way you like. You will have to tell 
OpenGL how you formatted it.

And then to make a vertex buffer object:

```cpp 
unsigned int VBO;
glGenBuffers(1, VBO);

glBindBuffer(GL_ARRAY_BUFFER, VBO);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
```

An important thing to note here is that OpenGL is a state machine. There is only one type of buffer object 
that can be bound at once. And any kind of ID needs to be bound to be used.

The unsigned integer is an ID to the memory on the GPU.
We generate the buffer, bind it to use it, then set the data inside this buffer. First argument is the type 
of buffer we want to set data for, the second argument is the size of the data, the third is the data, and 
the fourth is the draw type.

GL_DYNAMIC_DRAW = Vertex data that gets changed often and is drawn often.
GL_STATIC_DRAW = Vertex data that doesn't get changed and is drawn often.
GL_STREAM_DRAW = Vertex data that doesn't get changed and isn't drawn often.

## Shaders 

Shaders are code that runs on the GPU. OpenGL requires us to write two shaders of our own. These are the vertex 
and fragment shaders. The vertex shader is run for every vertex, the fragment shader is run for every pixel that 
is inside the triangles that are outputted by the geometry shader.

Let's write a vertex shader in GLSL:

```glsl 
#version 330 core 

layout (location = 0) in vec3 aPos;

void main()
{
    gl_Position = vec4(aPos.xyz, 0.0);
}
```

The language is similar to C. It requires us to put the OpenGL version on top. There is a layout that we can set 
that is taken as an input, it is set as location 0.
We output to the built-in variable of gl_Position, the position of the vertex.
We're doing nothing special here, just transferring data. This shader will get more complex later on.

Let's write a fragment shader:

```glsl 
#version 330 core 

out vec4 FragColor;

void main()
{
    FragColor = vec4(0.3, 0.1, 0.5, 1.0);
}
```

This is a terribly simple fragment shader that just outputs a [I DON'T KNOW THE COLOR] color for each pixel, commonly 
referred to as fragment. There is only one outputted variable required, which is the aptly named FragColor.

You must now write a shader class which reads from a file and sends the shader source to OpenGL to compile it.

The way you interact with it should look like this:

```cpp
Shader shader("tri.vs", "tri.fs");

shader.use();
```

## Buffers v2

Back to buffers, we need to specify how OpenGL should read our `vertices` data.

```
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);
```

The glVertexAttribPointer's arguments are: the location in which we set the vertex attribute (layout in the shader),
the size of the vertices (refers to how many floats are in each vertex, which is 3 in our case), a flag that sets normalization 
of integers which we don't need, the stride of the data in bytes (refers to how many bytes per each vertex), and finally the offset
of the first vertex, which is zero in our case.

But whenever we want to bind to a new VBO, we will have to set up these attributes again, which is a damned shame. If only there was 
a way to store the state of a vertex buffer object without having to set up the attributes each time.
Vertex array objects are objects that hold the state of a VBO. If you bind them, and set up a VBO afterwards, the VAO will remember
the state of the VBO. And you now no longer have to set up attributes for the VBO each time you bind it, you can simply bind the VAO.

```
unsigned int VAO;
glGenVertexArrays(1, &VAO);

glBindVertexArray(VAO);

// Do VBO intialization here
```

We're all set to go here, we've made the VBO, we've set the data inside the VBO, we've made a vertex and a fragment shader, we've 
linked up the vertex attributes with the VBO. We've made a shader class (hopefully), we've made a vertex array object and all that's 
left is to draw the triangle.

```
// In main loop 

shader.use();
glBindVertexArray(VAO);

glDrawArrays(GL_TRIANGLES, 0, 3);
```

The glDrawArrays function has arguments of: the type of primitive to be drawn, this includes, GL_LINES, GL_LINE_STRIP, GL_TRIANGLE_FAN...,
the position of the first vertex, this is zero since the first vertex is in the first position, and the amount of vertices to draw.

If you did things right, you shall now see a triangle, huzzah! hurrah! buzzah!

## Square


