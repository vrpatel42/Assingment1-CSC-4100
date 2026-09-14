.text
.global print_progress
.type print_progress, %function

print_progress:
    /* row is in              w0
       column is in           w1
       address of label is in x2
       percent is in          w3
       width is in            w4 */

    /* save x29 and x30 */
    sub     sp, sp, #80
    stp     x29, x30, [sp]
    mov     x29, sp

    /* save registers from x19 to x28 that are used
       as local variables */
    stp     x19, x20, [sp, #16]
    stp     x21, x22, [sp, #32]
    stp     x23, x24, [sp, #48]
    stp     x25, x26, [sp, #64]

    /* Save incoming arguments into callee-saved registers */
    mov     w19, w0              /* row */
    mov     w20, w1              /* column */
    mov     x21, x2              /* address of label */
    mov     w22, w3              /* percent */
    mov     w23, w4              /* width */

    /* print the message using print_to()
       with row, column, and label address */
    mov     w0, w19
    mov     w1, w20
    mov     x2, x21
    bl      print_to

    /* if percent is above 100 then return 1 */
    cmp     w22, #100
    bhi     .return_with_error

    /* calculate the number of '=' to draw
       (percent * width) / 100 using mul and udiv */
    mul     w24, w22, w23
    mov     w9, #100
    udiv    w24, w24, w9

    /* w24 now contains the count of '=' characters */

    /* call strlen() on label address */
    mov     x0, x21
    bl      strlen

    /* save length of label */
    mov     w25, w0

    /* put '=' in a local variable */
    mov     w26, #61             /* ASCII '=' */

.loop:
    /* if count of equal signs is zero,
       put a space in the local variable */
    cbz     w24, .use_space

.continue_loop:
    /* if width is 0, return successfully */
    cbz     w23, .return_ok

    /* call putc_to() to print '=' or space
       at column + length of label string */
    mov     w0, w19
    add     w1, w20, w25
    mov     w2, w26
    bl      putc_to

    /* increment column by 1 */
    add     w20, w20, #1

    /* decrement count of equal signs by 1
       only if it has not already reached zero */
    cbz     w24, .skip_equal_decrement
    sub     w24, w24, #1

.skip_equal_decrement:
    /* decrement width by 1 */
    sub     w23, w23, #1

    /* continue loop */
    b       .loop

.use_space:
    /* equal-sign count reached zero,
       so use spaces for the remaining width */
    mov     w26, #32             /* ASCII space */
    b       .continue_loop


.return_with_error:
    mov     w0, #1
    b       .done


.return_ok:
    mov     w0, #0


.done:
    /* clean up the stack and restore registers */
    ldp     x19, x20, [sp, #16]
    ldp     x21, x22, [sp, #32]
    ldp     x23, x24, [sp, #48]
    ldp     x25, x26, [sp, #64]

    ldp     x29, x30, [sp]
    add     sp, sp, #80
    ret

.size print_progress, .-print_progress