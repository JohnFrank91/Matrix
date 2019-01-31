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
	z(Z)
	%toString(X).
	sum(K, L, Z),
	write(Z).

% Will hold the answer
 z([]).

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


sum([A | List1 ],[ B | List2], [ C | List3]):-
	D is A + B,
	sum( List1, List2, [ D | C List3 ])
.



toString( [X | Lista1]):-
	write(X), nl,
	toString(Lista1).






