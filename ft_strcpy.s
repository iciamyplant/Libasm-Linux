; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strcpy.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: ebourdit <marvin@42.fr>                    +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2021/01/04 11:13:44 by ebourdit          #+#    #+#              #
;    Updated: 2021/01/04 11:29:20 by ebourdit         ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

global ft_strcpy

ft_strcpy:
	xor		rcx, rcx			; on copie 0 dans rcx

loop:
	cmp		byte [rsi + rcx], 0		; si rsi[rcx] == '\0' --> ZF = 1
	jz		return				; si ZF = 1 on va à return
	mov		dl, [rsi + rcx]			; copie le caractere à copier (rsi[rcx]) dans dl (car dl fait un 1 octet)
	mov		[rdi + rcx], dl			; copie le caractere à copier qui est dans dl dans rdi[rcx]
	inc		rcx				; on incremente rcx
	jmp		loop				; on loop

return:
	mov		byte [rdi + rcx], 0		; on ajoute le 0 final
	mov		rax, rdi			; on met dans rax la char * qu'on renvoie
	ret
