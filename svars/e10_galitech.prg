
'Requires e10_galidusa.wf1

pageselect orig_gali

smpl @all

genr lprodh = log(gdpq)-log(lpmhu)
genr dp = 100*dlog(p) 'Inflation
genr dinf = d(dp)
genr ddinf = d(dinf)
genr dprodh = 100*d(lprodh)
genr dhours = 100*dlog(lpmhu)
genr ddhours = d(dhours)
genr dm2 = 100*dlog(m2)
genr ec1 = (rm3/4)-dp
genr ec2 = dm2 - dp
genr dec1 = d(ec1)
genr dec2 = d(ec2)

smpl 1959Q1 1994Q4

var galitech.ls 1 4 dprodh dhours dinf ec1 ec2  @ c 

galitech.cleartext(svar)
galitech.append(svar) @A(1,1)=1
galitech.append(svar) @A(2,2)=1
galitech.append(svar) @A(3,3)=1
galitech.append(svar) @A(4,4)=1
galitech.append(svar) @A(5,5)=1
galitech.append(svar) @A(2,1)=0
galitech.append(svar) @A(2,3)=0 
galitech.append(svar) @A(2,4)=0
galitech.append(svar) @A(2,5)=0
galitech.append(svar) @A(3,1)=0
galitech.append(svar) @A(3,2)=0
galitech.append(svar) @A(3,4)=0
galitech.append(svar) @A(3,5)=0
galitech.append(svar) @A(4,1)=0
galitech.append(svar) @A(4,2)=0
galitech.append(svar) @A(4,3)=0
galitech.append(svar) @A(4,5)=0
galitech.append(svar) @A(5,1)=0
galitech.append(svar) @A(5,2)=0
galitech.append(svar) @A(5,3)=0
galitech.append(svar) @A(5,4)=0
galitech.append(svar) @F(1,2)=0
galitech.append(svar) @F(1,3)=0
galitech.append(svar) @F(1,4)=0
galitech.append(svar) @F(1,5)=0
galitech.append(svar) @LOWER(B)
galitech.svar(rtype=text, f0=n)
galitech.results
'compute accumulated impulses 
galitech.impulse(12, a, imp=struct, se=a)


