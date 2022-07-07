.data
	d2arr:  .word 1, 2, 3, 4
		.word 5, 6, 7, 8
		.word 9, 10, 11, 12
		.word 13, 14, 15, 16

          
	size: .word 4
	.eqv d 4
	
	#Darr: .space 
   
	msg: .asciiz "\n"
	var: .word 0

.text 
	main:
	   	li $a0,256
        	li $v0,9
        	syscall
        	move $s6,$v0 #new array 
        	move $s7,$s6
        	la $s1,d2arr  #t1-s1,t3-s2
        	lw $s2, size
        
        	j print
                
       
        
	
	
        	li $v0, 10
		syscall
        
        
        
        print:
        	beq $t1, $s2, print_loop_end # check for array end
        	
        	li $t2, 0 # set loop counter
        	print_loop:
        	
        	 	lwc1 $f2, ($t4) # store the value as a float
                   	cvt.s.w $f12,$f2
                   	swc1 $f12,($s6)
                	
                	li $t3,0
                	li $t4,0
                	beq $t2, $s2, print_p # check for array end
                	
                   	# advance array pointer
			mul $t3,$t1,$s2  #t0(row)*t3(size)
			add $t3,$t3,$t2  #+t2(column)
			mul $t3,$t3,d    #*d (int)
			add $t3,$t3,$s1  #+address
			
			#print value of index
                   	lwc1 $f2, ($t3) # print value at the array pointer
                   	cvt.s.w $f12,$f2
                   	#li.s $f0,0
                   	#add.s $f12,$f12,4.1
                   	
                   	li $v0, 2
			syscall
			
			swc1 $f12,($s6)
                   	
                   	addi $s6,$s6,d
			
			#print new line
			la $a0,msg
			li $v0, 4
			syscall
			
			add $t4,$t1,1  #+address
			mul $t4,$t4,$s2  #t0(row)*t3(size)
			add $t4,$t4,$t2  #+t2(column)
			mul $t4,$t4,d    #*d (int)
			add $t4,$t4,$s1  #+address
			
			#print value of index
                   	l.s $f2, ($t4) # print value at the array pointer
                   	cvt.s.w $f12,$f2
                   	li $v0, 2
			syscall
			
			swc1 $f12,($s6)
                   	
                   	addi $s6,$s6,d
			
 			#print new line
			la $a0,msg
			li $v0, 4
			syscall
			addi $t2, $t2, 1 # advance loop counter
			
			j print_loop # repeat the loop
	
	print_p:
		addi $t1, $t1, 2 # advance loop counter
		j print
	
	print_loop_end:
	
	#mtc1 
	l.s $f2, ($s7) # print value at the array pointer
	l.s $f4, 4($s7) # print value at the array pointer 
	l.s $f6, 8($s7) # print value at the array pointer 
	l.s $f8, 12($s7) # print value at the array pointer 
	li $t0,4
	mtc1 $t0,$f10
	cvt.s.w $f10,$f10
	div.s $f0,$f8,$f10
	swc1 $f0,($s7)
	l.s $f12, ($s7)
	#mov.s $f12,$f8
                   	li $v0, 2
			syscall
        
      #  mule:
           #  mul $s0,$s0,1
          # j ret 
       
      # mulod:
          #   mul $s0,$s0,3
          # j ret 
        
    
