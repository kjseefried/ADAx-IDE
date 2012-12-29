#ADAx 
#Overview
Ada IDE for Mac OS X is a simple to use native app for developing and compiling Ada progams. The app is currently in a very primitive state.
The main purpose of this app is to have an IDE which is simple to use and simplifises the code writing. ADAx shall follow the Apple human interface guidelines.

#How to use
+ Download the gnat compiler from http://libre.adacore.com/download/
+ In a terminal window, do the following:
Navigate to the directory that contains a file called: doinstall
+ Enter: sudo mkdir /usr/loca/gnat
You will have to enter your password
+ Enter: sudo ./doinstall
Press return and y as prompted
+ Update your path: sudo export PATH=/usr/local/gnat/bin:$PATH
You should now be able to compile ada programs in Mac

#Current features
+ Simple code editor 
+ Console view
+ Basic UI
+ Saving and opening files
+ Running gnat whithin the app

#Needs to be done
+ File navigator on the left side with a search function. Folders shall have a folder icon.  
+ Syntax highlightning 
+ Line numbers for the code editor
+ Template generator for ada body and header files. 

#Screenshot
![ScreenShot](https://raw.github.com/alexanis/ADAx-IDE/master/Screenshot.png)

#Author
Alex Anis
