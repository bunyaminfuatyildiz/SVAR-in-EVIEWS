
'Requires e10_debt.wf1

'Make sure that "Iterate GLS weighting" option (found in the "Basics" tab) is not checked before running this...otherwise it will not converge.

b_var_alt.ls 1 2  pb dy dp in dhat  @ c debt(-1) debt(-2)

b_var_alt.ls 1 2  pb dy dp in dhat  @ c debt(-1) debt(-2)  @restrict -1.515152*@l1(1,5)+@l1(2,5)+@l1(3,5)-@l1(4,5)+@l1(5,5) = 1, -1.515152*@l2(1,5)+@l2(2,5)+@l2(3,5)-@l2(4,5)+@l2(5,5) = 0, -1.515152*@l1(1,1)+@l1(2,1)+@l1(3,1)-@l1(4,1)+@l1(5,1) = 0, -1.515152*@l2(1,1)+@l2(2,1)+@l2(3,1)-@l2(4,1)+@l2(5,1) = 0, -1.515152*@l1(1,2)+@l1(2,2)+@l1(3,2)-@l1(4,2)+@l1(5,2) = 0, -1.515152*@l2(1,2)+@l2(2,2)+@l2(3,2)-@l2(4,2)+@l2(5,2) = 0, -1.515152*@l1(1,3)+@l1(2,3)+@l1(3,3)-@l1(4,3)+@l1(5,3) = 0, -1.515152*@l2(1,3)+@l2(2,3)+@l2(3,3)-@l2(4,3)+@l2(5,3) = 0, -1.515152*@l1(1,4)+@l1(2,4)+@l1(3,4)-@l1(4,4)+@l1(5,4) = 0, -1.515152*@l2(1,4)+@l2(2,4)+@l2(3,4)-@l2(4,4)+@l2(5,4) = 0

b_var_alt.svar(a=a_mat_alt, b=b_mat_alt,f0=s,maxiter=10000,nostop, conv=1e-08)
'Check the matrices satisfy the restrictions
matrix var_svar_a = b_var_alt.@svaramat
'First lag: last row should be 0 0 0 0 1
matrix check_1 = var_svar_a * b_var_alt.@lagcoef(1)
'Second lag: last row should be 0 0 0 0 0
matrix check_2 = var_svar_a * b_var_alt.@lagcoef(2)
show check_2


