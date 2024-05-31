; Program Description:
; Author:
; Creation Date:
; Revisions: 
; Date:              Modified by:

.386
.model flat, stdcall
.stack 4096
INCLUDE irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

MyStruct STRUCT
    ID DWORD ?
    NUM DWORD ?
MyStruct ENDS

.data
MyArray MyStruct 10 DUP({0,0})

count DWORD ?

msgMenu byte "Press 1 to Search, Press 2 to Add: ", 0

msgRunAgain byte "Press 1 to Run Again OR Any Other Key To Exit: ", 0

msgSearchPrompt byte "Enter the ID you want to search for: ", 0

msgInvalidInput byte "Invalid Input", 0

msgInvalidID byte "Invalid ID", 0

msgArrayFull byte "Array Full", 0

msgDeletePrompt byte "Enter 1 to Delete or any other key to run again: ", 0

msgPhonePrompt byte "Enter Phone Number: ", 0

msgIDNumber byte "ID Number: ", 0

msgPhoneNumber byte "Phone Number: ", 0

.code
main PROC
    mov edx, 0
    mov esi, 0
    mov MyArray[esi].ID, 1
    mov MyArray[esi].NUM, 03135422585
    mov ebx, 0

    mov edx, offset msgIDNumber
    call WriteString
    mov eax, MyArray[0].ID
    call WriteDec  
    call crlf
    mov edx, offset msgPhoneNumber
    call WriteString
    mov eax, MyArray[0].NUM
    call WriteDec
    call crlf
                                 
    add esi, SIZEOF MyStruct
    mov MyArray[esi].ID, 2
    mov MyArray[esi].NUM, 03455455789
    mov ebx, 0
    mov edx, 0
    call crlf

    mov edx, offset msgIDNumber
    call WriteString
    mov eax, MyArray[esi].ID
    call WriteDec
    call crlf
    mov edx, offset msgPhoneNumber
    call WriteString
    mov eax, MyArray[esi].NUM
    call WriteDec 
    call crlf

    mov count, 2

MenuLoop:

    mov edx, offset msgMenu
    call crlf
    call WriteString
    Call readInt
    call clrscr
    cmp eax, 1
    je SearchOption
    cmp eax, 2
    je AddOption
    jmp InvalidInput
    
SearchOption:
    call Search
    call DeleteOption
    jmp RunAgainPrompt
    
AddOption:
    call AddRecord
    call DisplayRecords
    jmp RunAgainPrompt
    
InvalidInput:
    mov edx, offset msgInvalidInput
    call crlf
    call WriteString
    jmp RunAgainPrompt
    

RunAgainPrompt:
    mov edx, offset msgRunAgain
    call crlf
    call WriteString
    call ReadInt
    cmp eax, 1
    je MenuLoop
    jmp ExitProgram

ExitProgram:
    INVOKE ExitProcess, 0

main ENDP

; (insert additional procedures here)

Search proc
    call crlf
    mov edx, offset msgSearchPrompt
    call crlf
    call WriteString
    call Readint
    mov ecx, LENGTHOF MyArray
    mov esi, 0

SearchLoop:
    cmp eax, MyArray[esi].ID
    jne NotFound
    call crlf
    mov edx, offset msgIDNumber
    call WriteString
    mov eax, MyArray[esi].ID
    call WriteDec
    call crlf
    mov edx, offset msgPhoneNumber
    call WriteString
    mov eax, MyArray[esi].NUM
    call WriteDec
    call crlf
    jmp EndSearch

    NotFound:
    add esi,sizeof mystruct
    loop SearchLoop
    mov edx, offset msgInvalidID
    call crlf
    call WriteString
    call crlf

    EndSearch:
    ret

Search endp

AddRecord proc 
    mov esi, 0
    mov ecx, sizeof MyArray

AddRecordLoop:
    cmp MyArray[esi].ID, 0
    je RecordEmpty
    add esi, sizeof MyStruct
    loop AddRecordLoop
    jmp ArrayFull

RecordEmpty:
    inc count
    mov ebx, count
    mov MyArray[esi].ID, ebx
    mov edx, offset msgPhonePrompt
    call crlf 
    call WriteString
    call ReadDec
    mov MyArray[esi].NUM, eax
    ret

ArrayFull:
    mov edx, offset msgArrayFull
    call crlf
    call WriteString
    ret

AddRecord endp

DisplayRecords PROC
    mov ecx, LENGTHOF MyArray
    mov esi, 0

DisplayLoop:
    cmp ecx,0          
    je DisplayDone 

    cmp MyArray[esi].ID, 0
    je SkipRecord
    call crlf
    mov edx, offset msgIDNumber
    call WriteString
    mov eax, MyArray[esi].ID
    call WriteDec
    call crlf
    mov edx, offset msgPhoneNumber
    call WriteString
    mov eax, MyArray[esi].NUM
    call WriteDec
SkipRecord:
    add esi, SIZEOF MyStruct
    dec ecx
    jmp DisplayLoop   
DisplayDone:
 ret
DisplayRecords ENDP

DeleteOption proc
    mov edx, offset msgDeletePrompt
    call crlf
    call WriteString
    call ReadInt
    cmp eax, 1
    jne NoDelete
    call DeleteRecord
NoDelete:
    ret

DeleteOption endp

DeleteRecord proc
    mov MyArray[esi].ID, 0
    mov MyArray[esi].NUM, 0
    call DisplayRecords
    ret
DeleteRecord endp

END main