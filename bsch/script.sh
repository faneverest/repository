#!/bin/bash

#########################################################
# echo
#########################################################
echo "hello !"
hello !
echo hello !
hello !
echo 'hello !'
hello !

-e traslate \t into tab
echo -e '1\t2\t3\t'
1	2	3	

-n do not add \n in line end

#########################################################
# enviorment variable
#########################################################
pgrep subl
10296

cat /proc/10296/environ
...

# one var a line, use tr to translate \0 into \n
cat /proc/10296/environ | tr '\0' '\n'

# add enviroment variable to PATH
export PATH="$PATH:/home/user/bin"

#########################################################
# variable assign
#########################################################
var=value is assign
var = value is compare

echo var or echo ${var}
but echo '${var}' will print ${var}

#########################################################
# variable length
#########################################################
length=${#var}

#########################################################
# math
#########################################################

no1=4
no2=5

let result=no1+no2
echo $result

let no1++
let no2+=6

result=$[no1 + no2]
result=$((no1+5))
result=`expr 3+5`
result=$(expr $no1+5)

echo "4+0.56" | bc
echo "scale=2; 3/8" | bc
result=`echo "$no*1.5" | bc`

no=100
echo "obase=2; $no" | bc
echo "sqrt(2)" | bc
echo "10^2" | bc

#########################################################
# redirection
#########################################################
0 stdin
1 stdout
2 stderr

> over written
>> append

# > redirect stdout
ls + > out.txt

# > redirect stderr
ls + 2> out.txt

cmd 2>stderr.txt 1>stdout.txt

# redirect both

cmd 2>&1 output.txt
# or
cmd &> output.txt


# /dev/null
cmd 2>/dev/null

# display at stdout, but also keep a copy in file
cmd | tee file1 file2
cat a* | tee out.txt | cat -n

tee -a # append

# '-' use stdin as parameter, or use /dev/stdin
echo who is this | tee -

# redirect file to stdin
cmd < file

#########################################################
# self defined file descriptor
#########################################################
echo this is a test line > input/txt
exec 3<input.txt
cat <& 3

exec 4> output.txt
echo some txt >& 4
cat output.txt

exec 5>> output.txt


#########################################################
# check execution status
#########################################################
echo $?


#########################################################
# array
#########################################################
# define array
array_var=(1 2 3 4)

array_var[0]='test1'
array_var[1]='test2'
array_var[2]='test3'


# print array
echo ${array_var[0]}
index=5
echo ${array[$index]}

echo ${array_var[*]}
echo ${array_var[@]}

# array length
echo ${#array_var[*]}

#########################################################
# associate array
#########################################################
declare -A ass_array
ass_array=([index1]=var1 [index2]=var2)
# or
ass_array[index1]=var1

# get all keys
echo ${!array_var[*]}
echo ${!array_var[@]}

#########################################################
# backup rm
#########################################################
alias rm='cp $@ ~/backup && rm $@'

#########################################################
# date
#########################################################
frank@Catcher ~ $ date
Sat Jul 29 08:27:21 EDT 2017
frank@Catcher ~ $ date +%s
150133124

date --date "2017-07-01"
Sat Jul  1 00:00:00 EDT 20

date "+%d %B %Y"
29 July 2017