.model small
.stack 100h
.386

.data
    prompt db "Hello! What's your name?"
    db 10, "ENTER your name: $"
    welcome db 0ah, "Welcome to the APU inventory menu, $"
    banner db "========== APU INVENTORY MENU ==========$"
    message1 db "1. Pen - $"
    pen dw 10
    message2 db "2. Pencil - $"
    pencil dw 5
    message3 db "3. Ruler - $"
    ruler dw 20
    message4 db "4. Book - $"
    book dw 15
    message5 db "5. Marker - $"
    marker dw 25
    buffer db 80
    inp db 80 dup('$')
    prompt1 db "ENTER the item number you want to edit: $"
    itemmenu db "1. ADD"
    db 10, "2. SUBTRACT"
    db 10, "ENTER your choice: $"
    exitmsg db "Thanks for using the APU inventory menu..."
    db 10, "Created by yours truly,"
    db 10, "Wong Kar Kin. $"

.code
    main proc
        mov ax, @data 		; initialize
        mov ds, ax

	mov ah, 09h 		; outputs prompt
	mov dx, offset prompt
	int 21h

	mov ah, 0ah		; get string input
	mov dx, offset buffer
	int 21h

	mov ah, 09h		; outputs welcome message
	mov dx, offset welcome
	int 21h

	mov ah, 09h		; outputs user name
	mov dx, offset inp+1
	int 21h

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	call menu

    main endp

    menu proc

	mov ah, 02h	; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h		;Display banner
	mov dx, offset banner
	int 21h;

	mov ah, 02h	; line break
	mov dx, 0ah
	int 21h

        mov ah, 09h  ; Display message for pen
        mov dx, offset message1
        int 21h

        mov ax, pen; Display pen number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h; Display message for pencil
	mov dx, offset message2
	int 21h

	mov ax, pencil; Display pencil number
	mov bx, 10	; Base 10 for decimal conversion
	call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

        mov ah, 09h  ; Display message for ruler
        mov dx, offset message3
        int 21h

        mov ax, ruler; Display ruler number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

        mov ah, 09h  ; Display message for book
        mov dx, offset message4
        int 21h

        mov ax, book ; Display book number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

        mov ah, 09h  ; Display message for marker
        mov dx, offset message5
        int 21h

        mov ax, marker ; Display marker number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; Display prompt1 message
	mov dx, offset prompt1
	int 21h

	mov ah, 0ah    ; get string input
	mov dx, offset buffer
	int 21h

	mov al, inp[1] ; Extract the first character from the input

	cmp al, '1'
	je penmenu

	cmp al, '2'
	je pencilmenu

	cmp al, '3'
	je rulermenu

	cmp al, '4'
	je bookmenu

	cmp al, '5'
	je markermenu

	jmp exit
    menu endp

    display_number proc
        push ax
        push bx
        push cx
        push dx

        mov cx, 0     ; Initialize counter
        mov bx, 10    ; Base 10 for decimal conversion

    convert_loop:
        xor dx, dx    ; Clear dx for division
        div bx        ; Divide ax by bx
        add dl, 48    ; Convert remainder to ASCII digit
        push dx       ; Push the digit onto the stack
        inc cx        ; Increment counter
        test ax, ax   ; Check if ax is zero
        jnz convert_loop

    highlight_loop:
	cmp cx, 1
	je highlight
	jmp print_loop

    highlight:
	mov ah, 09h
	mov bl, 8ch
	int 10h


    print_loop:
        pop dx        ; Pop digit from the stack
        mov ah, 02h   ; Display character function
        int 21h       ; Print the digit
        loop print_loop

        pop dx
        pop cx
        pop bx
        pop ax
        ret

    display_number endp

    penmenu proc
	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output message1
	mov dx, offset message1
	int 21h

        mov ax, pen; Display pen number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output itemmenu
	mov dx, offset itemmenu
	int 21h

	mov ah, 0ah    ; get string input
	mov dx, offset buffer
	int 21h

	mov al, inp[1] ; Extract the first character from the input

	cmp al, '1'
	je addPen

	cmp al, '2'
	je subPen

	jmp menu

    addPen:
	add pen, 1
	jmp penmenu

    subPen:
	sub pen, 1
	jmp penmenu

    penmenu endp

    pencilmenu proc
	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output message2
	mov dx, offset message2
	int 21h

        mov ax, pencil; Display pencil number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output itemmenu
	mov dx, offset itemmenu
	int 21h

	mov ah, 0ah    ; get string input
	mov dx, offset buffer
	int 21h

	mov al, inp[1] ; Extract the first character from the input

	cmp al, '1'
	je addPencil

	cmp al, '2'
	je subPencil

	jmp menu

    addPencil:
	add pencil, 1
	jmp pencilmenu

    subPencil:
	sub pencil, 1
	jmp pencilmenu

    pencilmenu endp

    rulermenu proc
	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output message3
	mov dx, offset message3
	int 21h

        mov ax, ruler ; Display ruler number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output itemmenu
	mov dx, offset itemmenu
	int 21h

	mov ah, 0ah    ; get string input
	mov dx, offset buffer
	int 21h

	mov al, inp[1] ; Extract the first character from the input

	cmp al, '1'
	je addRuler

	cmp al, '2'
	je subRuler

	jmp menu

    addRuler:
	add ruler, 1
	jmp rulermenu

    subRuler:
	sub ruler, 1
	jmp rulermenu

    rulermenu endp

    bookmenu proc
	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output message4
	mov dx, offset message4
	int 21h

        mov ax, book; Display book number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output itemmenu
	mov dx, offset itemmenu
	int 21h

	mov ah, 0ah    ; get string input
	mov dx, offset buffer
	int 21h

	mov al, inp[1] ; Extract the first character from the input

	cmp al, '1'
	je addBook

	cmp al, '2'
	je subBook

	jmp menu

    addBook:
	add book, 1
	jmp bookmenu

    subBook:
	sub book, 1
	jmp bookmenu

    bookmenu endp

    markermenu proc
	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output message5
	mov dx, offset message5
	int 21h

        mov ax, marker; Display marker number
        mov bx, 10     ; Base 10 for decimal conversion
        call display_number

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h ; output itemmenu
	mov dx, offset itemmenu
	int 21h

	mov ah, 0ah    ; get string input
	mov dx, offset buffer
	int 21h

	mov al, inp[1] ; Extract the first character from the input

	cmp al, '1'
	je addMarker

	cmp al, '2'
	je subMarker

	jmp menu

    addMarker:
	add marker, 1
	jmp markermenu

    subMarker:
	sub marker, 1
	jmp markermenu

    markermenu endp

    exit proc
	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 02h ; line break
	mov dx, 0ah
	int 21h

	mov ah, 09h
	mov dx, offset exitmsg
	int 21h

        mov ah, 4ch ; Terminate the program
        int 21h
    exit endp

end main