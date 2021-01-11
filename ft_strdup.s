; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strdup.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: ebourdit <marvin@42.fr>                    +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2021/01/04 11:17:07 by ebourdit          #+#    #+#              #
;    Updated: 2021/01/04 11:24:53 by ebourdit         ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

global ft_strdup
extern malloc
extern ft_strlen
extern ft_strcpy
extern __errno_location

ft_strdup:
	call	ft_strlen		; appelle ft_strlen(rdi) ou rdi est encore *s
	push	rdi				; rdi contient *s dont on aura besoin après pour ft_strcpy. On push dans la pile pour pas perdre *s
	inc		rax				; rax contient la taille renvoyée par ft_strlen, on incremente de 1 pr le \0
	mov		rdi, rax		; rdi sera envoyé a malloc donc doit etre egal au nombre de caractere de *s cad rax
	call	malloc			; on appelle malloc pour malloquer la nouvelle chaine de rax caracteres (renverra le pointeur sur la place mémoire dans rax)
	cmp		rax, 0			; si malloc echoue
	jz		error			; si echoue on return
	mov		rdi, rax		; on met rax dans rdi pour que rdi ai la place memoire pr ensuite envoyer a strcpy
	pop		rsi				; je remets *s dans rsi
	call	ft_strcpy		; copie rsi dans rdi
	ret

error:
	neg	rax
	mov	rdi,	rax
	call	__errno_location
	mov	[rax], rdi
	mov	rax, -1
	ret
