# -*- coding: utf-8 -*-
#RUN WITH
#sage: runfile KOtourSEYGO.sage
# -*- coding: utf-8 -*-

'''
Generate the initial pairings of a KO tournament with n initial players
List of players is in file ListOfPlayersStripped (check the special format!!!)
Output in the console and in StartTable file.

For details and changes check the methods in KOtourSEYGOdefinitions.sage
'''

load('KOtourSEYGOdefinitions.sage')  # load definitions

################################################################ 
## Generate the pairings-table for Rounds 1 and 2. 

## Names+ranks are read from a file located in this dirrectory; file = ListOfPlayersStripped in the example
#comment/replace the next line with a different list (see another posibility bellow)
#PLAYERS = ReadPlayers('data/ListOfPlayersStripped') # players read from a file named ListOfPlayersStripped
# results saved in StartTable or Copy/Paste from the commandLine sageShell
PLAYERS = ReadPlayers('ListOfPlayersStripped') # players read from a file named ListOfPlayersStripped

print "List of players ordered decreasingly by rank/points/...:"
print "\n",PLAYERS, "\n"

print "The first round with byes -- seeded-players indented (promoted in the 2nd round)"
print 100*"-", "\n"

GenerateR1R2(PLAYERS)
print "\n",100*"-"



# toggle comment/unccoment bellow as you wish
################################################################ 
## Generate the pairings-table for Rounds 1 and 2. 

## Names+ranks are from an automatically generated players-list

#PLAYERS = TestListOfPlayers(23) # a test list with n=56 players

#print "List of players ordered decreasingly by rank/points/...:"
#print "\n",PLAYERS, "\n"

#print "The first round with byes -- seeded-players indented (promoted in the 2nd round)"
#print 100*"-", "\n"

#GenerateR1R2(PLAYERS)
#print "\n",100*"-"




#################################################
## Randomize a list of players, add seed-numbers for seeded players; format/indent names
#comment/unccoment next lines
#PLAYERS = [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ['name4', 996], ['name5', 995], ['name6', 994], ['Dummy0', 0]]
#print RandomizeOrderedListSeeds(PLAYERS)



#################################################
## Randomize a list of players, no special formating
#PLAYERS=ListWithDummies(TestListOfPlayers(13)) 
#print PLAYERS
#print
#print RandomizeOrderedListSeeds(PLAYERS)
##print


#################################################
## Generate a basic list with the entry table of 2^4 players
#comment/unccoment next line
#print GenerateOverturned(4)


#################################################
## Prints a basic table-pairing of 1st round without names or randomization
#PrintListVertically(GenerateOverturned(5)) 
