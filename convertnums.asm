.data
msg: .asciiz "Enter a decimal number to convert to binary: "
.text
li $v0, 4
la $a0, msg
syscall
# READ integer from user
li $v0, 5 # service 5 (read integer)
syscall
add $t0, $zero, $v0 # Get number read from previous syscall and put it in $t0

# set up a loop for the
li $t1, 31 #no. of bits to shift
Loop:
blt $t1, 0, EndLoop
srlv $t2, $t0, $t1 #shift the bit to right most position
and $t2, 1 #extract the bit by ANDING 1 with it
#display the extracted bit
li $v0, 1
move $a0, $t2
syscall
#decrement the bit no.
sub $t1, $t1, 1
b Loop
EndLoop:
#exit
li $v0, 10
syscall