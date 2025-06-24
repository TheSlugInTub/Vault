# Slurm

Title:
Thumbnail:

# Timeline

## First recording 

I began work on my own shell because I wanted to save terminal sessions.

I started a new CMake project but then CMake didn't recognize my visual studio installation,
this was weird so I reinstalled Visual Studio, but then it still didn't recognize my installation.
I looked around online and tried a buncha stuff but it still didn't work.
So at this point I just threw my hands up in the air, and installed clang, I tried to get clang working,
and made this CMakePresets.json file in the main project, and typed in this command that someone told me 
on the internet, but it started generating visual studio files, this is extremely bizarre. But if I try
to generate the buildfiles in the actual build directory it doesn't work again!! [Increasing tone of voice]
I figured it must be a bug with my CMake, so I reinstalled CMake and lo and behold, it works! Huzzah!

## Second recording 

But then clangd was yelling at me because it wasn't recognizing filesystem in the standard library.
So I made a .clangd file to make it shut up.
At first, I constructed a very basic shell that would just display the current path and let you type stuff 
in, but I realized that when you input spaces into the command, the display would tweak out, this was 
happening because I was using std::cin which has the space as a delimeter so I switched it to std::getline.

And so my next hurdle was getting the 'cd' command to work, I implemented the command directly inside the shell,
by checking a substring of the string to see if is the command and changing the directory to the path after it.

But we have one problem, it crashes if we input a wrong directory, so I just checked if the directory was valid,
and outputted an error message if it wasn't.

I also made an exit command, which pretty plainly exits the program, and also made it so that if the command 
isn't within the list of preprogrammed commands, it executes it via the system. And at this point, we had a 
pretty functional shell that you could actually use.

## Third recording

So now it was time to get started on the most crucial part: saving and loading sessions.
I first stored a vector of commands where every command you typed got saved in it, and whenever you typed `savesession`,
it would execute a function where it opens a file on disk and writes all the commands to it.
And whenever you typed in `loadsession`, it opens this file and runs all the commands inside it.

But I was having an issue with writing files, whenever I saved the session, the file just wasn't being written.
Or atleast I thought so, it was actually being written in the current directory and in a shell, you'll be changing the 
current directory a lot so this simply wasn't practical.
So I just made it write to a fixed file on the D drive, I know this isn't a good solution but it'll work for now.

## Fourth recording

And then I wanted to add a line at the bottom of the terminal like lualine and tmux so I used ANSI escape codes to do this.
[Yaps about how I did it]
And it worked really well, but it didn't rescale according to the window rescale so I made it so that it runs on a different
thread so that it doesn't need to wait for user input to finish for it to update and it only updates if the terminal width
or height changes.
Well figuring out if the size of the terminal changes was a huge pain in the ass but I figured it out, but now it only draws
when the size changes, *sigh*. 
But then I ran into a grave problem, the status line doesn't clear itself.
This whole undertaking was a complete failure, I failed to clear the line and implement it in an efficient and clean manner.

## Fifth recording 

I will be rebuilding the shell to use ncurses.
I plan to add qtys (pseudo terminals).

## Sixth recording 

## Seventh recording 

I will be utilizing the ConPTY API for Windows on pseudoterminals [Yaps about pseudoterminals].
I researched a project called xconpty.
I had to split the project into two executables, the shell and the console. The shell is a regular shell but the console
is the one that starts the pseudo consoles and launches the shell inside those pseudo consoles.
I copied a lot of functions from xconpty into my project, but this one function: NtOpenFile was getting marked as 
an unresolved external symbol, so the thing I had to do was to link ntdll.lib into my project.
But I was running into an issue where it was immediately closing on startup. My stupid ass thought that this line wasn't 
necessary: smwprintf_s and cut it out but it was indeed ***very necessary***. 

And so let's run it.... GREAT! IT STILL DOENS'T WORK. But I narrowed the issue down to me not adding this little L character
in front of the LPC strings.

IT FINALLY WORKS WOOHOOOOOO!!!! [WORKING PTYS]

But now, I would like for the pseudo console to be inside the main window and not on its own and the way that I'm gonna do that is.
We have two pipes for input and output for the pseudo console. We will take all the output and display it in the main console with 
ncurses, and we will take all the input from the main console and feed it through the input pipe.

## Eigth recording

I have realized the monumental task I am taking on my shoulders.
I run into an issue where the PipeListener function isn't running, this is because I am indefinitely waiting on the main thread.
But I figured it that the actual issue was that the ReadFile function was halting the thread.
To fix this, I close the handle but closing the handle blocks any writing from the pseudoconsole.

## None 

I spent way, WAY too long on figuring out why no data is being transferred through the pipes. And I still haven't figured it out.
And now I will study another program by Microsoft. Demonstrating how to use pseudoconsoles.

## Ninth recording 

I was copying all the code from the example but targetver.h was not found, I think this is because I am not including the Windows 
SDK. Actually this wasn't because I wasn't including the Windows SDK, but because I wasn't including a certain file, namely
process.h.

## Tenth recording

After copying all the code, I got it to work. Hurrah!
But it wasn't using ncurses to print the output, so I tried to switch it out to use ncurses to print the output and uhhh...
it ain't lookin too hot. The text was borderline unreadable, and this was happening because the buffer I was printing
contained ANSI escape sequences in it, which ncurses doesn't know how to handle and shits itself when seeing one.
The quick and dirty solution is just to strip the text of all ANSI escape sequences.
But I temporarily cut out ncurses for a bit just to focus on input. I only have rendering of output at the moment but you can't 
interact with the pseudoconsole at all.
I BUILD THE INPUT LAYER BRICK BY BRICK. AND YOU AINT GOIN TEAR IT DOWN.
I have succesfully built the input listener which takes input from the main terminal and delivers it to the pseudoconsole.
It also takes characters like escape and other such nefarious keys. The terminal also supports unicode now.
