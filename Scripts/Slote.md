# Slote

# Timeline

## First recording

So I wanted to reboot this old project of mine for summer hackclub. [Yaps about how I made the old project]
First I refactored the mode string into an enum. Then I made all the variable names actually clear.

## Second recording

So, the next step was to get rid of these hideous colors. The thing is, the colors actually render just fine 
on Linux, but on Windows, they're all blue and red and generally just an eyesore. So I wondered why this was.

It turns out, the problem is that I was redefining existing color codes with ncurses, instead of making my own.
The redefinitions didn't work, and the colors were just reverting back to their previous definitions, so I had
to make new color codes to get it work.

Next thing I tried to work on was the start screen, it previously only worked for Linux,
because it picked the .config directory in home to pick a start screen text file from,
but I made it work on Windows as well, by looking for a file in the user directory.

And uhhh.. that pikachu doesn't look too good. [disfugured pikachu]
And now he's not centered. [not centered pikachu]

So I made this extremely complex and borderline genius equation to calculate the startX and it STILL didn't work!
But it turns out, if I just hardcode the value in, it DOES work! So my extremely complex genius equation does work 
after all. So there must be a problem with calculating line width instead...

So I finally fixed it. Turns out, the problem was that I was using unicode characters in the start screen,
and unicode characters can count as multiple bytes, so the string::length function was counting those bytes.
So I converted it back to a wstring and counted the length, and that fixed it. [Normal pika]

## Third recording 

Alr, so I want multiple panes.

ANDDD... nothing works. [51:20]

This whole endeavour was a failure.

NO IT WASN't.

The status bar was failing to show because I had positioned it two rows further down like an idiot. But now it works!!
[Working multiple panes]

## Fourth recording 

I will try to implement vertical and horizontal terminal splits.
The interface I've made for myself actually makes it quite easy to add splits because I've already made the code be 
able to take and render multiple panes
IT WORKS BABY LETS GO [18:~~}
Now I just need a way to be able to switch between them. I will use the ctrl+w key for switching.
ANNDD... it works great!
But I'm running into an issue where if I write something into one pane, and then switch to another, it crashes. [pane crash!]
It turns out, the problem was that the cursor position was the same for each pane, which caused the crashes, switching to a 
separate cursor for each pane fixed the problem!

## Fifth recording

I will try to fix the cursor issue, it's fixed nice.
There's a small bit of a problem here where if I scroll on one pane, it also scrolls on the other pane, hmm... this seems
like future me would like to solve, onto more pressing matters like resizing the window for now! [Resize window attempt]

Yay resizing now works on the status bar! [19:~~]
But only works on Linux for now.
The reason it doesn't work on Windows, is that I'm using KEY_RESIZE to detect the window resize which requires the terminal
to send the SINGWINCH signal, and this signal is absent on Windows.

## Sixth recording

I will make resizing work.

## Seventh recording 

I will refactor the code and comment everything.
I also tried making scrolling down multiple lines work by inputting a number before moving the cursor but it wasn't working.
I made it work lets go! [string count and code commenting]

## double scroll fix

I will try to fix a problem where all panes scroll, even if only one is being scrolled. My hypothesis is that this is due to 
global instead of local variables named 'viewportTopRow' and 'viewportLeftCol' or something along those lines.
My hypothesis was correct and the problem has been solved.

## lua integration

I will attempt to add lua to the project for plugins and other stuff.
I got luajit for the project and the sol library.
I'm gonna write a Lua API for ncurses, for this I am going to need a WINDOW class for lua.
[Yaps about LuaAPI]
I got the LuaWindow type into lua, but it was not compiling with the printw function. I wonder why...
The reason it wasn't compiling is because I was using stdarg in my printw function and the stdarg 
stuff doens't map well into lua, so I needed to use the variadic capabilities of sol instead. [lua api for ncurses] 

We can communicate from lua! nice! [1:50:~~]
LUA'S WORKING LET's GO!

I made a display function in lua, where you can execute anything and it's called after displaying the status bar and the panes
but before getting the input.

## custom pane rendering from lua

I am encountering a problem where the hi from lua message only remains on the first frame.
It turns out, I was calling the clear function from the lua code but there wasn't an actualy clear function that I had defined,
and sol gave me NO errors about this whatsoever. So I just made a new clear function for the window type in lua and it works,
great!
I added in more functions to the lua api and also added the pane as a lua type and you can get any pane you want with get_pane
and also get the number of panes with get_panes_size.
Now I will attempt to add custom rendering of panes in lua.

Ahh... lua indexing getting me tripped up [41:~~]

Good it works now! [1:20:~~] [Working custom rendering in lua]

But I'll still need to implement line numbers.
I spent like half an hour wondering why the line numbers weren't showing, only to realize that I was using a function that didn't 
even exist, AND SOL DIDN't TELL ME ABOUT IT! [Line numbers fixed]

## none

I also wrote documentation for Slote and a help text file.
