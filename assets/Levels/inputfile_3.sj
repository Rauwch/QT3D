*sj
*g 4 4
*w
*w2 0 2 0 2,w1 0 4 0 6
*w4 6 4 0 2,w4 6 2 1 2
*w3 6 0 1 6,w2 0 0 1 1
*w2 3 0 1 1,w2 3 2 0 2   
*
*
*/w
*/sj

R1 0 1 100 *sj 0 1 2 1 150 50*/sj
R1 0 1 200 *sj 3 1 2 0 0 0*/sj 			
V1 1 0 20v *sj 6 2 4 1 16v 1*/sj



.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen

