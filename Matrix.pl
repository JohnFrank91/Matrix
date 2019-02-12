% The following program uses the following test matrices:
%
% k =  2  0  1  3
%     -1  3  1  2
%      5  1  0 -1

% l =  0  2  3 -1
%    -1  0  2  2
%     -1  0 -1  1
%
% m =  1  1
%      2  1
%     -1  0
%      3 -2

/*
*
* Typical input will look like this:
*
* k(K), printM(K).
*
* OR
*
* k(K), l(L), sum(K, L, X), write(X).
*/

%Main Method
main:-
	k(K),
	l(L),
	m(M),
	%Print out resulting Matrix objects to verify it worked:
	printM(K),
	printM(L),
	printM(M),
	%Three addition tests:
	%1 and 2) K+L = L+K  = 2 2 4 2
	%                      -2 3 3 4
	%		       4 1 -1 0
	%3) K+M... should give an error message (incompatible dimensions)
	%write("----- Addition tests -----"),nl,
	%sum(K,L,R0),
	%printM(R0),
	%sum(L,K,R1),
	%printM(R1),
	%sum(K,M,R2),
	%printM(R2),
	%Three substraction tests:
	%1)K-L = 2 -2 -2 4
	%        0 3 -1 0
	%        6 1 1 -2
	%2)L-K = -2 2 2 -4
	%        0 -3 1 0
	%        -6 -1 -1 2
	%3) K-M... should give an error message (incompatible dimensions)
	% and print null as the velue of the resulting matrix.
	%write("----- Substraction tests -----"),nl,
	%substract(K,L,R3),
	%printM(R3),
	%substract(L,K,R4),
	%printM(R4),
	%substract(K,M,R5),
	%printM(R5),
	%Three multiplication tests:
	%1)K*M = 10 -4
	%        10 -2
	%	 4 8
	%2)L*M = -2 4
	%	 3 -5
	%        3 -3
	%3) K*K... should give an error message (incompatible dimensions)
	% and print null as the velue of the resulting matrix.
	write("----- Multiplication tests -----"),nl,
	times(K,M,R6),
	printM(R6),
	%times(L,M,R7),
	%printM(R7),
	%times(K,K,R8),
	%Two transposition tests:
	%1)K(T) = 2 -1 5
	%         0 3 1
	%         1 1 0
	%         3 2 -1
	%2)M(T) = 1 2 -1 3
	%         1 1 0 -2
	%write("----- Transposition tests ----"),nl,
	transpose(K,R9),
	printM(R9),
	transpose(M,R10),
	printM(R10),
	write("FIN").


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

% ============================================= Sum (i,i,o)
/*
 The strategy was to traverse the matrix in a continous manner,
 specifically from left to right until the end of the row, while
 adding all the entries.
 When the end of the row is reached, it will move to the first entry
 of the next level.
 If the End is reached it will end the execution.
*/

% Matrix is empty
sum([ [] | [] ], [ [] | [] ], [ [] | []]):- !.

% End of Row?
sum([ [] | ColumsA ] ,[ [] | ColumnsB ], [ [] | ListC ]):-
	sum(ColumsA, ColumnsB, ListC).

% Main Method
sum( [ [ EntryA | ColumnsA] | RowsA ], [ [ EntryB | ColumnsB] | RowsB], [ [ EntryC | ColumnsC ] | RowsC]):-
	EntryC is EntryA + EntryB,
	sum( [ ColumnsA | RowsA], [ColumnsB | RowsB], [ColumnsC| RowsC]).

% ============================================= substract(i,i,o)
/*
 The strategy was to traverse the matrix in a continous manner,
 specifically from left to right until the end of the row, while
 substracting the second matrix element from the first matrix element.In
 this case if the entries were to be substract(A,B,X), the result would
 be X where we would substract the values of B from A. When the end of
 the row is reached, it will move to the first entry of the next level.
 If the End is reached it will end the execution.
*/

% Matrix is empty
substract([ [] | [] ], [ [] | [] ], [ [] | []]):- !.

% End of Row?
substract([ [] | ColumsA ] ,[ [] | ColumnsB ], [ [] | ListC ]):-
	substract(ColumsA, ColumnsB, ListC).

% Main Method
substract( [ [ EntryA | ColumnsA] | RowsA ], [ [ EntryB | ColumnsB] | RowsB], [ [ EntryC | ColumnsC ] | RowsC]):-
	EntryC is EntryA - EntryB,
	substract( [ ColumnsA | RowsA], [ColumnsB | RowsB], [ColumnsC| RowsC]).

% ============================================= times(i,i,o)
/*
Explanation
*/

% Matrix is empty
times([[]|[]],[[]|[]],[[]|[]]):-!.
% Transpose second matrix
times(A,B,C):-
	transpose(B,X),
	times2(A,X,C).
% Matrix is empty
times2([[]|[]],[[]|[]],[[]|[]]):-!.
%End of Row?
times2([[]|RowsA],[[]|RowsX],[[]|RowsC]):-
	write("Row Ended"),nl,
	times2(RowsA,RowsX,RowsC).
times2([[EntryA|ColumnsA]|RowsA],[[EntryX|ColumnsX]|RowsX],[[EntryC|ColumnsC]|RowsC]):-
	write("Entered main method"),nl,
	Value1 is EntryA*EntryX,
	write(Value1),nl,
	EntryC is Value1 ,%+ times2([ColumnsA|RowsA], [ColumnsX|RowsX], [ColumnsC|RowsC]),
	times2([ColumnsA|RowsA], [ColumnsX|RowsX], [ColumnsC|RowsC]),
	%times2([[EntryA|ColumnsA]|RowsA], [ColumnsX|RowsX], [ColumnsC|RowsC]),
	write("FIN times2"),nl.


% ============================================= Transpose (i,o)
/*
This was a little bit trickier because the traversal couldn't be done as
with the sum clause. We basically transpose the first column, reducing
the matrix. Then we repeat the process working only with the submatrix
left.
*/

% Matrix is empty
transpose([[]|_], []).
% Starting point
transpose(Matrix, [Row|Rows]) :-
	transposeCol(Matrix, Row, SubMatrix),
	transpose(SubMatrix, Rows).

% End of column transposition
transposeCol([], [], []).

% Will transpose a column
transposeCol([[ EntryA| ColumnsA]|RowsA], [ EntryA| SubRow], [ ColumnsA | Rows]) :-
	transposeCol(RowsA, SubRow, Rows).

% ============================================= Print Matrix(i)
/*
This clause traverses the matrix as in the "sum" clause, while printing
the matrix entries.
*/

printM([ [] | [] ]):- nl,nl,!.

%End of Row?
printM([ []|ColumsA]):-
	nl, printM(ColumsA).

%Main Method
printM([[EntryA | ColumnsA] | RowsA]):-
	write(EntryA),write(" "),
	printM([ColumnsA|RowsA]).
