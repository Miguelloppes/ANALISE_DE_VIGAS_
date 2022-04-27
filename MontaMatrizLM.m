function LM = MontaMatrizLM(nEL, nGL, ID, IN, ET)

LM = zeros(2*nGL, nEL);

for el = 1 : nEL
	switch ET(el)
		case 'V' 
		   % É viga
		   LM(1:3,el) = ID(:,IN(1,el))
		   LM(4:6,el) = ID(:,IN(2,el))
     
   case 'P' 
		   LM(1:3,el) = ID(:,IN(1,el))
		   LM(4:6,el) = ID(:,IN(2,el))
		   
		otherwise
		   % É mola ou barra
		   LM(1:2,el) = ID(1:2,IN(1,el))
		   LM(3:4,el) = ID(1:2,IN(2,el))
	endswitch
		
end