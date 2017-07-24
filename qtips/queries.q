
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
