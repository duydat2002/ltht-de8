INCLUDE LIB1.ASM
.MODEL small
.STACK 100h
.DATA
  mNhapTen       db 13, 10, 'CHUC NANG SET ATT'
                 db 13, 10, '--------------------'
                 db 13, 10, 10, 'Hay vao ten tep: $'
  mChonThuocTinh db 13, 10, 'Thuoc tinh cua tep:'
                 db 13, 10, '0. Khong dat thuoc tinh'
                 db 13, 10, '1. Read only'
                 db 13, 10, '2. Hidden'
                 db 13, 10, '3. Read only + Hidden'
                 db 13, 10, '4. System'
                 db 13, 10, '5. Read only + System'
                 db 13, 10, '6. Hidden + System'
                 db 13, 10, '7. Read only + Hidden + System'
                 db 13, 10, '8. Archive'
                 db 13, 10, '9. Read only + Archive'
                 db 13, 10, '10. Hidden + Archive'
                 db 13, 10, '11. Read only + Hidden + Archive'
                 db 13, 10, '12. System + Archive'
                 db 13, 10, '13. Read only + System + Archive'
                 db 13, 10, '14. Hidden + System + Archive'
                 db 13, 10, '15. Read only + Hidden + System + Archive'
                 db 13, 10, 10, 'Hay chon: $'
                 
  mErrMoTep      db 13, 10, 'Tep khong ton tai! Error code: $'

  mErrSetAtt     db 13, 10, 'Khong them duoc att! Error code: $'
  mSucSetAtt     db 13, 10, 'Them att thanh cong!$'

  mAtt           db 13, 10, 'Thuoc tinh cua tep la: $'
  mErrGetAtt     db 13, 10, 'Khong doc duoc att! Error code: $'

  mTiepTuc       db 13, 10, 10, 'Co tiep tuc chuong trinh (c/k)? $'
  buff           db 30
                 db ?
  dir_name       db 30 dup(?)
.CODE
  MAIN:      
             mov        ax, @data
             mov        ds, ax

  NhapTenTep:
             CLRSCR
             HienString mNhapTen
             lea        dx, buff
             call       GET_FILE_NAME

             mov        ah, 43h
             mov        al, 0h
             lea        dx, dir_name
             int        21h

             jnc        SucMoTep
             HienString mErrMoTep
             call       HIEN_SO_N
             jmp        TiepTuc

  SucMoTep:  
             HienString mChonThuocTinh
             call       VAO_SO_N
             mov        cx, ax

             cmp        cx, 8
             jnge       DatAtt
             add        cx, 24

  DatAtt:    
             mov        ah, 43h
             mov        al, 01h
             lea        dx, dir_name
             int        21h

             jnc        SucThemAtt
             HienString mErrSetAtt
             call       HIEN_SO_N
             jmp        TiepTuc

  SucThemAtt:
             HienString mSucSetAtt
             mov        ah, 43h
             mov        al, 0h
             lea        dx, dir_name
             int        21h

             jnc        SucDocAtt
             HienString mErrGetAtt
             call       HIEN_SO_N

  SucDocAtt: 
             HienString mAtt
             mov        ax, cx
             call       HIEN_SO_N

  TiepTuc:   
             HienString mTiepTuc
             mov        ah, 01h
             int        21h
             cmp        al,'c'
             jne        Exit
             jmp        NhapTenTep
             
  Exit:      
             
             mov        ah, 4ch
             int        21h
             INCLUDE    LIB2.ASM
             INCLUDE    LIB3.ASM
END MAIN