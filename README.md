# KOtourSEYGO
 
 A script that generates the Start Table (Rounds 1-2) of a KO tournament with n>1 players. It is written in `sage` and, with minimal modifications, it runs in `python`, also.
 
## Install and run
Needs to have `sage` installed.  Unzip in a directory and run `sage` in a terminal in that directory.

Runs from the file KOtourSEYGO.sage (comment/uncomment lines or introduce other code, as you need).

	sage: runfile KOtourSEYGO.sage 

or run from the command line:

	sage: load('KOtourSEYGOdefinitions.sage')  # load definitions
	sage: GenerateR1R2(PLAYERS) # generates the StartTable reading the list of players from a file.
	
See more commands in *screenshots* directory.

### Python version 
	$ python KOtourSEYGO.py
or
	
	$ python3 KOtourSEYGO.py
	
Docummentation and test-runs embeded-commented in the scripts.	

	
## Input/Output

Given a list of n>1 players, it returns the first 1-2 rounds of a KO tournament.
A player is a list [string, int], where string contains the name of the player and int is its rank (which can be a number -- GOR from eurogodatabase or 1000+rank for dan players, 100+rank for dan players, 100-rank for kyu players). 

The list has to be ordered decreasingly. 

The list can be introduced directly in the sage file, inline, or in a file with a player on each line. 

For test runs, a TestStartList can be generated automatically.


![](screenshots/GenerateR1R2_test23.png) 



***

Other results can also be obtained using the definitions/functions/methods from the .sage files.
	
## Algorithm

- The list of players is appended with dummy players, till its length is the first power of 2.
- A tree-list is created
	+ Players 1 and 2 are placed on the top and on the bottom of the output table, respectively.
 generation).
	+ Players 5-8 are intercalated (the 3rd generation), and so on. 
	+ The number of players is doubled with each new generation.
	+ A new player is inserted before or after a player from the previous generation in the opposite way as its ancestor was introduced in the list.
- The players from the input list are repositioned according to the places of the same index in the tree-list.
- In succesive steps, the positions of the no dummy players introduced in the same generation are randomized.
- In the output table, dummy players are not displayed and the coresponding pairing (containing just one player) is displayed indented in round 2.
- The seed-favorite number is displayed in the final output for a fourth of the players.
