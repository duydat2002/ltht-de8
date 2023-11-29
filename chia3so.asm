INCLUDE LIB1.ASM
.MODEL small
.STACK 100h
.DATA
  tieuDe   db 13, 10, 'TRUNG BINH CONG HAI SO NGUYEN'
           db 13, 10, '-------------------------------$'
  nhapSo1  db 13, 10, 'Hay vao so thu nhat: $'
  nhapSo2  db 13, 10, 'Hay vao so thu hai: $'
  nhapSo3  db 13, 10, 'Hay vao so thu ba: $'
  ketQua   db 13, 10, 'TBC ba so nguyen la: $'
  dauAm    db '-$'
  phay3    db '.33$'
  phay6    db '.66$'
  mTiepTuc db 13,10,'Co tiep tuc chuong trinh (c/k)? $'
.CODE
  MAIN:   
          mov        ax, @data
          mov        ds, ax

          CLRSCR
          HienString tieuDe

          HienString nhapSo1
          call       VAO_SO_N
          mov        bx, ax

          HienString nhapSo2
          call       VAO_SO_N
          mov        cx, ax

          HienString nhapSo3
          call       VAO_SO_N
          
          xor        dx, dx
          add        ax, bx
          add        ax, cx


          mov        bx, 3

  ; add ax, ax
  ; Nếu ax < 0 thì SF = 1. -> js
  ; Nếu ax ≥ 0 thì SF = 0. -> jns
  ; Nếu ax = 0 thì ZF = 1. -> jz
  ; Nếu ax ≠ 0 thì ZF = 0. -> jnz

          cmp        ax, 0
          jge        DUONG
          neg        ax
          neg        bx
 
  DUONG:  
          idiv       bx

          HienString ketQua
          cmp        ax, 0
          jne        HienKQ
          HienString dauAm
          
  HienKQ: 
          call       HIEN_SO_N

          cmp        dx, 0
          je         TiepTuc

          cmp        dx, 1
          je         Du1
          HienString phay6
          jmp        TiepTuc


  Du1:    
          HienString phay3
  TiepTuc:
          HienString mTiepTuc
          mov        ah, 01h
          int        21h
          cmp        al,'c'
          jne        Exit
          jmp        MAIN

  Exit:   
          mov        ah, 4ch
          int        21h
          INCLUDE    LIB2.ASM
          INCLUDE    LIB3.ASM
END MAIN