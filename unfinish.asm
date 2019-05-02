DATAS SEGMENT
    a DW 14h,75h,23h,52h,10h,07h,39h,12h,61h,57h,14h,00h,41h,73h,42h,35h
DATAS ENDS

STACKS SEGMENT
   	DW 10 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS 
    
START:
	mov ax,DATAS
	mov ds,ax
	
	mov cx,10h          ;执行16次母循环
	dec cx
	
loop1:
	push cx             ;cx入栈，待之后出栈操作
	mov bx,0            ;bx作为子循环数据地址偏移量
	
loop2:
	mov ax,a[bx]
	cmp ax,a[bx+2]      ;比较a[bx]与a[bx+2]的数据大小
	jge continue        ;jle为转移指令，即：如果a[bx]大于或等于a[bx+2]，跳转至continue段执行；否则程序顺序执行
	xchg ax,a[bx+2]     ;将a[bx]与a[bx+2]数据交换
	mov a[bx],ax

continue:
	add bx,2            ;bx地址偏移量+2
	loop loop2          ;cx=cx-1，此时如果cx不等于0，跳转到loop2段；如果cx等于0，即一次母循环完成，程序顺序执行
	pop cx              ;cx出栈
	loop loop1          ;cx=cx-1，此时如果cx不等于0，跳转到loop1段；如果cx等于0，即全部母循环完成，程序顺序执行
	
CODES ENDS              ;程序代码段结束

    END START           ;程序结束