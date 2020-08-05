
'Requires e10_galiqje.wf1

pageselect gali_92

var galiqje_alt.LS 1 4 ygr drate ec1 ec2 @ c

'Added this initialization because the routine sometimes has trouble maximizing the likelihood.

C(1)	= 1.095718
C(2)	=-1.709184
C(3)	=-8.211299
C(4)	=-0.655408
C(5)	 =5.093092
C(6)	=-19.31645
C(7)	 =0.293322
C(8)	=-1.320536
C(9)	 =2.036959
C(10)	=-0.086442
C(11)	 =0.600580
C(12)	 =1.356424
C(13)	 =1.070711
C(14)	=-3.007241
C(15)	 =6.945797
C(16)	 =18.10785

galiqje_alt.cleartext(svar)
galiqje_alt.append(svar) @A(1,1)=1
galiqje_alt.append(svar) @A(2,2)=1
galiqje_alt.append(svar) @A(3,3)=1
galiqje_alt.append(svar) @A(4,4)=1
galiqje_alt.append(svar) @F(1,2)=0
galiqje_alt.append(svar) @F(1,3)=0
galiqje_alt.append(svar) @F(2,3)=0
galiqje_alt.append(svar) @F(1,4)=0
galiqje_alt.append(svar) @F(2,4)=0
galiqje_alt.append(svar) @DIAG(B)
galiqje_alt.append(svar) @S(1,3)=0

smpl 1955q1 1987q3
' f0=u means that one draws start values from a unifrom density , n=normal, 
galiqje_alt.svar(rtype=text, f0=s,c=1e-06)
galiqje_alt.results

'compute accumulated impulses 
galiqje_alt.impulse(36, a, imp=struct, se=a)


