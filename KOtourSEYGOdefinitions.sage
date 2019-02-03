# -*- coding: utf-8 -*-
#RUN WITH
# definitions for the KO tournament
# KOtourSEYGOTdefinitions.sage
# -*- coding: utf-8 -*-

#import random #already done by sage

########################################################################
def String2List(s):
    '''
    converts a given string s = "abcd, 123\n" into a list of a string and an integer: ['abcd', 123]
    '''
    name = ""; rank = ""
    flag = 0
    # for all  letters in s 
    for x in s: 
        if flag == 0 and x !=",":
            flag = 0
        else:
            flag = 1
        if flag == 0:
            name += x
        else:
            rank += x
    #print name
    #print rank.strip(', ')
    list = [str(name), int(rank.strip(', '))]
    return list
   
#print String2List('TR, 77\n')
########################################################################
def ReadPlayers(EntryList):
    '''
    Reads the list of players from file f = EntryList containing lines of the form: string, number, e.g.
    LS, 100
    TR, 77
    OV_yyy, 99
    Returns an ordered list such as
    PLAYERS =  [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ... ]
    '''
    fr = open(EntryList, 'r')
    #PL = fr.readlines() # a list containing the lines of EntryList
    PL = [line for line in fr] # list containing the lines of EntryList
    PLS = [] # the cleaned list containing [string, int]
    for x in PL:
        PLS.append(String2List(x))
    fr.close()

    return PLS

#print ReadPlayers('ListOfPlayers') #ListOfPlayers is the name of the file with entry players

########################################################################
def TestListOfPlayers(n):
    '''
    Generates PLAYERS, a test list of n players
    A player is a list ['name', no], where no is a positive integer
    E.g. no can be GOR-numbers from eurogodatabase; or 1000+rank for pro; 100+rank for dans; 100-rank for kyu players
    n=len(PLAYERS) # number of players
    TestListOfPlayers(5) returns:
    [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ['name4', 996]]
    '''
    PLAYERS = [] #List of players, sorted descendingly by rank/points, ..
    for k in range(n):
        PLAYERS.append(["name"+str(k), 1000-k])
    return PLAYERS
#print TestListOfPlayers(5)    
    
########################################################################
def ListWithDummies(PLAYERS):
    '''
    Appends a list of players with dummies. 
    The rank of a dummy is always 0!!!
    Output is a list with a power of two elements, the smallest that is >= len(PLAYERS)
    E.g.:
    PLAYERS = 
    [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ['name4', 996]]
    Then ListWithDummies(PLAYERS)  returns:
    [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ['name4', 996], ['Dummy0', 0], ['Dummy1', 0], ['Dummy2', 0]]

    '''
    n = len(PLAYERS)
    r = ceil(log(n,2)) 
    M= 2^r #Final number of players including the dummy ones.
    #Fill PLAYERS with dummies:
    for k in range(M-n):
        PLAYERS.append(["Dummy"+str(k), 0])
    return PLAYERS
#print ListWithDummies(TestListOfPlayers(5)) 

########################################################################
def RandomizeOrderedList(PLAYERS):
    '''
    Say
    P = PLAYERS =[...  ['name77', 996],... ['Dummy23', 0]...]
    Rules for randomization:
        1. P[0], P[1] left untouched
        2. randomize the next 2 positions, then the next 4, 
           then the next 8, .., and finally, the last chunk of no dummies 
        3. dummies are kept at the end untouched
        
        E.g. PLAYERS = 
        [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ['name4', 996], ['name5', 995], ['name6', 994], ['Dummy0', 0]]
        returns
        [['name0', 1000], ['name1', 999], ['name3', 997], ['name2', 998], ['name5', 995], ['name6', 994], ['name4', 996], ['Dummy0', 0]]

    '''
    #import random
    n = len(PLAYERS)
    r = ceil(log(n,2)) 
    # randomize the set of real players (not the dummies, which must occur in the last half, only!!!)
    RANDPLAYERS=[PLAYERS[0],PLAYERS[1]]
    for k in range(1, r-1):
        TMP = PLAYERS[2^k:2^(k+1)]
        shuffle(TMP)
        RANDPLAYERS = RANDPLAYERS + TMP
    
    TMP = []; DUM =[]    
    for j in range(2^(r-1), 2^r):
        tmp = PLAYERS[j]
        #print "j=",j, tmp, tmp[1]
    
        if tmp[1]==0:
            DUM.append(tmp)
        else:
            TMP.append(tmp)
        
    shuffle(TMP)
    RANDPLAYERS = RANDPLAYERS + TMP + DUM
    return RANDPLAYERS
    
#PLAYERS=ListWithDummies(TestListOfPlayers(7)) 
#print RandomizeOrderedList(PLAYERS)

########################################################################
def RandomizeOrderedListSeeds(PLAYERS):
    '''
    P = PLAYERS =[...  ['name77', 996],... ['Dummy23', 0]...]
    Same operrations as in RandomizeOrderedList().
    
    Additional formating is done on names:
        a. add white space (indent)
        b. adds seed-numbers for seeded players in front of their names.
                Only 2 players are seed-numbered if n<=8
                A 4th of the players are seed-numbered if n>8.

        E.g. PLAYERS = 
        [['name0', 1000], ['name1', 999], ['name2', 998], ['name3', 997], ['name4', 996], ['name5', 995], ['name6', 994], ['Dummy0', 0]]
        returns        
        [[' 1. name0', 1000], [' 2. name1', 999], ['    name3', 997], ['    name2', 998], ['    name4', 996], ['    name6', 994], ['    name5', 995], ['    Dummy0', 0]]

    '''
    n = len(PLAYERS)
    r = ceil(log(n,2)) 
    print r
    if n<=8:    
        P1 = PLAYERS[0][0]
        P1new = " 1. "+ P1; 
        PLAYERS[0][0] = P1new
        P2 = PLAYERS[1][0]
        P2new = " 2. "+ P2; 
        PLAYERS[1][0] = P2new
        
        if n>2:
            for k in range(2,n):
                Pk = PLAYERS[k][0]
                Pknew = "    "+ Pk; 
                PLAYERS[k][0] = Pknew
             
    if n>8:
        for k in range(n/4):
            Pk = PLAYERS[k][0]
            if k <9:
                Pknew = " "+str(k+1)+". "+ Pk;
            else:
                Pknew = ""+str(k+1)+". "+ Pk;
            PLAYERS[k][0] = Pknew
    
        for k in range(n/4,n):
            Pk = PLAYERS[k][0]
            Pknew = "    "+ Pk; 
            PLAYERS[k][0] = Pknew
     
    # randomize the set of real players (not the dummies, which occur in the last half, only!!!)
    RANDPLAYERS=[PLAYERS[0],PLAYERS[1]]
    if r>1:
        for k in range(1, r-1):
            TMP = PLAYERS[2^k:2^(k+1)]
            shuffle(TMP)
            RANDPLAYERS = RANDPLAYERS + TMP
        
        TMP = []; DUM =[]    
        for j in range(2^(r-1), 2^r):
            tmp = PLAYERS[j]
            #print "j=",j, tmp, tmp[1]
        
            if tmp[1]==0:
                DUM.append(tmp)
            else:
                TMP.append(tmp)
            
        shuffle(TMP)
        RANDPLAYERS = RANDPLAYERS + TMP + DUM
    return RANDPLAYERS
    
PLAYERS=ListWithDummies(TestListOfPlayers(3)) 
print PLAYERS
print
print RandomizeOrderedListSeeds(PLAYERS)
print
print

########################################################################
def GenerateOverturned(r):
    '''
    2^r players. r>=1
    Generates a tree returned as a list of lists. 
    (This is a basic choice, but there are many other possibilities.)
    The first components of the lists in the return are the basic position in the 1st round.
    r = the depth of the tree, r = 1, 2, 3, ...
    Examples:
    GenerateOverturned(1) returns: [[1, 1], [2, 0]]
    GenerateOverturned(2) returns: [[1, 1], [4, 0], [3, 1], [2, 0]]
    GenerateOverturned(3) returns: [[1, 1], [8, 0], [5, 1], [4, 0], [3, 1], [6, 0], [7, 1], [2, 0]]   
    
    M=2^r = the number of all players
    ROUND = the tree containing the pairings = their list is formed by consecutive pairs of players
    The tree is developed horizontaly, LeftToRight. The final leafs give the first round listed as a column.
    At each step new players inserted up or down, depending on the place
        Initial ROUND = [[1,1],[2,0]] : 
        The first components are the players, initially 1 and 2; 
        The second component: 1 = up, 0 = down (their position at the insertion moment)
    '''
    ROUND = [[1,1],[2,0]]
    lp = 2 # last player inserted
    # t = rounds of insertions
    for t in range(1,r):
        lp = len(ROUND) # last player inserted
        TMP = [] 
        # insertions:
        for k in range(lp):
            P =ROUND[k]
            #print P
            if P[1] == 1:
                TMP.append(P)
                TMP.append([2*lp-P[0]+1,0]) #Another way: change to 2*lp-k
            if P[1]==0:
                TMP.append([2*lp-P[0]+1,1]) #Another way: change to 2*lp-k
                TMP.append(P)
              
        ROUND = TMP
        #print "t=", t, ROUND
    return ROUND
#Example of runs: 
#print GenerateOverturned(2)
#print GenerateOverturned(3)

########################################################################
def PrintListVertically(L):
    '''
    Prints the elements of a list vertically.
    For example, print the basic format of the 1st round pairings 
    PrintListVertically(GenerateOverturned(3))
    '''
    flag = 0
    for s in L:
        if flag %2 ==0:
            print
        #print s
        print s[0]
        flag +=1
#PrintListVertically(GenerateOverturned(4)) 

########################################################################
def GenerateR1R2(PLAYERS):
    '''
    Prints Rounds 1 and 2, i.e., indents byes (pairs with a dummy player in 1st Round);
                                    dummy-players are not printed
    ...............................
    P=PLAYERS is an ORDERED list of n players in format ['name', no] e.g. ['John_Ștefănescu', 104]
    P is appended with dummy players ['dumk',0] till len(P) is the first power of 2
    P is ordered with RandomizeOrderedList()
    The elements of P are distributed and seeded in the 1st and 2nd rounds by  GenerateOverturned()
    The final Rounds 1-2 are listed vertically (the seeded players (those that play with dummies) are indented.
    '''
    P=PLAYERS
    n = len(PLAYERS)
    r = ceil(log(n,2)) 
    #M= 2^r #Final number of players including the dummy ones.
    PD = ListWithDummies(P)
    #RP = RandomizeOrderedList(PD) # Use tgis if NO numbers for seeded players is needed
    RP = RandomizeOrderedListSeeds(PD) # With numbers of seeded players
    TT = GenerateOverturned(r) 
    #print TT
    
    # Write the rounds into a file StartTable
    fw = open('StartTable', 'w')
    #fw.write("First Rounds")
    
    #print "Table written in file Rounds12"
    
    tab = "\t\t\t"
    dum = "" #"[       ,    ]"
    print "ROUND 1\t\t\t ROUND2"
    fw.write("ROUND 1\t ROUND2"); fw.write("\n")
    for k in range(len(TT)):
        if Mod(k,2)==0:
            player1 = RP[TT[k][0]-1]
            player2 = RP[TT[k+1][0]-1]
            if player1[1] == 0 or player2[1] == 0:
                bye = 1
            else:
                bye = 0
        if Mod(k,4)==0:
            print 0*"."; print
            fw.write("\n\n")
        if Mod(k,4)==2:
            print 22*"-"+">"
            fw.write(17*"-"+">");  fw.write("\n")
        player = RP[TT[k][0]-1]
        if bye == 1 and player[1]==0:
            continue
            #print tab,dum  # simple print of a list
        if  bye == 1 and player[1]>0:   
            #print tab,player
            #print tab, str(player).strip('[\']')
            print tab,player[0].strip('')+"--"+str(player[1])
            fw.write(tab)
            fw.write(player[0].strip('')+"--"+str(player[1])); fw.write("\n")
            
        if bye == 0:
            #print player # simple print of a list
            print player[0].strip('')+"--"+str(player[1])
            fw.write(player[0].strip('')+"--"+str(player[1])); fw.write("\n")
    fw.close()
    # End GenerateR1R2()
    
#PLAYERS = TestListOfPlayers(56) # a test list with n players
#PLAYERS = ReadPlayers('ListOfPlayersStripped') # players read from a file named ListOfPlayers
#print "List of players ordered decreasingly by rank/points/...:"
#print PLAYERS
#print

#print "The first round with byes (seeded players indented (promoted in the 2nd round)"
#print 100*"-"
#print
#GenerateR1R2(PLAYERS)
#print
#print 100*"-"



