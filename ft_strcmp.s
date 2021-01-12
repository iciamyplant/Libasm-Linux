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

global	ft_strcmp

ft_strcmp:
	xor		rcx, rcx		; on met rcx à 0
	xor		rax, rax		; on met rax à 0 

comp:
	cmp		BYTE[rdi + rcx], 0	; si rdi[rcx] == '\0' --> ZF = 1
	jz		return			; si ZF = 1 on va à return
	cmp		BYTE[rsi + rcx], 0	; si rsi[rcx] == '\0' --> ZF = 1
	jz		return			; si ZF = 1 on va à return
	mov		al, BYTE[rsi + rcx]	; on met rsi[rcx] dans al pour pouvoir faire la comparaison
	cmp		BYTE[rdi + rcx], al	; si rdi[rcx] != rsi[rcx] --> ZF = 0
	jnz		return			; si ZF = 0 on va à return
	inc		rcx			; sinon les deux caracteres sont egaux on incrémente rcx
	jmp		comp			; et on continue à comparer

return:
	movzx		rax, BYTE[rdi + rcx]	; copie le contenu de droite(8bits) dans rax(64bits)
	movzx		rdx, BYTE[rsi + rcx]	; copie le contenu de droite(8bits) dans rax(64bits)
	sub		rax, rdx		; soustrait rdx à rax et met le resultat dans rax
	ret					; return rax
