*sj
*c5 10
*w
*w1 1 1 0 2 0 0 0 
*w1 3 1 1 2 0 0 0
*w2 5 1 1 4 0 0 0
*w3 5 5 1 1 0 0 0
*w3 3 5 0 2 0 0 0 
*w4 1 5 0 4 0 0 0 
*/w
*/sj
r1 0 1 60 *sj 4 5 3 1 75 15 */sj
v1 1 0 20v *sj 3 1 1 1 14 3 */sj
.end


** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen
