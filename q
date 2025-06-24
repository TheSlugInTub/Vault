[1mdiff --git a/Scripts/Atrovein.md b/Scripts/Atrovein.md[m
[1mindex 44e3bdc..74c12de 100644[m
[1m--- a/Scripts/Atrovein.md[m
[1m+++ b/Scripts/Atrovein.md[m
[36m@@ -25,3 +25,30 @@[m [muse it in the game.[m
 I brought the model into Unity and made a dialogue system. [Yaps about dialogue system][m
 [m
 Now I'll have to create a physical examination scene.[m
[32m+[m
[32m+[m[32mI have made the physical examination scene.[m
[32m+[m
[32m+[m[32mNow I'll need to work on a casebook in which, all the diagnoses will be listed.[m
[32m+[m[32mI have done a lot of research into conditions and have come up with 12 cases so far, I might make more later.[m
[32m+[m
[32m+[m[32mWell I would like to work on the hospitalization mechanic right now, but that would require making more animations,[m
[32m+[m[32mwhile I'm gonna be personally honest, I'm not a huge fan of so, to procrastinate doing that, I'll get started on[m[41m [m
[32m+[m[32mmaking the inventory system.[m
[32m+[m
[32m+[m[32mI followed this video on youtube by CocoCode on how to make an inventory system but when I finished it, I wasn't[m[41m [m
[32m+[m[32mreally happy with it because each item only took up one slot, which I didn't like, I wanted the items to be bigger,[m
[32m+[m[32mso you can see them better instead of being tiny. And also, I'm basing the inventory system a lot off of Pathologic 2,[m
[32m+[m[32mwhich has items that take up multiple slots so I reworked almost the entire inventory system and added multiple slot[m[41m [m
[32m+[m[32mitems to it. And now it works pretty damn well I'd say.[m
[32m+[m[32mI also made the inventory look a lot more like Pathologic 2 and made a money counter.[m
[32m+[m
[32m+[m[32m[Yaps about the hospitalization mechanic and treatment plans][m
[32m+[m
[32m+[m[32mSo, the next thing I needed to work on was the hospitalization, and for this I needed to tackle my greatest enemy:[m
[32m+[m[32mAnimation, and animating the model laying down wasn't even that bad actually, the only thing that makes animation bearable[m
[32m+[m[32mfor me here is the amazing rig that I have which was generated for me by metarig. Also, the second animation I made wasn't[m[41m [m
[32m+[m[32mimporting into Unity, only one animation was importing, but I fixed that by exporting the blend file into FBX and importing[m[41m [m
[32m+[m[32mit that way.[m
[32m+[m
[32m+[m[32mBut then I realized that Unity's event system doesn't allow for functions that have parameters to them, so I made my own[m[41m [m
[32m+[m[32mevent system.[m
