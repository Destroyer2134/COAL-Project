; Program Description:
; Author:
; Creation Date:
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096
INCLUDE irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
MyStruct STRUCT
    field0 DWORD ?
    field1 DWORD ?
    ;field2 DWORD 10 Dup(?),0
MyStruct ENDS
.data
MyArray MyStruct 10 DUP({0,0})
var dword ?
msg0 byte"TO Search Press 1: ",0ah,0dh,"TO ADD PRESS 2:  ",0
msg00 byte"To Run Again Press 1: ",0
msg byte"Enter an Id u want to search: ",0
msg111 byte"Invalid Input ",0
msg1 byte"Invalid ID ",0
msg11 byte"Array Full ",0
msg2 byte"If u wanna delete Press 1: ",0
msg3 byte "Enter Phone Number: ",0
;msg4 byte "Enter Name: ",0
msg33 byte "ID Number: ",0
msg44 byte "Phone Number: ",0
.code
main PROC
  mov edx,0
  mov esi,0
  mov MyArray[esi].field0,1
  mov MyArray[esi].field1,03135422585
  mov ebx,0

                             ; mov MyArray[esi].field2[ebx],'H'
                              ;inc ebx
                              ;  mov MyArray[esi].field2[ebx],'a'
                               ; inc ebx
                                ; mov MyArray[esi].field2[ebx],'m'
                                ;inc ebx
                                ; mov MyArray[esi].field2[ebx],'m'
                                ;inc ebx
                                ; mov MyArray[esi].field2[ebx],'a'
                               ;  inc ebx
                                   ; mov Myarray[esi].field2[ebx],'d'
        mov edx, offset msg33
        call WriteString
        mov eax,MyArray[0].field0
         call writedec  
         call crlf
           mov edx, offset msg44
        call WriteString
        mov eax,MyArray[0].field1
         call WriteDec
         call crlf
                                 ; mov edx,offset MyArray.field2
                             ;call writeString   
  add esi, SIZEOF MyStruct
       mov MyArray[esi].field0,2
       mov MyArray[esi].field1,03455455789
  mov ebx,0
  mov edx,0
                      ;mov MyArray[esi].field2[ebx],'S'
                     ; inc ebx
                        ;mov MyArray[esi].field2[ebx],'a'
                        ;inc ebx
                        ; mov MyArray[esi].field2[ebx],'a'
                        ;inc ebx
                         ;mov MyArray[esi].field2[ebx],'d'
  call crlf
    mov edx, offset msg33
        call WriteString
   mov eax,MyArray[esi].field0
 call writedec
 call crlf
   mov edx, offset msg44
        call WriteString
  mov eax,MyArray [esi].field1
 call writedec 
 call crlf
                    ;mov edx,offset MyArray [8].field2
                    ; call writeString   
 mov var, 2
 l0:
mov edx, offset msg0
call  crlf
call WriteString
Call readInt
cmp eax,1
je ls
cmp eax,2
je la
jmp ji
ls:
            call search
 la:
             call addP
             call Display
             jmp l0
             jmp exitLB
ji:
        mov edx,offset msg111
        call crlf
        call WriteString
        mov edx, offset msg00
        call WriteString
        call ReadInt
        cmp eax,1
        je l0
        jmp exitLB


 

 END2LB::
 call crlf
 mov edx, offset msg11
 call WriteString
 jmp exitLB
 ENDLB::
 mov edx, offset msg2
 call crlf
 call WriteString
 call ReadInt
 cmp eax, 1
jne l0
call delete
 jmp exitLB

 exitLB::
	INVOKE ExitProcess,0
main ENDP
; (insert additional procedures here)
search proc
            call crlf
            mov edx, offset msg
            call crlf
            call WriteString
            call Readint
            mov ecx, lengthof myArray
            mov esi,0
            l1:
            cmp eax, myArray[esi].field0
            jne l2
            call crlf
            mov edx, offset msg33
                   call WriteString

            mov eax, myArray[esi].field0
            
            call WriteDec
            call crlf
            mov edx, offset msg44
                   call WriteString
            mov eax, myArray[esi].field1
            
            call WriteDec
                                ;mov edx,myArray[esi].field2
                                ;call WriteString
            jmp ENDLB
            l2:
            add esi, 4
            loop l1
            mov edx, offset msg1
            call crlf
            call WriteString
ret
search endp


addP proc 
                   
                    mov esi, 0
                    mov ecx, sizeof MyArray
                    lop:
                    cmp MyArray[esi].field0, 0
                    je empty
                    add esi, sizeof MyStruct


                    loop lop
                    jmp END2LB









                    
                    inc var
                    mov ebx, var
                    ;mov eax, sizeof MyStruct
                   ; mul var
                    ;mov esi, eax
                    empty:
                     inc var
                     mov ebx, var
                    mov myArray[esi].field0,ebx
                    mov edx, offset msg3
                    call crlf 
                    call Writestring
                    call ReadDec
                    mov myArray[esi].field1,eax
                                           ; mov edx, offset msg4
                                            ;call crlf 
                                           ; call WriteString
                                        ;mov edx, myArray[esi].field2
                                        ;mov ecx, 10
                                        ;call ReadString
                                        ;mov myArray[esi].field2,eax
                                        
ret
addp endp
Display PROC
    mov ecx, LENGTHOF MyArray
    mov esi, 0

displayLoop:
                cmp MyArray[esi].field0, 0
                je skip
                call crlf
                  mov edx, offset msg33
                   call WriteString
                mov eax, MyArray[esi].field0
                call WriteDec
                call crlf
                  mov edx, offset msg44
                     call WriteString
                mov eax, MyArray[esi].field1
                call WriteDec
                add esi, type MyStruct
                dec ecx
                jnz displayLoop
            skip:

                ret
Display ENDP


delete proc
mov MyArray[esi].field0, 0
mov MyArray[esi].field1,0
dec var
call display
ret
delete endp
END main