
'Requires e10_brazil.wf1

var brazilsvar.ls 1 1 ystar rus n y infl int rer
brazilsvar.results
brazilsvar.ls 1 1 ystar rus n y infl int rer _
@restrict @l1(1,3)=0, @l1(1,4)=0,@l1(1,5)=0, _ 
@l1(1,6)=0, @l1(1,7)=0, @l1(2,3)=0, _
@l1(2,4)=0, @l1(2,5)=0,@l1(2,6)=0, @l1(2,7)=0
brazilsvar.cleartext(svar)
brazilsvar.append(svar) @UNITLOWER(A)
brazilsvar.append(svar) @DIAG(B)
brazilsvar.svar


