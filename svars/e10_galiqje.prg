
'Requires e10_galiqje.wf1

pageselect gali_92

var galiqje.LS 1 4 ygr drate ec1 ec2 @ c

'Added this initialization because the routine sometimes has trouble maximizing the likelihood.

C(1)	= 0.239160
C(2)	=-1.557400
C(3)	 =4.654613
C(4)	=-0.655408
C(5)	= 4.985212
C(6)	= 7.582059
C(7)	= 0.293322
C(8)	= 0.301674
C(9)	=-3.393284
C(10)	=-0.086442
C(11)	 =1.213470
C(12)	 =1.070711
C(13)	 =1.699136
C(14)	 =6.515471
C(15)	 =8.202743

galiqje.cleartext(svar)
galiqje.append(svar) @A(1,1)=1
galiqje.append(svar) @A(2,2)=1
galiqje.append(svar) @A(3,3)=1
galiqje.append(svar) @A(4,4)=1
galiqje.append(svar) @A(2,3)+@A(2,4)=0
galiqje.append(svar) @F(1,2)=0
galiqje.append(svar) @F(1,3)=0
galiqje.append(svar) @F(1,4)=0
galiqje.append(svar) @DIAG(B)
galiqje.append(svar) @S(1,2)=0
galiqje.append(svar) @S(1,3)=0

smpl 1955q1 1987q3
' f0=u means that one draws start values from a unifrom density , n=normal, 
galiqje.svar(rtype=text, f0=s,c=1e-06)
galiqje.results

'compute accumulated impulses 
galiqje.impulse(36, a, imp=struct, se=a)


