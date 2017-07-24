
/ binary data

/ 11. 1 q has two flavors of files, 0. text (0), a list of strings; 1. binary (1), a list of bytes

/ 11.1.1 file handles `:[path]name

hsym `$"/data/file name.csv"
/ `:/data/file name.csv

hsym hsym `$"data/filename.csv"
/`:data/filename.csv

/ 11.1.2 hcount and hdel

hcount `:/data/solong.txt
/35

hdel `:/data/solong.txt
`:/data/solong.txt

/11.1.3 serializing and eserializing q entities

/ set will create the file, even the path if not exit, and will overwrite existing
`:/data/a set 42
`:/data/L set 10 20 30
`:/data/t set ([] c1: `a `b `c; c2: 10 20 30)

get `:/data/a
/42
get `:/data/L
get `:/data/t

/ get <-> value
value `:/data/a

/ \l can load and assign the file into a variable with the same name
\l /data/t
/ t now has the value


/11.1.4 Binary Data files

/ set function is written in binary form
/ append to file
`:/data/L set 10 20 30
h:hopen `:/data/L
h[42]
/ 3i, this returned value 3i is the value of open handle itself, so we can do 3i[100 200 300] to write data
/ q assign int to each open file and keeps track of which int are valid handles. this may lead to obscure error message like:
/ a: 42
/ b: 43
/ a b 
/ `: Bad file descriptor
h 100 200
/3i
hclose h
get `:/data/L
/10 20 30 42 100 200

/ create a new file and write raw binary
h: hopen `:/data/raw
h[42]
h 10 20 30
hclose

/ 11.1.5 writing and reading binary

read1 `:/data/L set 10 20 30
/0xfe200700....

/ to write raw binary, as opposed to the internal representation of a q entity contianing the data
`:/data/answer.bin 1: 0x06072a
/:/data/answer.bin
read1 `:/data/answer.bin
/0x06072a

/11.1.6 using dot amend

/: write
.[`:/data/raw; (); :; 1001 1002 1003]
/`/data/raw
get `:/data/raw
/1001 1002 1003

/, append
.[`:/data/raw; (); ,; 42]
get `:/data/raw
/1001 1002 1003 42


/ 11.2 save and load on tables

/ save <-> using (set) with the table name as file name
t:([] c1: `a `b `c; c2: 10 20 30)
save `:/data/t
`:/data/t
get :/data/t
/load creates a variable or overwrite existing
load `:/data/t

/ save to tab delimited file, use .txt
save `:data/t.txt
/`:data/t.txt
/c1\t/c2\tc3
/a\t\10\t1.1
/b\t\20\t2.2

/save to csv
save `:data/t.csv

/xml
save `:data/t.xml

/xls
save `:data/t.xls


/ 11.3 splayed tables

/ for larger tables that may not fit into memory, q can serialize each column of the table to its own file in a specified directory.
/ when querying a splayed table, only the columns referred to will be loaded into memory.

/ to use splay table, notice the / after path
`:/data/tsplay/ set ([] c1: 10 20 30; c2: 1 2 3)
/:/data/tsplay/

/ in the os 
/drwxr-xr-x 2 frank frank 4096 Jul  1 08:56 ./
/drwxr-xr-x 3 frank frank 4096 Jul  1 08:56 ../
/-rw-r--r-- 1 frank frank   40 Jul  1 08:56 c1
/-rw-r--r-- 1 frank frank   40 Jul  1 08:56 c2
/-rw-r--r-- 1 frank frank   14 Jul  1 08:56 .d

/ splay restrictions
1. all columns must be simple or compound lists (a list of simple lists of uniform type)
2. symbol columns must be enumerated

good example:
`:/data/tok/ set ([] c1: 2000.01.01+til 3; c2: 1 2 3)
`:/data/tok/ set ([] c1: 1 2 3; c2(1.1 2.2; enlist 3.3; 4.4; 5.5))

bad example:
`:/data/toops/ set ([] c1: 1 2 3; c2:(1;`1;"a"))
/`type
`:/data/toops/ set ([] c1:`a`b`c; c2:10 20 30)
/`type

The convention for enumerating symbols in splayed tables is to enumerate all symbol columns in all tables over the domain sym,
and store the resulting sym list in the root directory:
`:/db/tsplay/ set ([] `sym?c1:`a`b`c; c2: 10 20 30)
/ ...
sym
/`a`b`c
`:/db/sym set sym
/:db/sym

or use .Q.en:
`:/db/tsplay/ set .Q.en[`:/db; ([] c1:`a`b`c; c2: 10 20 30)]

11. 4 Text Data

11.4.1 Reading and writing text files

writing a text file using 0 will create if inexist and overwrite if exist
q)`:/home/frank/data/solong.txt 0: ("so long"; "and thanks"; "for all the fish")
`:/home/frank/data/solong.t

read as char:
q)read0 `:/home/frank/data/solong.txt
"so long"
"and thanks"
"for all the fish"

read as binary
q)read1 `:/home/frank/data/solong.txt
0x736f206c6f6e670a616e64207468616e6b730a666f7220616c6c2074686520666973680a

cast between reads
q)"x"$read0 `:/home/frank/data/solong.txt
0x736f206c6f6e67
0x616e64207468616e6b73
0x666f7220616c6c207468652066697368

q)"c"$read1 `:/home/frank/data/solong.txt
"so long\nand thanks\nfor all the fish\n

11.4.2 using hopen and hclose

use h for binary, neg[h] for strings. file handle will append, not overwrite
q)h:hopen `:/home/frank/data/new.txt
q)neg[h] enlist "this"
-3i
q)h 
3i
q)neg[h] ("and"; "that")            
-3i
q)hclose h
q)read0 `:/home/frank/data/new.txt
"this"
"and"
"that"

11.4.3 Preparing text

overloaded 0, left is delimiter, right is the data to format

q)t:([] c1:`a`b`c; c2: 1 2 3)
q)"\t" 0: t
"c1\tc2"
"a\t1"
"b\t2"
"c\t3"

q)csv
","
q)csv 0: t
"c1,c2"
"a,1"
"b,2"
"c,3"


q)`:/home/frank/data/t.csv 0: csv 0: t
`:/home/frank/data/t.csv

0: the left is to wirte data, the right is to prepare data

