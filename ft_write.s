; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_write.s                                         :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: ebourdit <marvin@42.fr>                    +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2021/01/04 11:26:34 by ebourdit          #+#    #+#              #
;    Updated: 2021/01/04 11:28:46 by ebourdit         ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

global	ft_write
extern	__errno_location

ft_write:
	mov		rax, 1			; syscall a write
	syscall
	cmp		rax, 0			; compare si le retour du syscall est egal a 0
	jl		error			; si rax est inferieur a 0 on va a error
	ret					; return rax

error:
	neg		rax			; car le syscall renvoie dans rax errno mais en negatif
	mov		rdi, rax		; rdi sert de tampon car apres rax prendera le retour de errno location
	call		__errno_location	; errno location renvoie un pointeur sur errno
	mov		[rax], rdi		; ici rax contient l'adresse de errno donc en faisant ca on met rdi dans errno
	mov		rax, -1			; on met rax à -1 pour renvoyer la bonne valeur d'un appel à write
	ret					; return rax
