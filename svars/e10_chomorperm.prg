'Requires e10_chomoreno.wf1

smpl 1981q1 2001q1

var chomorperm.ls 1 2 dgap infl ff

chomorperm.cleartext(svar)
chomorperm.append(svar) @a(1,1) = 1
chomorperm.append(svar) @a(2,2) = 1
chomorperm.append(svar) @a(3,3) = 1
chomorperm.append(svar) @diag(b)
chomorperm.append(svar) @f(1,2) = 0
chomorperm.append(svar) @f(1,3) = 0
chomorperm.append(svar) @s(1,3) = 0

' f0=u means that start values come from a unifrom density , n=normal, 

chomorperm.svar(rtype=text, f0=u,c=1e-6)

'compute normal impulses
chomorperm.impulse(10,imp=struct, se=a)


