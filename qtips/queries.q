
q)\l sp.q
+`p`city!(`p$`p1`p2`p3`p4`p5`p6`p1`p2;`london`london`london`london`london`lon..
(`s#+(,`color)!,`s#`blue`green`red)!+(,`qty)!,900 1000 1200
+`s`p`qty!(`s$`s1`s1`s1`s2`s3`s4;`p$`p1`p4`p6`p2`p2`p4;300 200 100 400 200 300)
q)meta s
c     | t f a
------| -----
s     | s    
name  | s    
status| j    
city  | s    
q)meta p
c     | t f a
------| -----
p     | s    
name  | s    
color | s    
weight| j    
city  | s    
q)meta sp
c  | t f a
---| -----
s  | s s  
p  | s p  
qty| j 

9.1 insert records

tip; prefer upsert than insert

to table, repead insert will duplicate
q)t:([] name:`symbol$(); iq:`int$())
q)t,:(`name1; 10)
q)t,:(`name2; 20)
q)t,:(`name3; 30)
q)t,:(`name3; 40)
q)t
name  iq
--------
name1 10
name2 20
name3 30
name3 40


to keyed table, upsert

q)kt:([eid:`long$()] name:`symbol$(); iq:`int$())
q)kt,:(007;`James;40)
q)kt,:(007;`James;20)
q)kt
eid| name  iq
---| --------
7  | James 20


/////////////////////////////////////////////////////////
/ 9.3 The select Template
/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
/ 9.3.1 Syntax
/////////////////////////////////////////////////////////
The result of select is a table

select <ps> <by pb> from texp <where pw>

p* is a common separated subphrase. Only time a parentethsis is needed is when ',' in the phrase.

execution order:
1. from
2. where
3. by
4. select

/////////////////////////////////////////////////////////
/ 9.3.2 The select Phrase
/////////////////////////////////////////////////////////
q)t: ([] c1:`a`b`c; c2: 10 20 30; c3: 1.1 2.2 3.3)
q)select from t
c1 c2 c3 
---------
a  10 1.1
b  20 2.2
c  30 3.3

q)select c1, c3 from t
c1 c3 
------
a  1.1
b  2.2
c  3.3

/////////////////////////////////////////////////////////
/ 9.3.2.1 Result Column Names
/////////////////////////////////////////////////////////

select c1, res: 2*c2 from t
c1 res
------
a  20 
b  40 
c  60 

* res: is not an assigment
* q will use x or add '1', '2' automatically

q)select c1, c1, 2*c2, c2+c3, string c3 from t
c1 c11 x  c2   c3   
--------------------
a  a   20 11.1 "1.1"
b  b   40 22.2 "2.2"
c  c   60 33.3 "3.3"


/////////////////////////////////////////////////////////
/ 9.3.2.2 The Virtual Column i
/////////////////////////////////////////////////////////

The i is the offset
select i, c1 from t (recommended is select idx:i, c1 from t)

idx c1
------
0   a 
1   b 
2   c 

/////////////////////////////////////////////////////////
/ distinct
/////////////////////////////////////////////////////////

select distinct from ([] c1:`a`b`a; c2: 10 20 10)
c1 c2
-----
a  10
b  20

/////////////////////////////////////////////////////////
/ first/last n
/////////////////////////////////////////////////////////

select [+=n] from ... (faster)
select [m n] from ... (start m-th row, select n rows)
select[>name] from ... (sort by name, desending)
select[<name] from ... (sort by name, asending)
select[2; > name] from ... (combined two syntax works, phrase order must be in this order)

+-n# select from ... (slower, need to load entire table)
