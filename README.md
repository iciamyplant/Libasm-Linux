# Libasm-Linux

# I - Comprendre le sujet
### En gros y a différentes composantes dans ton ordi :
- la ram (= mémoire ram ou mémoire vive)
- le stockage
- la carte graphique
- MAIS SURTOUT : le processeur (= le CPU) : c'est le cerveau de l'ordinateur : il calcule tout. Et y a différents types de processeurs, qui utilisent différents types de jeu d'instruction.

### Et c'est justement le processeur qui exécute les programmes qu'on code, sauf qu'il comprend que le langage binaire.

Assembleur = ensemble de langages de programmation. L’asm est la représentation lisible du langage binaire que comprend le processeur. Y a un langage assembleur par jeu d’instructions. 

Jeu d'instruction =  c’est les commandes que peut faire le processeur (jeu d’instruction ARM, X86, X64...)

ASM 64 bits = langage assembleur adapté au processeur ayant pour jeu d’instruction X64.

Asm inline = l'assembleur inline permet d'incorporer des instructions en langage assembleur directement dans des programmes sources C sans code assembleur ni étapes de liaison supplémentaires. 

Nasm = assembleur à utiliser pour tes fichiers .s

# II - Comment ai-je fait Libasm ? 5 étapes

## étape 1  : Comprendre les bases
Meilleure documentation à mes yeux. Elle utilise le format as et non Intel mais les deux se ressemblent beaucoup : [ici](https://perso.univ-st-etienne.fr/ezequel/L2info/coursAssembleur_x86_64.pdf) 

Deux autres documentations pas mal : [celle-ci](http://asmongueur.free.fr/Apprendre/Nasm/Intro_Nasm_Linux.htm) et [celle-la](https://www.lacl.fr/tan/asm)

Format :
extern *fonctionexterneutilisée*
global *fonctionglobaledéclarée*
segment. (pas obligatoire d’écrire les segments)
étiquette (par exemple _ft_strlen:)
instruction destination_operand, source_operand, last_operand

Paramètres envoyés à notre fonction assembleur :
ft_example(param1, param2, param3, param4,param5, param6)
rdi param1
rsi param2
rdx param3
rcx param4
r8 param5
r9 param6

Syntaxe :
[UnSymbole] = adresse mémoire du symbole
UnSymbole = valeur du symbole
[adresse] représente la valeur stockée à l'adresse adresse.
[Registre] = représente la valeur stockée à l’adresse contenue dans le registre
[01234ABC] = emplacement mémoire absolue
[DI] = contenu en octets du segment de données adressé par DI


## étape 2  : La compilation
Compilation :
installer nasm : brew install nasm
imaginons que j’ai un fichier main.c un fichier test.s et un fichier libasm.h
nasm -f macho64 -o test.o test.s
gcc main.c test.o libasm.h

nasm : 
Le outpout file format sur linux c’est : elf64
Et on fait -f avant pour : f you do not supply the -f option to NASM, it will choose an output file format for you itself. In the distribution versions of NASM, the default is always bin

## étape 3  : Les fonctions
appels systèmes dans :
ft_write
ft_read
ft_strdup
quand tu fais un printf, ce que fait vraiment printf dans son code, c'est faire des syscall à write() en fait
Les appels systèmes en assembleur :
Chaque appel système possède un numéro, qui est placé dans RAX.
Le système utilise sa propre pile, la pile du processus appelant n’est pas modifiée.
Les registres sont inchangés, sauf peut-être RCX et R11, RAX contient retour du syscall.

Un code assembleur agit directement sur le processeur - c'est à dire que tu ne peux manipuler que deux choses : les registres, et la mémoire.

Un registre c'est quoi ? C'est un entier de 32 bits ou de 64 bits selon ton architecture. Notamment, un registre ne peut pas contenir une chaine de caractères : "Hello world!" ça fait 13 octets ! Beaucoup trop gros pour rentrer dans un registre.

extern permet de dire au compilateur que l'on va appeler une fonction extérieure à notre programme.



## étape 4  : Gestion des erreurs
quand tu fais un appel système a write c’est pas la même que quand t’appelle la fonction write. l’appel système te renverra la valeur de errno (par exemple -14 avec un NULL) et pas -1 comme quand t’appelle la fonction write. l’appel system te renverra un int négatif, c’est la valeur qu’il faut envoyer a errno mais en négatif. d'où la raison pour laquelle il faut passer le retour de l’appel système en positif. sr
errno c’est un int il 
errno tu peux l’imprimer dans ton main

errno_location sur linux
 ___error sur mac
 
 errno location retourne un pointeur sur errno dans rax
 <errno.h>
int * __errno_location(void);
The __errno_location() function shall return the address of the errno variable for the current thread.

la variable entière errno qui est renseignée par les appels système (et quelques fonctions de bibliothèque) pour expliquer les conditions d'erreurs. Sa valeur n'est significative que lorsque l'appel système a échoué (généralement en renvoyant -1)

errno contient le code d’erreur


## étape 5  : Adapter à Linux
Adapter a Linux :
enlever l'underscore sur les fonctions
compiler avec : -felf64

# III - Les trucs utiles que j'ai appris
