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



%Main Method
main:-
	k(K),
	l(L),
	m(M),
	%% sum( K, L, X),
	transpose( M, X), 
	write(X).


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
% Matrix is empty
sum([ [] | [] ], [ [] | [] ], [ [] | []]):- !.

% End of Row?
sum([ [] | ColumsA ] ,[ [] | ColumnsB ], [ [] | ListC ]):-
	sum(ColumsA, ColumnsB, ListC).

% Main Method
sum( [ [ EntryA | ColumnsA] | RowsA ], [ [ EntryB | ColumnsB] | RowsB], [ [ EntryC | ColumnsC ] | RowsC]):-
	EntryC is EntryA + EntryB,
	sum( [ ColumnsA | RowsA], [ColumnsB | RowsB], [ColumnsC| RowsC]).


% ============================================= Transpose (i,o)
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
printM([ [] | [] ] ):-  nl, nl, !.

% End of Row?
printM([ [] | ColumsA ] ):-
	nl, printM(ColumsA).

% Main Method
printM( [ [ EntryA | ColumnsA] | RowsA ]):-
	write( EntryA ), write(" "),
	printM( [ ColumnsA | RowsA]).



