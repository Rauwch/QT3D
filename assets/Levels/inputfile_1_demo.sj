*sj
*gx y goal
*z2star 3star
*w
*w(hoek x y node length isGoal)
*w(hoek x y node length isGoal)
*w(hoek x y node length isGoal)
*w(hoek x y node length isGoal)
*w(hoek x y node length isGoal)
*w(hoek x y node length isGoal)
*w(hoek x y node length isGoal)
*
*
*/w
*/sj
R(name node1 node2 value) *sj (x y hoek isAdjustable beginwaarde stapgrote) */sj
R(name node1 node2 value) *sj (x y hoek isAdjustable beginwaarde stapgrote) */sj
V(naam node1 node2 value) *sj (x y hoek isAdjustable beginwaarde stapgrote) */sj

.end

** Uitleg:
*** Alle draden staan tussen w en /w (in spicecomment) gesplitst door een comma
*** Syntax: WHoek Xcoord YCoord Node Lenght (Voor hoek: 1, wijst naar rechts, 2 naarboven, 3 naar links en 4 naar onder)
*** Voor weerstanden en bronnen: Gewoon zoals in spice.
*** Achter elke Component een spicecomment in de voor van *sj Xcoord Ycoord Hoek Aanpasbaar Beginwaarde stapgrote */sj

*** File altijd op .sj laten eindigen
