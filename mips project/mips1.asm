.data
   d2arr: .word 4, 3
          .word 10, 7
          
   size: .word 4
   .eqv d 4
   
   msg: .asciiz "\n"
   var: .double 1.2

.text 
   main:
        la $s1,d2arr  #t1-s1,t3-s2
        lw $s2, size

   #j do
   j p
       
       				
      
      end:
        li $v0, 10
        syscall


	do:
       		sub $s2,$s2,1
       		blez $s2,l2
       		move $t0,$s1 
       		li $t1,0 #swapped
       		li $t2,0 #counter
       		for:
       			lw $t3,0($t0)
       			lw $t4,4($t0)
       			ble $t3,$t4,l1
       			sw $t4,0($t0)
       			sw $t3,4($t0)
       			li $t1,1	
       			l1:
       				add $t2,$t2,1
       				add $t0,$t0,4
       				bne $t2,$s2,for
       				bnez $t1,do
       	l2:
       		li $t1,0
       		lw $s2, size
       		la $s1,d2arr
       		
       		lw $t3,4($s1)
       		lw $t4,8($s1)
       		add $t2,$t3,$t4
       		div $a0,$t2,2
       		li $v0, 1
		syscall
       	j end	
       		
       		
       		
print: 
        		beq $t1, $s2, end # check for array end
        		
        		li $t2,0
        		
        		#finding the address
        		add $t2,$t2,$s1 
        		mul $t3,$t1,d
        		add $t2,$t2,$t3
        		
        		lw $a0, ($t2) 
        		li $v0, 1
			syscall
        		
			#print new line
			la $a0,msg
			li $v0, 4
			syscall
        		
        		addi $t1, $t1,1 # advance loop counter
        		j print
    

p:
l.d $f2, var # print value at the array pointer
cvt.d.w $f12,$f2
                   	li $v0,3
			syscall
			
			la $a0,msg
			li $v0, 4
			syscall
			
mfc1 $t1,$f12

move $a0,$t1
li $v0,1
syscall
			