print_progress:
 /* row is in              w0
    column is in           w1
    address of label is in x2
    percent is in          w3
    width is in            w4 */
    save x29 and x30
    save any registers from x19 to x28 that you may use as local variables
    print the message using print_to() with argument for row, column, and label address
    if percent is above 100 then return 1  /* error, called with bad parameters */
    calculate the the number of '=' to draw using mul and udiv  /* (percent x width)/100 */
        /* leave answer is a register acting as a local variable, say x19 */
    call strlen() on label address  (put in a register, say x20 */
    put '=' in a local variable (say x21)
    loop
           if count of equal signs (in x19) is zero
                put ' ' (space) in local variable (x21)
           if width is 0
               return (i.e. jump to .return_ok)
           call putc_to to print the "=" (or the space) at column + length of label string (in x20)
           increment column by 1
           decrement count of equal signs by 1 (x19)
           decrement width by 1 
    end loop
.return_with_with_error:
    mov w0, 1
   b      done
.return_ok:
    mov  w0, 0
.done
    clean up the stack
    ret
