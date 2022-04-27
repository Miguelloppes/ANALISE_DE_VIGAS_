clearvars; clc;
%============================================================================
% ENTRADA DE DADOS DA ESTRUTURA
%============================================================================
nEL = 2; % Quantidade total de elementos
nNO = 3; % Quantidade total de nós
nGL = 3; % Quantidade GL por nó
nGLmax = 9; % Maior valor de GL
alpha = 1:5; % GLs desconhecidos
beta = 6:nGLmax; % GLs conhecidos (fixos ou prescritos)
% Propriedades dos elementos
K = 1; % Elementos de mola
AE = 5; % Elementos de barra
EI = 2; % Elementos de viga
F1 = 10;
% Tipos de elemento
ET = ['P' 'P' 'P'];
% Matriz de Identidade (ID)
ID(1,1:nNO) = [7 6 1];
ID(2,1:nNO) = [8 4 2];
ID(3,1:nNO) = [9 5 3];
% Matriz de Incidência (IN)
IN(1,1:nEL) = [1 2];
IN(2,1:nEL) = [2 3];
% Matriz de Propriedades (PROP)
PROP = zeros(6,nEL);
PROP(1,1:nEL) = [0.15 0.15];% Comprimento dos elementos
PROP(6,1:nEL) = [0 90]; % Ângulo de inclinação dos elementos
% Vetor de carregamentos externos
F = zeros(nGLmax,1);
%Forca 1
F(2) = (-F1);
% Vetor de graus de liberdade (GLs)
X = zeros(nGLmax,1);
% Geometria original
COORD(1,1:nNO) = 1e3*[0 1 1]; % Coord. X
COORD(2,1:nNO) = 1e3*[0 0 1]; % Coord. Y
escala = 50;
%============================================================================
% CÁLCULO DO MEF
%============================================================================

% Matriz de Localização (LM)
LM = MontaMatrizLM(nEL, nGL, ID, IN, ET);
% Matriz de Propriedades (PROP)
PROP = CalculaPropriedades(PROP, ET, K, AE, EI);
% Calcula as matriz de rigidez global para cada elemento
Ke = CalculaMatrizRigidezElemento(ET, PROP);
% Monta a matriz de rigidez GLOBAL
Kg = zeros(nGLmax);
for el = 1:nEL
 ind = 1 : length(nonzeros(LM(:,el)));
 Kg(LM(ind,el),LM(ind,el)) = Kg(LM(ind,el),LM(ind,el)) + Ke(ind,ind,el);
end
% Verifica se a solução existe e é única
det(Kg(alpha,alpha)); % É diferente de zero -> OK!
% Solução dos GLs desconhecidos
X(alpha) = Kg(alpha,alpha) \ (F(alpha)-Kg(alpha,beta)*X(beta))
% Cálculo das reações de apoio
F(beta) = Kg(beta,alpha)*X(alpha) + Kg(beta,beta)*X(beta)
%==========================================
% PLOTAGEM
%==========================================
figure(1);
clf(1);
hold on;
% Plota os nós
for i = 1 : nNO
 plot(COORD(1,i), COORD(2,i), 'bo');
end
%box on; grid on; axis equal;
% Plota os elementos
for el = 1 : nEL
 plot(COORD(1,IN(:,el)),COORD(2,IN(:,el)),'b--');
end
% Geometria deformada
DEF(1,:) = COORD(1,:) + escala*X(ID(1,:))';
DEF(2,:) = COORD(2,:) + escala*X(ID(2,:))';
% Plota os nós deslocados
for i = 1 : nNO
 plot(DEF(1,i), DEF(2,i), 'ro');
end
%box on; grid on; axis equal;
% Plota os elementos deformados
for el = 1 : nEL
 plot(DEF(1,IN(:,el)),DEF(2,IN(:,el)),'r','linewidth',3);
end