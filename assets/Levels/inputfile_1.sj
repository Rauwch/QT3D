*sj
*g 4 4
*w
*w1 2 4 0 2, w4 4 4 0 1
*w2 1 3 1 1,w1 1 4 1 1
*w2 1 1 2 1,w3 4 1 2 3, w4 4 2 2 1
*
*
*/w
*/sj

R1 1 2 100 *sj 1 2 2 1 150 50*/sj
R2 2 0 100 *sj 4 3 4 0 0 0*/sj
V1 1 0 20v *sj 2 4 1 1 16v 1*/sj


.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen

