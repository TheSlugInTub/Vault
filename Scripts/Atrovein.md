# Atrovein

# Timeline

So I had a thought in my head to create a medical simulation game. [Yaps about game]

So I created a new project in Unity and modelled a hospital which is modelled (haha) after a theatre
because Pathologic.

I brought the theatre into Unity and added some props around the scene. A lot of these props were *borrowed*
from Pathologic 2, but I'll replace them later on.

I modelled an autoclave in blender because I couldn't find a model online.

But then I realized that I would need to make human models because this is a game about treating people.
But I didn't know how to model humans and characters, I can model inorganic stuff pretty well but not characters.

So I followed a character modelling tutorial by BranSculpts and got to work. [Yaps about what I did in the tutorial]

Blender crashed while I was trying to follow the modelling tutorial, now I'll have to redo a lot of work.

And I made a new model based on Jinx from Arkane as practice but it ended up looking nothing like her so I will 
use it in the game.

I brought the model into Unity and made a dialogue system. [Yaps about dialogue system]

Now I'll have to create a physical examination scene.

I have made the physical examination scene.

Now I'll need to work on a casebook in which, all the diagnoses will be listed.
I have done a lot of research into conditions and have come up with 12 cases so far, I might make more later.

Well I would like to work on the hospitalization mechanic right now, but that would require making more animations,
while I'm gonna be personally honest, I'm not a huge fan of so, to procrastinate doing that, I'll get started on 
making the inventory system.

I followed this video on youtube by CocoCode on how to make an inventory system but when I finished it, I wasn't 
really happy with it because each item only took up one slot, which I didn't like, I wanted the items to be bigger,
so you can see them better instead of being tiny. And also, I'm basing the inventory system a lot off of Pathologic 2,
which has items that take up multiple slots so I reworked almost the entire inventory system and added multiple slot 
items to it. And now it works pretty damn well I'd say.
I also made the inventory look a lot more like Pathologic 2 and made a money counter.

[Yaps about the hospitalization mechanic and treatment plans]

So, the next thing I needed to work on was the hospitalization, and for this I needed to tackle my greatest enemy:
Animation, and animating the model laying down wasn't even that bad actually, the only thing that makes animation bearable
for me here is the amazing rig that I have which was generated for me by metarig. Also, the second animation I made wasn't 
importing into Unity, only one animation was importing, but I fixed that by exporting the blend file into FBX and importing 
it that way.

But then I realized that Unity's event system doesn't allow for functions that have parameters to them, so I made my own 
event system.
