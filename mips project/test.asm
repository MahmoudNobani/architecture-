#mahmoud nobani 1180729
#masoud ajjouli 118****
.data
	d2arr:  .word 2, 5, 4, 1
		.word 7, 4, 7, 2
		.word 10, 11, 20, 7
		.word 7, 12, 4, 8

        
          
        temp:  .space 16
          
	size: .word 4
	.eqv d 4

	msg: .asciiz "\n"
	msg2: .asciiz "1)median, 0)mean\n"
	msg1: .asciiz "lvl?\n"

	
        	

.text 
	main:
	#define a dynamic array
		li $a0,256
        	li $v0,9
        	syscall
        	move $s6,$v0 #new array 
        	move $s7,$s6
        #parameters of the entered array	
        	la $s1,d2arr  #address
        	lw $s2,size   #row length
       
       li $t6,1
       
        #lvl
        la $a0,msg1
	li $v0, 4
	syscall
        #take input of the lvl and making sure its possible
        li $v0, 5
	syscall
	move $t8,$v0
	beqz $t8,end
	move $t9,$t8
	sub $t8,$t8,1
	beqz $t8,Pr
	sub $t9,$s2,$t9
	blez $t9,end
        #median/mean
        la $a0,msg2
	li $v0, 4
	syscall
        #take input
        li $v0, 5
	syscall
	
	bne $v0,$zero,MeadianCal
	beq $v0,$zero,MeanCal
	
        	
 #mean calcuations       		
       MeanCal: 
       		beqz $t8,p1 	#lvl cpunter
       		li $t1,0			
        	bne $s2,$zero,downS1 #if size not zero we can still downsample
        	beq $s2,$zero,p1 #if size reached zero we cant
  	
        step2:#find the means
        	li $t1,0
        	li $t5,2
        	move $s6,$s7
        	mul $s3,$s2,$s2#size of the new array as a whole
        	div $t6,$t5 #used to check even mean or odd mean
        	mfhi $t7
        	li $t5,0
        	beq $t7,$zero,meanO
        	bne $t7,$zero,mean 
        	
        step3:#print
        	li $t1,0
        	move $s2,$s4 #size of the new downsampled array
        	li $s4,0
        	#j print
 	
 	step4:#adjusting parameters
 		add $t6,$t6,1
 		move $s1,$s7
 		div $s2,$s2,2
		sub $t8,$t8,1
 		j MeanCal
 		
 #--------------------------------------------------------------------------		
 #median calculations:
        MeadianCal:
        	beqz $t8,p1#lvl cpunter
       		li $t1,0			
        	bne $s2,$zero,downS11 #if size not zero we can still downsample
        	beq $s2,$zero,p1 #if size reached zero we cant
        		
        step22:#find the median
        	li $t1,0
        	li $t5,0
        	move $s6,$s7
        	mul $s3,$s2,$s2#size of the new array as a whole
        	j meadian
 	step33:#print
        	li $t1,0
        	move $s2,$s4 #size of the new downsampled array
        	li $s4,0
        	#j print1
 	
 	step44:#rounding up the parameters
 		move $s1,$s7
 		div $s2,$s2,2
		sub $t8,$t8,1
 		j MeadianCal	
 		
	end:#end
        	li $v0, 10
		syscall
        
        
 #downsample-------------------------------------------------------------------------------------------       
        downS1:
        	beq $t1, $s2, retUP # check for array end
        	
        	li $t2, 0 # set loop counter
        	downS2:
                	
                	li $t3,0
                	li $t4,0
                	beq $t2, $s2, proxy # check for array end
                	
                   	# advance array pointer
			mul $t3,$t1,$s2  #t0(row)*t3(size)
			add $t3,$t3,$t2  #+t2(column)
			mul $t3,$t3,d    #*d (int)
			add $t3,$t3,$s1  #+address
			
			#print value of index
                   	lwc1 $f2, ($t3) # store the value as a float
                   	cvt.s.w $f12,$f2
                   	swc1 $f12,($s6)
                   	
                   	addi $s6,$s6,d
                   	#li $v0, 2
			#syscall
			
			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
			
			add $t4,$t1,1  #+address
			mul $t4,$t4,$s2  #t0(row)*t3(size)
			add $t4,$t4,$t2  #+t2(column)
			mul $t4,$t4,d    #*d (int)
			add $t4,$t4,$s1  #+address
			
			#print value of index
                   	lwc1 $f2, ($t4) # store the value as a float
                   	cvt.s.w $f12,$f2
                   	swc1 $f12,($s6)
                   	
                   	addi $s6,$s6,d
                   	#li $v0, 2
			#syscall
			
 			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
			addi $t2, $t2, 1 # advance loop counter
			
			j downS2 # repeat the loop
	
	proxy:
		addi $t1, $t1, 2 # advance loop counter
		j downS1
	
	retUP:
	        j step2
#---------------------------------------------------------------------------------------------------

#downsample meadian-------------------------------------------------------------------------------------------       
       downS11:
        	beq $t1, $s2, retUP1 # check for array end
        	
        	li $t2, 0 # set loop counter
        	downS21:
                	
                	li $t3,0
                	li $t4,0
                	beq $t2, $s2, proxy1 # check for array end
                	
                   	# advance array pointer
			mul $t3,$t1,$s2  #t0(row)*t3(size)
			add $t3,$t3,$t2  #+t2(column)
			mul $t3,$t3,d    #*d (int)
			add $t3,$t3,$s1  #+address
			
			#print value of index
                   	lwc1 $f2, ($t3) # store the value as a float
                   	cvt.s.w $f12,$f2
                   	swc1 $f12,($s6)
                   	
                   	addi $s6,$s6,d
                   	#li $v0, 2
			#syscall
			
			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
			
			add $t4,$t1,1  #+address
			mul $t4,$t4,$s2  #t0(row)*t3(size)
			add $t4,$t4,$t2  #+t2(column)
			mul $t4,$t4,d    #*d (int)
			add $t4,$t4,$s1  #+address
			
			#print value of index
                   	lwc1 $f2, ($t4) # store the value as a float
                   	cvt.s.w $f12,$f2
                   	swc1 $f12,($s6)
                   	
                   	addi $s6,$s6,d
                   	#li $v0, 2
			#syscall
			
 			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
			addi $t2, $t2, 1 # advance loop counter
			
			j downS21 # repeat the loop
	
	proxy1:
		addi $t1, $t1, 2 # advance loop counter
		j downS11
	
	retUP1:
	        j step22
#---------------------------------------------------------------------------------------------------      

#mean of downsampled even
		mean: 
        		beq $t1, $s3,step3 # check for array end
        		
        		li $t2,0
        		
        		#store 3 in float
        		li $t0,3
			mtc1 $t0,$f10
			cvt.s.w $f10,$f10
			#store 1 in float
			li $t0,1
			mtc1 $t0,$f11
			cvt.s.w $f11,$f11
        		#store 8 in float
        		li $t0,8
			mtc1 $t0,$f9
			cvt.s.w $f9,$f9
			
        		#finding the address
        		add $t2,$t2,$s7 
        		mul $t3,$t1,d
        		add $t2,$t2,$t3
        		
        		#getting the first value of the 4 side array and mul by1
        		l.s $f2, ($t2) 
                   	mul.s $f0,$f2,$f10
                   	#getting the second value and mul by 3
                   	add $t2,$t2,4
                   	l.s $f2, ($t2) 
                   	mul.s $f1,$f2,$f11
                   	add.s $f0,$f0,$f1
                   	#getting the 3rd value and mul by 3
                   	add $t2,$t2,4
                   	l.s $f2, ($t2) 
                   	mul.s $f1,$f2,$f11
                   	add.s $f0,$f0,$f1
                   	#getting the 4th value and mul by 1
                   	add $t2,$t2,4
                   	l.s $f2, ($t2) 
                   	mul.s $f1,$f2,$f10
                   	add.s $f0,$f0,$f1
                   	#div by 8 and print
                   	div.s $f12,$f0,$f9
                   	#li $v0, 1
			#syscall
			
			swc1 $f12,($s6)
                   	addi $s6,$s6,d
			
			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
        		
        		addi $t1, $t1, 4 # advance loop counter
        		addi $s4,$s4,1
        		j mean
#-------------------------------------------------------------------------------

#mean of downsampled odd
		meanO: 
        		beq $t1, $s3,step3 # check for array end
        		
        		li $t2,0
        		
        		#store 3 in float
        		li $t0,1
			mtc1 $t0,$f10
			cvt.s.w $f10,$f10
			#store 1 in float
			li $t0,3
			mtc1 $t0,$f11
			cvt.s.w $f11,$f11
        		#store 8 in float
        		li $t0,8
			mtc1 $t0,$f9
			cvt.s.w $f9,$f9
			
        		#finding the address
        		add $t2,$t2,$s7 
        		mul $t3,$t1,d
        		add $t2,$t2,$t3
        		
        		#getting the first value of the 4 side array and mul by1
        		l.s $f2, ($t2) 
                   	mul.s $f0,$f2,$f10
                   	#getting the second value and mul by 3
                   	add $t2,$t2,4
                   	l.s $f4, ($t2) 
                   	mul.s $f1,$f4,$f11
                   	add.s $f0,$f0,$f1
                   	#getting the 3rd value and mul by 3
                   	add $t2,$t2,4
                   	l.s $f6, ($t2) 
                   	mul.s $f1,$f6,$f11
                   	add.s $f0,$f0,$f1
                   	#getting the 4th value and mul by 1
                   	add $t2,$t2,4
                   	l.s $f8, ($t2) 
                   	mul.s $f1,$f8,$f10
                   	add.s $f0,$f0,$f1
                   	#div by 8 and print
                   	div.s $f12,$f0,$f9
                   	#li $v0, 1
			#syscall
			
			swc1 $f12,($s6)
                   	addi $s6,$s6,d
			
			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
        		
        		addi $t1, $t1, 4 # advance loop counter
        		addi $s4,$s4,1
        		j meanO
#-----------------------------------------------------------------------------------------------------
#print out 
	p1:
	mul $s2,$s2,2
	beqz $s2,add1
	printout:
		beq $t1, $s2, end # check for array end
        		
        		li $t2,0
        		
        		#finding the address
        		add $t2,$t2,$s7 
        		mul $t3,$t1,d
        		add $t2,$t2,$t3
        		
        		l.s $f12, ($t2)
        		li $v0, 2
			syscall
        		
			#print new line
			la $a0,msg
			li $v0, 4
			syscall
        		
        		addi $t1, $t1,1 # advance loop counter
        		j printout

#---------------------------------------------------------------------------------------
# meadian
		meadian: 
		
		li $t5,2
		mtc1 $t5,$f10
		cvt.s.w $f10,$f10
		
        		beq $t1, $s3,step33 # check for array end
        		
        		li $t2,0
        		
        		#finding the address
        		add $t2,$t2,$s7 
        		mul $t3,$t1,d
        		add $t2,$t2,$t3
        		
        		#move $s2,$s3
        		la $s1,temp 
        		#getting the first value of the 4 side array ans store it in a temp one 
        		l.s $f2, ($t2) 
                   	swc1 $f2,0($s1)
                   	#getting the 2nd value of the 4 side array ans store it in a temp one
                   	add $t2,$t2,4
                   	l.s $f2, ($t2) 
                   	swc1 $f2,4($s1)
                   	
                   	#getting the 3rd value of the 4 side array ans store it in a temp one
                   	add $t2,$t2,4
                   	l.s $f2, ($t2) 
                   	swc1 $f2,8($s1)
                   	
                   	#getting the 4th value of the 4 side array ans store it in a temp one
                   	add $t2,$t2,4
                   	l.s $f2, ($t2) 
                   	swc1 $f2,12($s1)
                   	 
			j bubble#using bubble sort
			
		cont:
       			l.s $f4, 4($s1) 
       			
       			l.s $f6, 8($s1) 
       			
       			#mov.s $f12,$f6
       			#li $v0,2
			#syscall
       			
       			add.s $f8,$f4,$f6
       			div.s $f12,$f8,$f10
       			
       			swc1 $f12,($s6)
                   	addi $s6,$s6,d#store in array
			
			#print new line
			#la $a0,msg
			#li $v0, 4
			#syscall
        		
        		addi $t1, $t1, 4 # advance loop counter
        		addi $s4,$s4,1
        		j meadian
 #---------------------------------------------------------
 #bubble sort
 bubble:
        li $t7,4
	sort:
       		sub $t7,$t7,1
       		blez $t7,l2
       		move $t0,$s1 
       		li $t5,0 #swapped
       		li $t2,0 #counter
       		for:
       			l.s $f4, 0($t0) 
       			l.s $f6, 4($t0) 
       			c.le.s  $f4,$f6
       			bc1f l1
       			swc1 $f6,0($t0)
       			swc1 $f4,4($t0)
       			li $t5,1	
       			l1:
       				add $t2,$t2,1
       				add $t0,$t0,4
       				bne $t2,$t7,for
       				bnez $t5,sort
       		l2:
       		
		
		j cont
 #-----------------------------------------------------------------------------------
 #print full pog
 	Pr:
 	mul $s2,$s2,$s2
 	looping: 
        	beq $t1, $s2, end # check for array end
        		
        	li $t2,0
        		
        	add $t2,$t2,$s1  #+address
        	mul $t3,$t1,d
        	add $t2,$t2,$t3
        		
        	lw $a0, ($t2) # print value at the array pointer
                li $v0, 1
		syscall
			
	#print new line
		la $a0,msg
		li $v0, 4
		syscall
        		
        	addi $t1, $t1, 1 # advance loop counter
        		
        	j looping            
#*-----------------------------------------
add1:
	add $s2,$s2,1
	j printout   
