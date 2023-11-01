INCLUDE LIB1.ASM
.MODEL small
.STACK 100h
.DATA
      mTieuDe  db 13, 10, 'LIEU MAY TINH CO FPU'
               db 13, 10, '-------------------------------'
               db 13, 10, 'May tinh dang dung co FPU: $'
      mCo      db 'Co!$'
      mKhong   db 'Khong!$'
      mTiepTuc db 13,10,'Co tiep tuc chuong trinh (c/k)? $'
.CODE
      MAIN: 
            mov        ax, @data
            mov        ds, ax

            CLRSCR
            HienString mTieuDe

            xor        ax, ax
            mov        es, ax
            mov        bx, 410h
            mov        ax, es:[bx]

            shr        al, 2

            jnc        Khong
            HienString mCo
            jmp        Exit
      Khong:
            HienString mKhong

      Exit: 
            mov        ah, 4ch
            int        21h
            INCLUDE    LIB2.ASM
            INCLUDE    LIB3.ASM
END MAIN