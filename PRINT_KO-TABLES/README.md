##How to generate printable KO schemes
 
Three template svg files are provided. Edit and export to pdf,   print to a file or directly to a printer.
 
### Edit in inkscape

Adapt or replace title, date, other information about the tournament. 

The names of the players are strings, in a standard format:

FirstName_MiddleName LASTNAME rank (CC) [dd], where **CC** is the two *letter code of the country*, while **dd** stands for any item from the list:
**n** = *the seed number*
**WC ** = *wild card*
**Q** = *qualified*  from preliminary tournament
**WO** = *walk over* - advanced by the forfeit of the partner. The player advances in the tournament but, since the game was not played on the board, it doesn't count as a win or as a lose for either of the players involved, so no SEYGO points are earned.

The svg files are structured in distinct layers to allow printing only the relevant information along the evolution of the tournament. Toggle *hide* and *lock* buttons to obtain the necessary results.

Schemes for smaller tournaments can be obtained by deleting the unnecessary lines of the tree or just by leaving blank boxes where no players are scheduled.

For larger tournaments one may use two 32 players KO tables with 32 players as top and bottom of the larger scheme.

## Edit in a text editor also.

Use a text editor to find and replace the generic strings with the real names of players participating in the tournament. Then save and convert the svg files to pdf from command line.


Print A4 or transform in A3 or other paper sizes. 

	inkscape -A KO64_A4_names.pdf KO64_A4_names.svg
	inkscape -A KO64_A4_Labels.pdf KO64_A4_Labels.svg
	inkscape -A KO64_A4_Finals_Labels.pdf KO64_A4_Finals_Labels.svg
	
## Convert to A3 or other formats

Use inkscape or the command line:

	pdfjam A4file.pdf --a3paper --outfile A3file.pdf
	pdfjam A4file.pdf --a0paper --outfile A0file.pdf

For more examples and further information see the website http://go.warwick.ac.uk/pdfjam


	