# ImageJ_Macros
Macros for processing multiple .lsm files in a directory

This Macro was written with the intention to process multiple z-series, multichannel images. The macro first creates a maximum intensity z projection of the image slices, then it splits all the channels (here I have applied it to three channels, but more channel can be added), following which it saves the images in individual folders depending on the channel. The marco additionally creates a folder for merged composite images. 
