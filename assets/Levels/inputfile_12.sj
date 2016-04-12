*sj
*c5 10
*w
*w2 1 1 0 2 0 0 0
*w2 1 3 1 2 0 0 0
*w1 1 5 1 2 0 0 0
*w1 3 5 2 2 0 2 0
*w4 5 5 2 2 0 0 0
*w4 5 2 0 1 0 0 0
*w3 5 1 0 4 0 0 1 
*/w
*/sj
v1 1 0 10v *sj 1 3 2 0 0 0 */sj
r2 0 2 130 *sj 5 3 4 1 100 10 */sj
v2 2 1 10v *sj 3 5 1 1 6 2 */sj
.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen
