%Construa um banco de dados para representar os membros de uma família. Crie o predicado progenitor(X, Y) para representar o relacionamento %X é progenitor de Y.
%Represente em Prolog as relações sexo (masculino ou feminino), irmã, irmão, descendente,
%mãe, pai, avô, tio e primo. Os predicados progenitor e sexo devem ser fatos no banco de
%dados, os demais devem ser descritos como regras.


progenitor(cell,hugo).
progenitor(cell,jose).
progenitor(hugo,hudson).
progenitor(diva,hudson).
progenitor(hugo,maria).
progenitor(diva,maria).
progenitor(jose,carlos).
progenitor(joana,carlos).
progenitor(carlos,claudio).
homem(hugo).
homem(hudson).
homem(cell).
homem(jose).
homem(carlos).
homem(claudio).
mulher(diva).
mulher(maria).
mulher(joana).

pai(X,Y) :- progenitor(X,Y), homem(X).
mae(X,Y) :- progenitor(X,Y), mulher(X).

irmao(X,Y) :-
	progenitor(Z,X),
	progenitor(Z,Y),
	X \== Y,
	homem(X).
irma(X,Y) :-
	progenitor(Z,X),
	progenitor(Z,Y),
	x \== Y,
	mulher(X).

tio(X,Y) :-
	irmao(Z,X),
	pai(Z,Y).
tia(X,Y) :-
	irma(Z,X),
	mae(Z,Y).

avo(X,Y) :-
	progenitor(X,Z),
	pai(Z,Y).
ava(X,Y) :-
	progenitor(X,Z),
	mae(Z,Y).

primo(X,Y) :-
	irmao(A,B),
	progenitor(A,X),
	progenitor(B,Y),
	X\==Y.
prima(X,Y) :-
	irma(A,B),
	progenitor(A,X),
	progenitor(B,Y),
	X\==Y.

filhos(P,FL) :- 
	findall(F, progenitor(P,F), FL).


%Escreva, sem cortes, um predicado separa que separa uma lista de inteiros em duas
%listas: uma contendo os números positivos (e zero) e outra contendo os números negativos.
%Por exemplo:
%?- separa([3, 6, -2, 5, -1], P, N).
%P = [3, 6, 5],
%N = [-2, -1].

separa([NUM | Resto], [NUM | P], N) :-
    NUM >= 0, separa(Resto, P, N).
separa([NUM | Resto], P, [NUM | N]) :-
    NUM < 0, separa(Resto, P, N).
separa([], [], []). 


%Escreva um predicado segundo(Lista, X) que verifica se X é o segundo elemento de
%Lista.

segundo([_,X|_], X).


%Escreva um predicado iguaisL(Lista1, Lista2) que verifica se Lista1 é igual a Lista2.

iguaisL([],[]).
iguaisL([H1|T1],[H2|T2]) :-
    H1 == H2, iguaisL(T1,T2).


%Escreva um predicado duplica(E, S) em que o primeiro argumento é uma lista e o
%segundo argumento é uma lista obtida a partir da primeira duplicando cada um dos seus
%elementos. Por exemplo:
%?- duplica([3, a, j7], S).
%S = [3, 3, a, a, j7, j7].

duplica([],[]).
duplica([H|T], [H,H|T1]) :-
	duplica(T, T1).


%Escreva um predicado ultimo(L, X) que é satisfeito quando o termo X é o último elemento
%da lista L.

ultimo([X],X).
ultimo([_|Y],X) :-
	ultimo(Y,X).


%Escreva um predicado soma(L, R) que é satisfeito quando o termo R é igual a soma dos
%elementos da lista L. Assuma que a lista L possua apenas valores numéricos.

soma([X],X).
soma([H|T],X) :-
	soma(T,X1),
	X is X1+H.


%Conserte o predicado fatorial(N, F) para que não entre em loop em chamadas onde N é
%um número negativo e nem em chamadas verificadoras, onde ambos N e F vêm
%instanciados.
%fatorial(0, 1) :- !.
%fatorial(N, F) :- M is N - 1, fatorial(M, F1), F is F1*N.

fatorial(0, 1) :- !. 
fatorial(N, F) :-
	N > 0,
	M is N - 1, 
	fatorial(M, F1), 
	F is F1*N.


%Defina um predicado contiguo(L), que testa se uma lista tem dois elementos contíguos
%iguais. Exemplo:
%?- contiguo([a,s,s,d,f,e]).
%true
%?- contiguo([a,s,d,f,e]).
%false

contiguo([H,H|_]).
contiguo([_|T]) :-
	contiguo(T).


%Defina um predicado particiona(L, L1, L2), que recebe uma lista L de elementos como
%primeiro argumento e retorna duas listas como resposta. A lista L1 é formada pelos
%elementos de L que estejam em posições ímpares. A lista L2 é formada pelos elementos de
%L que estejam em posições pares. Exemplo:
%?- particiona([1,2,4,6,2], L1, L2).
%L1 = [1,4,2], L2 = [2,6]

particiona([], [], []).
particiona([X], [X], []).
particiona([H1,H2|T], [H1|PI], [H2|PP]) :-
	particiona(T, PI, PP).


%Defina um predicado mdc(A, B, R) que retorne o máximo divisor comum entre dois
%números. Exemplo:
%?- mdc(12, 18, R).
%R = 6

mdc(X, 0, R) :-
	!, R = X.
mdc(X, Y, R) :-
	R1 is X mod Y, mdc(Y, R1, R).


%Faça um predicado que indique o enésimo termo de uma lista qualquer. O predicado
%deve possuir três argumentos: o primeiro argumento é um número que indica a posição do
%enésimo termo da lista (assuma que o primeiro termo assuma a posição de índice 1 da
%lista); o segundo argumento é a lista propriamente dita; e o terceiro argumento é o valor do
%enésimo termo. Exemplo de uso:
%?- enésimo(2,[f,w,q,a,h],R).
%R = w

enesimo(1, [H|_], H).
enesimo(A, [_|T], R) :-
	enesimo(A1, T, R), A is A1+1.


%Escreva um predicado remover(L1,X,L2) que é satisfeito quando L2 é a lista obtida pela
%remoção da primeira ocorrência de X em L1. Exemplo de uso:
%?- remover([a,s,f,e,s,w], s, L2).
%L2 = [a, f, e, s, w]

remover([H|L1],H,L1).
remover([H1|L1],H,[H1|L2]) :-
	remover(L1, H, L2).


%Escreva um predicado remover_todas(L1,X,L2) que é satisfeito quando L2 é a lista
%obtida pela remoção de qualquer ocorrência de X em L1. Exemplo de uso:
%?- remover_todas([a,s,f,s,e,s,w], s, L2).
%L2 = [a, f, e, w]

remover_todas([],_,[]).
remover_todas([H|L1],H,L2) :-
	remover_todas(L1,H,L2).
remover_todas([H1|L1],X,[H1|L2]) :-
	X \== H1,
	remover_todas(L1,X,L2).


%Escreva um predicado remover_repetidos(L1,L2) que é satisfeito quando L2 é a lista
%obtida pela remoção dos elementos repetidos em L1. Exemplo de uso:
%?- remover_reptidos([a,s,a,f,s,f,s,f,a,e,s,w], L2).
%L2 = [a, s, f, e, w]

remover_todas([],_,[]).
remover_todas([H|L1],H,L2) :-
    remover_todas(L1,H,L2).
remover_todas([H1|L1],X,[H1|L2]) :-
    X \== H1,
    remover_todas(L1,X,L2).

remover_reptidos([],[]).
remover_reptidos([H|T1], [H|T2]) :-
    remover_todas(T1,H,L2),
    remover_reptidos(L2,T2).


%Escreva um predicado conjunto(L1, L2) que é satisfeito quando L1 é uma lista formada
%apenas por elementos presentes em L2. Assuma que o predicado será utilizado apenas
%com todos os argumentos instanciados. Exemplo de uso:
%?- conjunto([1,2,3,3,1,1,4,32,4,4,2],[1,2,3,4,32]). true. ?-
%conjunto([1,2,3,3,1,1,4,32,4,4,2],[1,2,3,4]). false.

conjunto([], []).
conjunto([H|L1],L2):-
	remover(H,L2,L3),
	conjunto(L1,L3).

remover(X,[X|T1],T1).
remover(X,[_|T1],[_|T2):-
	remover(X,T1,T2).


%Escreva um predicado produto(A, B, P) que é satisfeito quando P é igual ao produto de
%todos números compreendidos no intervalo [A,B]. Exemplo de uso:
%?- produto(3,5,P).
%P = 60

produto(A, A, A).
produto(A, B, P) :-
	produto(A1, B, P1),
	P1 is P*A,
	A is A1+1.


%Escreva um predicado inverter(L1,L2) que é satisfeito quando L2 possui seus elementos
%em ordem inversa a L1. Exemplo de uso:
%?- inverter([4,5,2,3,1,7],L2).
%L2 = [7,1,3,2,5,4]

concat([],L1,L1).
concat([H1|L1],L2,[H1|L3]) :-
	concat(L1,L2,L3).

inverter([],[]).
inverter([H|T1],L2) :-
	inverter(T1,T2),
	concat(T2,[H],L2).


%Considere a seguinte base de fatos em Prolog:
%aluno(joao, calculo).
%aluno(maria, calculo).
%aluno(joel, programacao).
%aluno(joel, estrutura).
%frequenta(joao, puc).
%frequenta(maria, puc).
%frequenta(joel, ufrj).
%professor(carlos, calculo).
%professor(ana_paula, estrutura).
%professor(pedro, programacao).
%funcionario(pedro, ufrj).
%funcionario(ana_paula, puc).
%funcionario(carlos, puc).
%Escreva as seguintes regras em Prolog: a) Quem são os alunos do professor X? b) Quem
%são as pessoas que estão associadas a uma universidade X? (alunos e professores)

aluno(joao, calculo). 
aluno(maria, calculo). 
aluno(joel, programacao). 
aluno(joel, estrutura). 
frequenta(joao, puc). 
frequenta(maria, puc). 
frequenta(joel, ufrj). 
professor(carlos, calculo). 
professor(ana_paula, estrutura). 
professor(pedro, programacao). 
funcionario(pedro, ufrj). 
funcionario(ana_paula, puc). 
funcionario(carlos, puc).

assiste(A,X):-
	professor(X,M),
	funcionario(X,U),
	frequenta(A,U),
	aluno(A,M).

associado(Y,U):-
	frequenta(Y,U);
	funcionario(Y,U).


%Suponha os seguintes fatos:
%nota(joao,5.0).
%nota(maria,6.0).
%nota(joana,8.0).
%nota(mariana,9.0).
%nota(cleuza,8.5).
%nota(jose,6.5).
%nota(jaoquim,4.5).
%nota(mara,4.0).
%nota(mary,10.0).
%Considerando que:
%Nota de 7.0 a 10.0 = Aprovado
%Nota de 5.0 a 6.9 = Recuperação
%Nota de 0.0 a 4.9 = Reprovado
%Escreva uma regra para identificar a situação de um determinado aluno.

nota(joao,5.0). 
nota(maria,6.0). 
nota(joana,8.0). 
nota(mariana,9.0). 
nota(cleuza,8.5). 
nota(jose,6.5). 
nota(jaoquim,4.5). 
nota(mara,4.0). 
nota(mary,10.0).

aprovado(A):-
	nota(A,N),
	N >= 7.0.

recu(A):-
	nota(A,N),
	N >= 5.0,
	N =< 6.9.

reprovado(A):-
	nota(A,N),
	N =< 4.9.
