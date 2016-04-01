*sj
*c5 10
*w
*w2 1 1 0 2 0 0,w2 1 3 1 2 0 2
*w1 1 5 1 1 0 0,w1 3 5 2 1 0 0, w1 5 5 3 1 0 0
*w4 6 5 3 2 0 0,w4 6 2 0 1 0 0
*w3 6 1 0 5 0 0
*
*
*/w
*sw1 2 5 1 2
*sw1 4 5 2 3 
*/sj


R1 3 0 100 *sj 6 3 4 0 0 0 */sj
V1 1 0 20v *sj 1 3 2 1 16 2 */sj



.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen


