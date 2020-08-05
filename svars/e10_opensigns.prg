
'Requires e10_svaroz.wf1

setmaxerrs 0

'rndseed 123456789

var opensigns_e10.ls 1 4 dgdp infl r rtwi

delete(noerr) s final_s

show opensigns_e10

for !i = 1 to 10
	
	statusline Iteration number: !i
	
	!xi = @runif(-1,1)
	
	!theta = !xi/(1-@abs(!xi))
	
	opensigns_e10.cleartext(svar)
	
	opensigns_e10.append(svar) @A(1,1)=1
	opensigns_e10.append(svar) @A(2,2)=1
	opensigns_e10.append(svar) @A(3,3)=1
	opensigns_e10.append(svar) @A(4,4)=1
	opensigns_e10.append(svar) @A(1,2)=0
	opensigns_e10.append(svar) @A(1,3)=0
	opensigns_e10.append(svar) @A(1,4)=0
	opensigns_e10.append(svar) @A(2,3)=0
	opensigns_e10.append(svar) @A(2,4)=0
'	opensigns_e10.append(svar) @A(3,4)=0.5
	opensigns_e10.append(svar) @DIAG(B)
	'opensigns_e10.append(svar) @a = a_mat
'	opensigns_e10.append(svar) @b = b_mat
	opensigns_e10.append(svar) @a(3,4) = !theta
	'opensigns_e10.append(svar) @a(3,4) = 0.186 'Restricts a(3,4) to a user assigned value of -0.186
	opensigns_e10.svar(f0=n,nostop)
	
	'Now retrieve the estimated S matrix and test whether it satisfies the necessary
	'sign restrictions.
	
if opensigns_e10.@svarcvgtype=0 then 
	
	%s = "s" + @str(!i)
	
	matrix {%s} = (opensigns_e10.@svarsmat)  'This retrieves the current S matrix = @inverse(A)*B. Hence the shocks are not unit based.  They reflect the s.e. of the SVAR residuals.
	
	show {%s}
	

	'Demand Shock
	
	'Notice the test bases the assessment just on S and the signs of the coefficients in the matrix.  The reason is that the sign of the impulse response function at time t = 0 is implied.
	
	
	!test = 0   'Boolean for testing whether the sign constraints are satisfied
	!nvars = 4
	!d_column = 0   'Variable to save the index of the column that satisfies the demand constraint.
	!count = 0
	
	for !j = 1 to !nvars
		
			!test = ((s(1,!j) >= 0) and (s(2,!j) > 0) and (s(3,!j) > 0) and (s(4,!j) > 0)) ' (positive) demand shock...
		
			if !test > 0 then 
				
				!d_column = !j
				
				!count = !count + 1
				
			endif
		
			!test = ((s(1,!j) <= 0) and (s(2,!j) <0) and (s(3,!j) < 0) and (s(4,!j) < 0))  ' - (negative) Demand shock...
		
			if !test > 0 then 
			
				!d_column = -!j  'Store the negative of the column index (to flag a negative demand shock); adjusted later.

				!count = !count + 1			

			endif
		
	next

	!t1 = 0
	
	genr d_cc = 0
	
	if ((!d_column <> 0) and (!count = 1)) then 
		
		'genr d_cc = !d_column
	
		'show d_cc'
	
		!t1 = 1 'This implies that there was a demand shock (positive or negative)
		
		'show s
		
	endif
	
	'Inflation
	
	!i_column = 0
	
	!count = 0
	
	for !j = 1 to !nvars
	
			!test = ((s(1,!j) <= 0) and (s(2,!j) > 0) and (s(4,!j) < 0)) ' (positive) inflation/cost-push shock.  note: rtwi declines with domestic inflation
		
			if !test > 0 then 
			
				!i_column = !j
				
				!count = !count + 1
			
			endif
		
			!test = ((s(1,!j) >= 0) and (s(2,!j) < 0) and (s(4,!j) > 0))  ' - (negative) inflation/productivity shock...interest rate can be + or negative depending on the strength of the output response.
		
			if !test > 0 then 
			
				!i_column = -!j  'Store the negative of the column index (to flag a negative inflation shock); adjusted later.
				
				!count = !count + 1
			
			endif
		
	next
	
	!t2 = 0
	
	genr d_cc_2 = 0
	
	if ((!i_column <> 0) and (!count = 1)) then 
	
		!t2 = 1 'This implies that there was an inflation shock (positive or negative)
		
		'genr d_cc_2 = !i_column
	
		'show d_cc_2
	
		'show s
		
		'stop
		
	endif
	
	'Interest rate shock...
	
	'Note: by assumption, s(1,!j) = 0 and s(2,!j) = 0
	
	!r_column = 0
	
	!count = 0
	
	for !j = 1 to !nvars
		
			!test = ((s(1,!j) = 0) and (s(2,!j) = 0) and (s(3,!j) > 0) and (s(4,!j) > 0)) ' (positive) interest rate shock...
		
			if !test > 0 then 
			
				!r_column = !j
				
				!count = !count + 1
			
			endif
		
			!test = ((s(1,!j) = 0) and (s(2,!j) = 0) and (s(3,!j) < 0) and (s(4,!j) < 0))  ' - (negative) interest rate shock...
		
			if !test > 0 then 
			
				!r_column = -!j  'Store the negative of the column index (to flag a negative interest shock); adjusted later.
				
				!count = !count + 1
			
			endif
		
	next
	
	!t3 = 0
	
	genr d_cc_3 = 0
	
	if ((!r_column <> 0) and (!count = 1)) then 
	
		!t3 = 1 'This implies an interest rate shock (+, -);
		
		'genr d_cc_3 = !r_column
	
		'show d_cc_3
	
		'show s
		
	endif
	
	'Finally, a real exchange rate shock.  Note that an increase in the trade weighted index is a depreciation.
	
	!e_column = 0
	
	!count = 0
	
		'Note: by assumption, s(1,!j) = 0 and s(2,!j) = 0
	
	for !j = 1 to !nvars
	
			!test = ((s(1,!j) = 0) and (s(2,!j) = 0) and (s(3,!j) < 0) and (s(4,!j) > 0)) 'positive exchange rate shock
			
			if !test > 0 then 
			
				!e_column = !j
				
				!count = !count + 1
			
			endif
	
			!test = ((s(1,!j) = 0) and (s(2,!j) = 0) and (s(3,!j) > 0) and (s(4,!j) < 0)) 'negative exchange rate shock
		
			if !test > 0 then 
			
				!e_column = -!j
				
				!count = !count + 1
			
			endif
	
	next
	
	!t4 = 0
	
	genr d_cc_4 = 0
	
	if ((!e_column <> 0) and (!count = 1)) then 
	
		!t4 = 1 'This implies an interest rate shock (+, -);
		
		'				genr d_cc_4 = !e_column
	
		'show d_cc_4
	
		'show s
		
		'stop
	
	endif

	!success = 0
	
	if ((!t1+!t2 +!t3 +!t4)>3.5) then 'At this point, we have one of each shock.  Re-create the S matrix so that the columns are ordered corrrectly.
		
		show s
		
		'show !i_column
		
		'stop
		
		
	'		Re-order the columns
	
		matrix final_s = s
	
		vector v1 = @subextract(s,1,@abs(!d_column),!nvars,@abs(!d_column))
	
		if !d_column < 0 then
 			v1 = -v1
		endif
	
		'b_shocks(1,1) = pattern_b(@abs(!d_column),@abs(!d_column))
		
		colplace(final_s,v1,1)
	
		vector v2 = @subextract(s,1,@abs(!i_column),!nvars,@abs(!i_column))
	
		if !i_column < 0 then
			v2 = -v2
		endif
		
		colplace(final_s,v2,2)
	
		'b_shocks(2,2) = pattern_b(@abs(!i_column),@abs(!i_column))
	
		vector v3 = @subextract(s,1,@abs(!r_column),!nvars,@abs(!r_column))
	
		if !r_column < 0 then
			v3 = -v3
		endif
	
		colplace(final_s,v3,3)
		
		'b_shocks(3,3) = pattern_b(@abs(!r_column),@abs(!r_column))
	
		vector v4 = @subextract(s,1,@abs(!e_column),!nvars,@abs(!e_column))
	
		if !e_column < 0 then
			v4 = -v4
		endif
	
		colplace(final_s,v4,4)
		
		show final_s
		
		'b_shocks(4,4) = pattern_b(@abs(!e_column),@abs(!e_column))
	
		matrix shock_1 = final_s
	
	'	Calculate the new impulse response function...
	
	'	Impulse reponse functions are ordered as gap w.r.t gap, infl w.r.t gap, ff with respect to gap
	'																gap w.r.t infl,   infl w.r.t. infl; ff w.r.t. infl
	'																gap w.r.t ff, infl w.r.t ff, ff w.r.t ff	
	'							
	
		delete(noerr) ch_svar_imp impgraph
		
		freeze(mode=overwrite,impgraph)  opensigns_e10.impulse(!n,smat=ch_svar_imp,se=a,imp=user,fname=shock_1) dgdp infl r rtwi @ dgdp infl r rtwi @ dgdp infl r rtwi
		
		impgraph.axis(l) range(auto)
		
		show impgraph
		
		!success = 1
		
		exitloop
		
	endif

endif

next

if !success <> 1 then
	
	@uiprompt("Failed to find a valid S matrix for the given sign restrictions.")
	
endif


