
'Requires e10_bqdata.wf1; pagefile Org_BQData

smpl 1950q2 1987q4

scalar ca=eq1.@coefs(1)
scalar cb=eq2.@coefs(1)

var bq.ls 1 8  dya u @ c

bq.cleartext(svar)

bq.append(svar) @a = a_mat
bq.append(svar) @b = b_mat
bq.append(svar) @f  = f_mat 

' f0=u means that one draws start values from a uniform density , n=normal, 
bq.svar(rtype=text, f0=u)
'compute the accumulated impulse response functions
bq.impulse(36,imp=struct, a, se=a)


