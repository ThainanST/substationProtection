clc
close all
clear
%% Explicação
% SCR - Short Circuit Ratio (Razão de Curto-Circuito)
%
% O SCR é uma medida da robustez da barra de alimentação em relação à 
% carga conectada. Ele compara a potência de curto-circuito disponível
% (Ssc) com a potência nominal da carga (Snom):
%
%     SCR = Ssc / Snom
%
% Onde:
%   - Ssc: potência de curto-circuito no ponto de conexão (VA)
%   - Snom: potência nominal da carga (VA)
%
% A potência de curto-circuito pode ser calculada pela tensão ao 
% quadrado dividida pela impedância da barra:
%
%     Ssc = Eac^2 / Zth
%
% Onde:
%   - Eac: tensão fase-fase na barra (V)
%   - Zth: impedância equivalente de Thevenin da barra (Ohm)
%
% A parte reativa da impedância (Xth) está relacionada à indutância 
% equivalente (Lth) pela expressão:
%
%     Xth = w * Lth
%
% A classificação típica do SCR é:
%   - Forte:     SCR > 5       (boa regulação de tensão, rede rígida)
%   - Moderado:  3 ? SCR ? 5   (regulação aceitável)
%   - Fraco:     SCR < 3       (rede fraca, sensível a variações de carga)
%% Cálculos
Eac = 230e3;                   % Tensão da barra em volts (fase-fase)
Inom = [26e3 114e3];           % Correntes nominais em amperes 
Snom = sqrt(3) * Eac .* Inom;  % Potência aparente nominal em VA 
w = 2 * pi * 60;               % Frequência angular (rad/s) para 60 Hz

barra = {'Taquariu', 'João Monlevade'};
SCR = [5 3];                   % Razão de curto-circuito
Ssc = Snom .* SCR;              % Potência de curto-circuito (VA)
Zth = Eac^2 ./ Ssc;            % Impedância equivalente de Thevenin (Ohms)

Rth = 0;                       % Resistência equivalente desprezada
Xth = Zth;                     % Reatância equivalente
Lth = Xth ./ w;                % Indutância equivalente (Henries)

fprintf('Resultados:\n\n');
for i = 1:length(Inom)
    fprintf('--- Barra %s ---\n', barra{i});   
    if SCR(i) > 5
        nivel = 'Forte';              % SCR > 5 ? forte
    elseif SCR(i) >= 3
        nivel = 'Moderado';           % 3 ? SCR ? 5 ? moderado
    else
        nivel = 'Fraco';              % SCR < 3 ? fraco
    end
    fprintf('SCR: %.2f (%s)\n', SCR(i), nivel); 
    fprintf('Inom: %.2f kA\n', Inom(i)/1e3);
    fprintf('Snom: %.2f MVA\n', Snom(i)/1e6);
    fprintf('Ssc:  %.2f MVA\n', Ssc(i)/1e6);
    fprintf('Zth:  %.4f Ohms\n', Zth(i));
    fprintf('Lth:  %.2f mH\n\n', Lth(i)*1e3);
end
%% Dados
flow = 1; % 1 - primeira situação, 2- segunda
if flow == 1
    monlevade.P = 30e6;
    monlevade.Q = 0;

    white.P     = 11e6;
    white.QL    = 1e6;
    white.QC    = 0;
    white.S     = sqrt(white.P^2+(white.QL-white.QC)^2);
    white.Ibase = white.S/(sqrt(3)*230e3);

    brucutu.P     = 8e6;
    brucutu.QL    = 26e6;
    brucutu.QC    = 0;
    brucutu.S     = sqrt(brucutu.P^2+(brucutu.QL-brucutu.QC)^2);
    brucutu.Ibase = brucutu.S/(sqrt(3)*230e3);

    capacitor.P   = 0;
    capacitor.QL  = 0;
    capacitor.QC  = 50e6;
    capacitor.S     = sqrt(capacitor.P^2+(capacitor.QL-capacitor.QC)^2);
    capacitor.Ibase = capacitor.S/(sqrt(3)*230e3);

elseif flow == 2
    monlevade.P = 2e6;
    monlevade.Q = 0.1e6;

    white.P     = 1e6;
    white.QL    = 1e6*tand(23);
    white.QC    = 0;
    white.S     = sqrt(white.P^2+(white.QL-white.QC)^2);
    white.Ibase = white.S/(sqrt(3)*230e3);

    brucutu.P     = 1e6;
    brucutu.QL    = 1e6*tand(23);
    brucutu.QC    = 0;
    brucutu.S     = sqrt(brucutu.P^2+(brucutu.QL-brucutu.QC)^2);
    brucutu.Ibase = brucutu.S/(sqrt(3)*230e3);

    capacitor.P     = 0;
    capacitor.QL    = 0;
    capacitor.QC    = 2e6*tand(23);
    capacitor.S     = sqrt(capacitor.P^2+(capacitor.QL-capacitor.QC)^2);
    capacitor.Ibase = capacitor.S/(sqrt(3)*230e3);
end













