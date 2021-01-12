; **************************************************************************** #
;                                                                              #
;                                                         :::      ::::::::    #
;    ft_strlen.s                                        :+:      :+:    :+:    #
;                                                     +:+ +:+         +:+      #
;    By: ebourdit <marvin@42.fr>                    +#+  +:+       +#+         #
;                                                 +#+#+#+#+#+   +#+            #
;    Created: 2021/01/04 11:25:01 by ebourdit          #+#    #+#              #
;    Updated: 2021/01/04 11:33:34 by ebourdit         ###   ########.fr        #
;                                                                              #
; **************************************************************************** #

global ft_strlen

ft_strlen:
	xor		rcx, rcx				; on copie 0 dans rcx

loop:
	cmp		byte [rdi + rcx], 0			; si rsi[rcx] == '\0' --> ZF = 1
	jz		return					; si ZF = 1 on va à return
	inc		rcx					; sinon on incremente rcx
	jmp		loop					; boucler loop

return:
	mov 		rax, rcx				; on copie rcx dans rax car c'est rax qu'on renvoie
	ret							; return rax
