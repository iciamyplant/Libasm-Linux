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
	mov		rax, 0
	syscall
	cmp		rax, 0
	jl		erreur
	ret

erreur:
	neg		rax
	mov		rdi, rax
	call		__errno_location
	mov		[rax], 	rdi
	mov		rax, -1
	ret
