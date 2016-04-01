*sj
*c5 10
*w
*w2 1 1 0 2 0 0,w2 1 3 1 2 0 0
*w1 1 5 1 2 0 0,w1 3 5 2 2 0 2
*w4 5 5 2 2 0 0,w4 5 2 0 1 0 0
*w3 5 1 0 4 0 0 
*
*
*/w
*/sj


R1 2 0 100 *sj 5 3 4 0 0 0 */sj
V1 1 0 20v *sj 1 3 2 1 16 2 */sj
V2 2 1 10v *sj 3 5 1 1 8 2 */sj





.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj
*** twee aanpasbare bronnen die moeten opgeteld worden tot een doel
*** File altijd op .sj laten eindigen

