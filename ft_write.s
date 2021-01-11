
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
	
    mov     rax,    1		; syscall a write
    syscall
	cmp		rax, 0
    jl      error			;si rax est inferieur a 0
    ret

error:
	neg		rax
	mov		rdi, rax
	call	__errno_location
	mov		[rax], rdi
	mov		rax,		-1
    ret
