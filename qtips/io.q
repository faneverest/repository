
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
