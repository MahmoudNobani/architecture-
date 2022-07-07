.data
pi:.double 3.1415926535897924
msg: .asciiz "Circle Area ="
.text
main:
ldc1 $f2 , pi # $f 2,3 = pi
li $v0 , 7 # read double (
syscall
# $f 0,1 = radius
mul.d $f12 , $f0 , $f0 # $f 12,13 = radius*radius
mul.d $f12 , $f2 , $f12 # $f 12,13 = area
la $a0 , msg
li $v0 , 4 # print string msg
syscall
li $v0 , 3 # print double (area)
syscall