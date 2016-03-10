*sj
*g5 1 1
*w
*w2 1 3 0 2 0,w1 1 5 0 4 0
*w4 5 5 0 2 0,w4 5 3 1 2 0
*w3 5 1 1 4 1,w2 1 1 1 1 0 
*
*
*/w
*/sj

R1 0 1 100 *sj 1 2 2 1 0 50 */sj
V1 1 0 20v *sj 5 3 4 1 16 1 */sj



.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen

