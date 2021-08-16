selectedFolder = getDirectory("Choose Source Directory ");
//choose folder with images

outputPath = selectedFolder +'Output/';
File.makeDirectory(outputPath);
//Creates a folder named Output with all
//output files within the chosen source directory(folder)

channel1Path = outputPath + 'channel1/';
File.makeDirectory(channel1Path);
//Path to sub-folder with files in channel 1
//make the folder
channel2Path = outputPath + 'channel2/';
File.makeDirectory(channel2Path);
//Path to sub-folder with files in channel 2
//make the folder
channel3Path = outputPath + 'channel3/';
File.makeDirectory(channel3Path);
//Path to sub-folder with files in channel 3
//make the folder
channel4Path = outputPath + 'channel4/';
File.makeDirectory(channel4Path);
//Path to sub-folder with files in channel 4
//make the folder
compositeChosenChannelsPath = outputPath + 'merge/';
File.makeDirectory(compositeChosenChannelsPath);
// path to folder with merged image of chosen channels


run("Bio-Formats Importer");
//opens Bio-Formats Importer GUI
//select HYPERSTACK on the GUI and the color mode you prefer
//Next window opens with Series, here select a series
//make sure to deselect the first series when you choose another one

seriesTitles = getList("image.titles");
currentSeriesTitle = seriesTitles[0];
//Gets the series name to uniquely reference your image

currentSeriesTitleWithoutSpaces = replace(currentSeriesTitle, "\\s+", "");
//If the name of your  has spaces the
//image file will only print the parent file name
// to avoid this I have replaced any spaces with no space

run("Split Channels");
// splits channels before concatenation

concatenateValue = 'title='+ currentSeriesTitleWithoutSpaces +' open';
imageTitles = getList("image.titles");
for(i=0; i< imageTitles.length; i++) {
	imageTitle = imageTitles[i];
	imageNumber = i + 1;
	concatenationArgs = "[" + imageTitle + "]";
	concatenateValue += " image" + imageNumber + concatenationArgs;
}
run("Concatenate...", concatenateValue);

//concatenates all files

run("Z Project...", "projection=[Max Intensity] all");

// creates z-projection images of all channels

run("Make Composite", "display=Composite");
// creates a composite

run("Split Channels");
//splits channels

selectWindow("C1-MAX_" + currentSeriesTitleWithoutSpaces );
channel1Filename = "C1-MAX_" + currentSeriesTitleWithoutSpaces;
saveAs("tiff", channel1Path + channel1Filename);

selectWindow("C2-MAX_" + currentSeriesTitleWithoutSpaces);
channel2Filename = "C2-MAX_" + currentSeriesTitleWithoutSpaces;
saveAs("tiff", channel2Path + channel2Filename);

selectWindow("C3-MAX_" + currentSeriesTitleWithoutSpaces);
channel3Filename = "C3-MAX_" + currentSeriesTitleWithoutSpaces;
saveAs("tiff", channel3Path + channel3Filename);

selectWindow("C4-MAX_" + currentSeriesTitleWithoutSpaces);
channel4Filename = "C4-MAX_" + currentSeriesTitleWithoutSpaces;
saveAs("tiff", channel4Path + channel4Filename);

//saves all images according to channel in named folders


run("Merge Channels...")

//Merge channels by selecting the channels of your choice

selectWindow("MAX_"+ currentSeriesTitleWithoutSpaces + ".tif");
compositeName = "Composite" + currentSeriesTitleWithoutSpaces
saveAs("tiff", compositeChosenChannelsPath + compositeName)
// saves composite in merge folder


run("Close All");



