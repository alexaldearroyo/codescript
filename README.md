# Code Content Printer Script

## Description
This Bash script is designed to conveniently display the contents of specified files or all files within given directories.
It's particularly useful for aggregating the contents of multiple code files, either outputting to the console or saving to a single file.

## Features
- **Print to Console**: By default, the script outputs the contents of each specified file or directory to the console.
- **Output to File**: Optionally, the script can save the contents to a file named `temp_codescript.txt` in the current directory.
- **Process Directories**: When provided with a directory, the script prints the contents of all files within that directory.
- **Safety Checks**: The script checks for and terminates any processes using the output file before writing to it.

## Making the Script Executable

Before you can run the script, you need to make sure it's executable. Here's how you can do it:

1. **Navigate to the Script Directory**: 
   Open a terminal and navigate to the directory where the script is located. You can do this with the `cd` command. For example:

``cd path/to/directory``

2. **Make the Script Executable as a command**: 
Run the following command to make the script executable:

``chmod +x codescript.sh``

Run the following command to execute the script with the command "codescript":

``cp codescript.sh /usr/local/bin/codescript``

## Usage

### Basic Usage
To run the script and print the contents of files or directories to the console:

``codescript [file_or_directory1] [file_or_directory2] ...``

### Save to File
To save the output to a file (which opens automatically):

``codescript -o [file_or_directory1] [file_or_directory2] ...``

### Output File
The output file will be saved as `temp_codescript.txt` in the current working directory. The script will automatically open this file after execution if the `-o` option is used.

## Requirements
- Bash environment
- Necessary permissions to execute the script

## Note
Please ensure that you have the necessary permissions to view the contents of the files and directories specified.

