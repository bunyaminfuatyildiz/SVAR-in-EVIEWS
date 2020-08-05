
'Requires e10_peersman.wf1

smpl 1980q1 2002q2

var peersman.ls 1 3 dpoil dusgdp duscpi dusint  @ c time

peersman.cleartext(svar)
peersman.append(svar) @a(1,1) = 1
peersman.append(svar) @a(2,2) = 1
peersman.append(svar) @a(3,3) = 1
peersman.append(svar) @a(4,4) = 1
peersman.append(svar) @a(1,2) = 0
peersman.append(svar) @a(1,3) = 0
peersman.append(svar) @a(1,4) = 0
peersman.append(svar) @diag(b)
peersman.append(svar) @f(2,3) = 0
peersman.append(svar) @f(2,4) = 0
peersman.append(svar) @s(2,4) = 0

' f0=u means that one draws start values from a unifrom density , n=normal, 
peersman.svar(rtype=text, f0=n,c=1e-8)
peersman.results
'compute normal impulses
'peersman.impulse(50,imp=struct, se=a)@ 1 2 3
peersman.impulse(30,imp=struct, se=a)
'compute accumulated impulses 
peersman.impulse(30, a, imp=struct, se=a)


