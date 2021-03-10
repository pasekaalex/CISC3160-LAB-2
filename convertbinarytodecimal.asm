.data
prompt: .asciiz "Enter a binary number: "
binary: .space 16
newLine: .asciiz "\n"
decimal: .space 16
Result1: .asciiz "Entered Binary: "
Result2: .asciiz "Decimal: "
#Main program
.text
.globl main
main:
#Prompt for binary number
li $v0,4      
la $a0,prompt       
syscall
#Read as a string in a0 address,max length in a1
la $a0, binary
li $a1, 16           
li $v0,8            
syscall
#Print entered binary
la $a0,Result1
li $v0,4
syscall
la $a0,binary
li $v0, 4             
syscall
#Call convertor function
jal BtoD
#End of the program
exit:
li $v0, 10     
syscall
BtoD:
#To get result
li $s0, 0            
#Address to get binary value in t0
move $t0,$a0
#Counter
li $t1, 16         
#Get each bytes
Loop:
lb $a0, ($t0)   
blt $a0, 48, print
addi $t0, $t0, 1       
subi $a0, $a0, 48      
subi $t1, $t1, 1       
beq $a0, 0, Zero
beq $a0, 1, One
#if 0 then there is no need to add sum
Zero:
   j Loop
#If one then left shift and add into s5
One:                 
   li $t2, 1             
   sllv $t3, $t2, $t1
   add $s0, $s0, $t3     
   j Loop
#Display result
print:
#Right shift sum
   srlv $s0, $s0, $t1
#isplay result2 prompt
    la $a0, Result2
    li $v0, 4
    syscall
#print decimal
    move $a0, $s0   
    li $v0, 1    
    syscall
#return
   jr $ra