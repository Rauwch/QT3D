*sj
*c5 10
*w
*w2 1 1 0 2 0 0 0
*w2 1 3 1 2 0 0 0
*w1 1 5 1 3 0 0 0
*w1 4 5 1 1 0 0 0
*w1 6 5 2 1 0 0 0
*w4 4 5 1 1 0 0 0
*w4 7 5 2 1 0 0 0
*w4 4 3 0 2 0 0 0 
*w4 7 3 0 2 0 0 0
*w3 7 1 0 3 0 0 0
*w3 4 1 0 3 0 0 1
*/w
*sw1 5 5 1 2  
*/sj
R1 0 1 140 *sj 4 4 4 1 120 20 */sj
R2 2 0 0 *sj 7 4 4 0 0 0 */sj
V1 1 0 17v *sj 1 3 2 0 0 0 */sj
.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen


