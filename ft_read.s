; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_read.s                                          :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: ebourdit <marvin@42.fr>                    +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2021/01/04 11:07:38 by ebourdit          #+#    #+#              #
;    Updated: 2021/01/04 11:14:12 by ebourdit         ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

global	ft_read
extern	__errno_location

ft_read:
	mov		rax, 0			; syscall a read
	syscall
	cmp		rax, 0			; compare si le retour du syscall est egal a 0
	jl		error			; si rax est inferieur a 0 on va a error
	ret					; sinon on return rax

error:
	neg		rax			; car le syscall renvoie dans rax errno mais en negatif
	mov		rdi, rax		; rdi sert de tampon car apres rax prendera le retour de errno location
	call		__errno_location	; errno location renvoie un pointeur sur errno dans rax
	mov		[rax], 	rdi		; d'ou ici on met rdi dans errno
	mov		rax, -1			; on met -1 dans rax pour renvoyer la bonne valeur d'un appel a read
	ret					; return rax
