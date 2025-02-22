Procedural generation is done with a series of operations overlayed on one another, otherwise known as an algorithm.
Let's start with a very basic randomly generated dungeon.

# Dungeon
---

Let's make a dungeon, we'll say that there are 3 rooms, a start room, an enemy room, and an end room.
We'll first make a start room, and roll a dice of 4 to see which direction the next room will end up in. But how will we roll a dice? How will we generate a random number? 
Computers can't do randomness, they are a series of instructions that do as they are told, but wait!
We can use an algorithm to generate a random number, let's say we have a range of 1-10, and we start with an initial value of 1, then we can perform a series of obfuscations, adding, subtracting, bit shifting, and dividing. 
But this still isn't random, because the algorithm is still a series of instructions that will do the same things for the same range, so we need some external factor, a seed. 
A seed (which is a number) can be inputted through the algorithm and the seed will change the algorithm's output. But how will we generate a random seed? It seems we've looped back in on ourselves, but we have improved our situation by a tiny bit, a small change in our seed will radically change our "random" output.
So we'll need to input a seed (which is a number), that changes every second, hmm...
You know what else changes every second? The time! 
We can get a pseudo-random number by inputting the time into our algorithm.
After that little hurdle is done, wait... where were we at again? Oh, dungeon generation.
After we roll the dice of 4 to determine the direction, let's say it outputs a value of 3, which means up (but you can assign any direction to the four numbers). 
Let's roll a dice of 1-20 to see how many rooms there will be until the end room is chosen, it has landed on 4, what a conveniantly small number for us!
So we can put an enemy room on the top of the start room, and then roll the dice of 4 again and again on the enemy rooms until we have four rooms, and then we can roll the final dice which determines the direction of the end room.
