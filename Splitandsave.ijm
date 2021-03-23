selectedFolder = getDirectory("Choose Source Directory ");
//choose folder with images

fileList = getFileList(selectedFolder);

outputPath = selectedFolder +'Output/';
//Creates a folder named Output with all
//output files within the chosen source directory(folder)

channel1Path = outputPath + 'channel1/';
//Path to sub-folder with files in channel 1
channel2Path = outputPath + 'channel2/';
//Path to sub-folder with files in channel 2
channel3Path = outputPath + 'channel3/';
//Path to sub-folder with files in channel 3
//you can change the variable name to match the
//target corresponding to the channel for
//eg. CD31Path = outputPath + 'CD31/'

mergedPath = outputPath + 'merged/';
// Path to composites

//loop through all the files in the directory(folder)

for (i=0; i<fileList.length; i++) {
    currentFileName = fileList[i];
    if (endsWith(currentFileName, "/")) {
		continue;
	}
	File.makeDirectory(outputPath);

	open(selectedFolder+currentFileName);
	selectWindow(currentFileName);
	run("Z Project...", "projection=[Max Intensity]");
	//creates max projection image
	run("Split Channels");
	//Splits channels

	selectWindow("C1-MAX_" + currentFileName);
	File.makeDirectory(channel1Path);
	channel1Filename = currentFileName + "-C1-MAX.tiff";
	//creates folder and saves image corresponding to channel
	saveAs("Tiff", channel1Path + channel1Filename);

	selectWindow("C2-MAX_" + currentFileName);
	File.makeDirectory(channel2Path);
	channel2Filename = currentFileName + "-C2-MAX.tiff";
	//creates folder and saves image corresponding to channel
	saveAs("Tiff", channel2Filename );

	selectWindow("C3-MAX_" + currentFileName);
	File.makeDirectory(channel3Path);
	 //creates folder and saves image corresponding to channel
	 channel3Filename = currentFileName + "-C3-MAX.tiff";
	saveAs("Tiff", channel3Path + channel3Filename);

	// you may want to change channelxFilename to the target it stains for
	//eg.  cd31FileName = currentFileName + "-C3-MAX.tiff";

	run("Merge Channels...", "c1=[" + channel1Filename  +"] c2=[" + channel2Filename + "] c6=[" + channel3Filename + "] create");
    // here make sure the c corresponds to the
    //correct channel eg c1 = red, c2= green, c3= blue etc

    File.makeDirectory(mergedPath);
	saveAs("Tiff", mergedPath + currentFileName + "Composite.tiff");
	close("*");
}


run("Close All");
