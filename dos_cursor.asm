push bp
sub sp, 32
mov bp, sp

; text mode          
mov ah, 0
mov al, 3
int 10h

xor ax, ax
mov [bp+0], ax ; x = 0
mov [bp+2], ax ; y = 0
         
; screen buffer          
mov ax, 0b800h
mov ds, ax

mov ax, 0b2ah
mov ds:[0], ax

MainLoop:
    mov ah, 0
    int 16h
    cmp ah, 4bh
    je KeyPressed_Left
    cmp ah, 4dh
    je KeyPressed_Right
    cmp ah, 48h
    je KeyPressed_Up
    cmp ah, 50h
    je KeyPressed_Down    
    jmp Show_Asterisk
    
    KeyPressed_Left:
    mov ax, 0f1bh
    mov [bp+4], ax
    call PrintChar
    mov ax, [bp+0]
    cmp ax, 0
    je DontMoveLeft  
        dec ax
    DontMoveLeft:
    mov [bp+0], ax
    jmp Show_Asterisk
    
    KeyPressed_Right:
    mov ax, 0f1ah
    mov [bp+4], ax
    call PrintChar
    mov ax, [bp+0]
    cmp ax, 79
    je DontMoveRight  
        inc ax
    DontMoveRight:
    mov [bp+0], ax
    jmp Show_Asterisk

    KeyPressed_Up:
    mov ax, 0f18h
    mov [bp+4], ax
    call PrintChar
    mov ax, [bp+2]
    cmp ax, 0
    je DontMoveUp
        dec ax
    DontMoveUp:
    mov [bp+2], ax
    jmp Show_Asterisk

    KeyPressed_Down:
    mov ax, 0f19h
    mov [bp+4], ax
    call PrintChar
    mov ax, [bp+2]
    cmp ax, 24
    je DontMoveDown
        inc ax
    DontMoveDown:
    mov [bp+2], ax
    jmp Show_Asterisk
              
              
    Show_Asterisk:
    mov ax, 0b2ah    
    mov [bp+4], ax
    call PrintChar
    
    jmp MainLoop
    
    PrintChar:    
        ; (y * 80) + x                     
        mov ax, [bp+2]
        mov cx, 80
        mul cx
        add ax, [bp+0]
        shl ax, 1
        mov bx, ax
    
        mov ax, [bp+4]
        mov ds:[bx], ax
        ret
    

add sp, 32
pop bp         


ret




