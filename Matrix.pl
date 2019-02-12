% This program uses the following test matrices:
%
% 


/*
*
* Typical input will look like this:
* 
* k(K), printM(K).
*
* OR
*
* k(K), l(L), sum(K, L, X), write(X).
*
* The vailable hardcoded matrices are: k, l & m.
* 
* with:
*		k =  2  0  1  3
*     		-1  3  1  2
*      		5  1  0 -1
*
* 		l =  0  2  3 -1
*    		-1  0  2  2
*     		-1  0 -1  1
*
* 		m =  1  1
*      		2  1
*     		-1  0
*      		3 -2
*
*/


% ============================================= Matrices:
 k([ 
 	[  2,  0,  1,  3 ],
	[ -1,  3,  1,  2 ],
	[  5,  1,  0, -1 ]
	]).

 l([
 	[  0,  2,  3, -1 ],
 	[ -1,  0,  2,  2 ],
 	[ -1,  0, -1,  1 ]
 	]).

 m([
 	[  1,  1 ],
 	[  2,  1 ],
 	[ -1,  0 ],
 	[ 3,  -2 ]
 	]).

% ============================================= Main.

/*
 It's used mainly for debugging & rapid testing purposes.
 */

main:-
	k(K),
	l(L),
	m(M),
	%% sum( K, L, X),
	transpose( M, X), 
	write(X).



% ============================================= Sum(i,i,o)
/*
 The strategy was to traverse the matrix in a continous manner,
 specifically from left to right until the end of the row, while
 adding all the entries.

 When the end of the row is reached, it will move to the first entry 
 of the next level.

 If the End is reached it will end the execution.
*/

% Main Method
sum( [ [ EntryA | ColumnsA] | RowsA ], [ [ EntryB | ColumnsB] | RowsB], [ [ EntryC | ColumnsC ] | RowsC]):-
	EntryC is EntryA + EntryB,
	sum( [ ColumnsA | RowsA], [ColumnsB | RowsB], [ColumnsC| RowsC]).

% End of Row?
sum([ [] | ColumsA ] ,[ [] | ColumnsB ], [ [] | ListC ]):-
	sum(ColumsA, ColumnsB, ListC).

% Matrix is empty
sum([ [] | [] ], [ [] | [] ], [ [] | []]):- !.


% ============================================= Transpose (i,o)
/*
This was a little bit trickier because the traversal could'nt be done as with the
sum clause.

We basically transpose the first column, reducing the matrix. Then we repeat the process working
only with the submatrix left.
*/

% Starting point
transpose(Matrix, [Row|Rows]) :- 
	transposeCol(Matrix, Row, SubMatrix),
	transpose(SubMatrix, Rows).

% Matrix is empty
transpose([[]|_], []).


% Will transpose a column
transposeCol([[ EntryA| ColumnsA]|RowsA], [ EntryA| SubRow], [ ColumnsA | Rows]) :- 
	transposeCol(RowsA, SubRow, Rows).

% End of column transposition
transposeCol([], [], []).

% ============================================= Print Matrix(i)
/*
This clause traverses the matrix as in the "sum" clause, while printing 
the matrix entries.
*/
printM([ [] | [] ] ):-  nl, nl, !.

% End of Row?
printM([ [] | ColumsA ] ):-
	nl, printM(ColumsA).

% Main Method
printM( [ [ EntryA | ColumnsA] | RowsA ]):-
	write( EntryA ), write(" "),
	printM( [ ColumnsA | RowsA]).



