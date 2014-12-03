.data
        initial_message:    .asciiz "Welcome to Postfix calculator by Marcus Gabilheri.\n"
        ask_input: .asciiz "Type a valid postfix expression: "
        maxlen: .word 31
        buffer: .space 31
        timesc: .ascii "*"
        plusc:  .ascii "+"
        minusc: .ascii "-"
        divc:  .ascii "/"
        spacec: .ascii " "
        dot: .ascii "."
.text
 
main:
 
# print "type an expression"
li $v0, 4
la $a0, initial_message
syscall     

la $a0, ask_input
syscall  
 
# prepare to read string
la $a0, buffer
lw $a1, maxlen
 
# read string
li $v0, 8
syscall
 
# load LF to $t3
li $t3, 10
 
# load op * to $t4
lb $t4, timesc
 
# load op + to $t5
lb $t5, plusc
 
# load op - to $t6
lb $t6, minusc
 
# load op / to $t7
lb $t7, divc
 
# load op " " to $t8
lb $t8, spacec
 
######## loop
loop:
               
  # get a byte from the string
  lb $t0, 0($a0)
 
  # increase char pointer
  addi $a0, $a0, 1
 
  # save next char to $t9
  lb $t9, 0($a0)
 
  # check for end
  beq $t0, $t3, done
  beq $t0, $0, done
 
  # branch if it's an op [op]
 blt $t0, 48, op
 bgt $t0, 57, op
 
 # start read num
 jal readNum
 nop

###### push
push:
 
 # move stack pointer up
 addi $sp, $sp -4
 
 # add $t0 to stack
 sw $t0, 0($sp)
 
 # branch back to loop [loop]
 b loop
 nop
 
###### op
op:
 
 # branch if it's space [space]
  beq $t0, $t8, space
  nop
 
 
  # op now in $t0, branch to appropriate operation procedures [times, plus, minus, over]
  beq $t0, $t4, times
  nop
  beq $t0, $t5, plus
  nop
  beq $t0, $t6, minus
  nop
  beq $t0, $t7, divv
  nop
 
  # branch back to loop
  b loop
  nop
 
####### times, plus, div:
 
# do operation, save result to $t0
# branch to next
 
  times:  
         jal pop2
         mul $t0, $t1, $t2
           b next
 
  plus:    
         jal pop2
         add $t0, $t1, $t2
           b next
 
  divv:    
         jal pop2
         div $t0, $t1, $t2
         b next
 
#### *** minus *** ###:
minus:
       
  # if it's the last character
 beq $t9, 10, normalSub
 nop
               
 # if the character after the '-' is not ' ', then branch to negative number reading:
 bne $t9, 32, negNumRead
 nop
 
# else:
 
normalSub:
 # get operands
 jal pop2
 nop
 
 # do - operation, save result $t0
 sub $t0, $t1, $t2
 
 # branch to next
 b next
 nop
 
#### negative number reading:
negNumRead:
 
 # make $t0 from the '-' to the next number
 # lb $t0, 0($t9)
 addi $t0, $t9, 0
 
 # increase char pointer
 addi $a0, $a0, 1
 
 # jal readNum
 jal readNum
 
 # addi -1 to $t9
 li $t9, -1
 
 # $t0 = $t0 * $t9
 multu $t0, $t9
 mflo $t0
 
 # b push  
 b push
 nop
 
####### space:
 
# branch to loop [loop]
space:  b loop
 
######## next:
next:
 
 # move stack pointer up to prepare adding $t0 to top
 sub $sp, $sp, 4
 
 # push result from $t0 to stack
 sw $t0, 0($sp)
 
 # branch back to loop [loop]
 b loop
 
####### readNum
readNum:
       
 # set current sum $s0 = 0
 li $s0, 0
 
 #### readNumLoop:
 readNumLoop:
       
   # $t0 now is a number
 
   # if reaches end of number, branch to endLoop [endLoop]
   blt $t0, 48, endLoop
   bgt $t0, 57, endLoop
 
   # get num value from $t0
   addi $t0, $t0, -48
 
   # sum = sum * 10
   multu $s0, $t3
   mflo $s0
 
   # sum = sum + $t0
   add $s0, $s0, $t0
 
   # read $t0 from $a0
   lb $t0, 0($a0)
 
   # increase char pointer
   addi $a0, $a0, 1
 
   # loop back to readNumLoop [readNumLoop]
   b readNumLoop
 
 ###### endLoop:
 endLoop:
       
   # push value back from $s0 to $t0
   add $t0, $0, $s0
 
   # jump back (to #### negative number reading or #### push)
   jr $ra
   nop
 
done:  
 
 # PULL the result from the stack
 lw $a0, 0($sp)      
 
 # Print the result
 li $v0, 1
 syscall    
 
 # end of program        
 li $v0, 10
 syscall            
 
pop2:
 
 # pop $t2 from stack
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 
 # pop $t1 from stack
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 
 jr $ra
 nop