selectedFolder = getDirectory("Choose Source Directory ");

fileList = getFileList(selectedFolder);

outputPath = selectedFolder +'Output/';
ng2Path = outputPath + 'ng2/';
igGPath = outputPath + 'igG/';
cd31Path = outputPath + 'cd31/';
for (i=0; i<fileList.length; i++) {
	File.makeDirectory(outputPath);
	currentFileName = fileList[i];
	open(selectedFolder+currentFileName);
	selectWindow(currentFileName);
	run("Z Project...", "projection=[Max Intensity]");
	run("Split Channels");
	selectWindow("C1-MAX_" + currentFileName);
	
	File.makeDirectory(ng2Path);
	saveAs("Tiff", ng2Path + currentFileName + ".tiff");

	selectWindow("C2-MAX_" + currentFileName);
	File.makeDirectory(igGPath);
	saveAs("Tiff", igGPath + currentFileName + ".tiff");

	
	selectWindow("C3-MAX_" + currentFileName);
	File.makeDirectory(cd31Path);
	saveAs("Tiff", cd31Path + currentFileName + ".tiff");
}


run("Close All");