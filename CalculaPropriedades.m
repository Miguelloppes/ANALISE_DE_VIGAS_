function PROP = CalculaPropriedades(PROP, ET, K, AE, EI)

for el = 1 : size(PROP,2)
	L = PROP(1,el);
	switch ET(el)
		case 'M'
			PROP(2,el) = K;
		case 'B'
			PROP(2,el) = AE/L;
		case 'V'
			PROP(3,el) = 12*EI/L^3;		% phi
			PROP(4,el) = 6*EI/L^2;		% lambda
			PROP(5,el) = 2*EI/L;		% rho
    case 'P'
      PROP(2,el) = AE/L;
      PROP(3,el) = 12*EI/L^3;		% phi
			PROP(4,el) = 6*EI/L^2;		% lambda
			PROP(5,el) = 2*EI/L;		% rho
      
	endswitch
end