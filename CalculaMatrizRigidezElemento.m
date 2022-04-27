function Ke = CalculaMatrizRigidezElemento(ET, PROP)

nel = size(PROP,2);
Ke = zeros(6,6,nel);

for el = 1 : nel
	m = cosd(PROP(6,el));
	n = sind(PROP(6,el));
	k = PROP(2,el);

	switch ET(el)
		case 'V'
			phi = PROP(3,el);
			lam = PROP(4,el);
			rho = PROP(5,el);
			Ke(:,:,el) = [ phi*n^2 -phi*m*n -lam*n -phi*n^2  phi*m*n -lam*n;
		                  -phi*m*n  phi*m^2  lam*m  phi*m*n -phi*m^2  lam*m;
						    -lam*n    lam*m  2*rho    lam*n   -lam*m    rho;
						  -phi*n^2  phi*m*n  lam*n  phi*n^2 -phi*m*n  lam*n;
						   phi*m*n -phi*m^2 -lam*m -phi*m*n  phi*m^2 -lam*m;
						    -lam*n    lam*m    rho    lam*n   -lam*m  2*rho];
                
    case 'P'
      phi = PROP(3,el);
			lam = PROP(4,el);
			rho = PROP(5,el);
      beta = k;
			Ke(:,:,el) = [beta*m^2+phi*n^2 (beta-phi)*m*n -lam*n -beta*m^2-phi*n^2  (phi-beta)*m*n -lam*n;
		                (beta-phi)*m*n  beta*n^2+phi*m^2  lam*m  (phi-beta)*m*n -beta*n^2-phi*m^2  lam*m;
						        -lam*n    lam*m  2*rho    lam*n   -lam*m    rho;
						        -beta*m^2-phi*n^2  (phi-beta)*m*n  lam*n  beta*m^2+phi*n^2 (beta-phi)*m*n  lam*n;
						        (phi-beta)*m*n -beta*n^2-phi*m^2 -lam*m (beta-phi)*m*n beta*n^2+phi*m^2 -lam*m;
						        -lam*n    lam*m    rho    lam*n   -lam*m  2*rho];
                
			
		otherwise
			Ke(1:4,1:4,el) = k*[ m^2  m*n -m^2 -m*n;
                                 m*n  n^2 -m*n -n^2;
                                -m^2 -m*n  m^2  m*n;
                                -m*n -n^2  m*n  n^2];
	endswitch	 
end