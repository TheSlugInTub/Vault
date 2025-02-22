Title: How I added an editor to my game engine
Thumbnail: To be determined
# Script:
---
//TODO
# Timeline:
---
So I wanted to add an editor to my engine to make it easier to use
I gave up on the first attempt after not getting it to work
I then added a registry to call serialization and drawing functions to get components to serialize and render within the editor without having to modify the engine code.
It worked lets go
I then needed to add serialization to the engine so that you can save your progress on your game.
I decided to go with the nlohmann::json library for this.
I got the serialization and deserialization to work and you need to set up 3 functions to register a component and to make it visible in the editor.
I was trying to set a system for modifying polygon colliders with a mouse, I spent two days trying to figure out why it wasn't working, but I realized that I was doing the distance calculation with the local space point of the polygon and not the world space one.
Now it works.