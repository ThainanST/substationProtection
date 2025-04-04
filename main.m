clc
close all
clear
%% Explica��o
% SCR - Short Circuit Ratio (Raz�o de Curto-Circuito)
%
% O SCR � uma medida da robustez da barra de alimenta��o em rela��o � 
% carga conectada. Ele compara a pot�ncia de curto-circuito dispon�vel
% (Ssc) com a pot�ncia nominal da carga (Snom):
%
%     SCR = Ssc / Snom
%
% Onde:
%   - Ssc: pot�ncia de curto-circuito no ponto de conex�o (VA)
%   - Snom: pot�ncia nominal da carga (VA)
%
% A pot�ncia de curto-circuito pode ser calculada pela tens�o ao 
% quadrado dividida pela imped�ncia da barra:
%
%     Ssc = Eac^2 / Zth
%
% Onde:
%   - Eac: tens�o fase-fase na barra (V)
%   - Zth: imped�ncia equivalente de Thevenin da barra (Ohm)
%
% A parte reativa da imped�ncia (Xth) est� relacionada � indut�ncia 
% equivalente (Lth) pela express�o:
%
%     Xth = w * Lth
%
% A classifica��o t�pica do SCR �:
%   - Forte:     SCR > 5       (boa regula��o de tens�o, rede r�gida)
%   - Moderado:  3 ? SCR ? 5   (regula��o aceit�vel)
%   - Fraco:     SCR < 3       (rede fraca, sens�vel a varia��es de carga)
%% C�lculos
Eac = 230e3;                   % Tens�o da barra em volts (fase-fase)
Inom = [26e3 114e3];           % Correntes nominais em amperes 
Snom = sqrt(3) * Eac .* Inom;  % Pot�ncia aparente nominal em VA 
w = 2 * pi * 60;               % Frequ�ncia angular (rad/s) para 60 Hz

barra = {'Taquariu', 'Jo�o Monlevade'};
SCR = [5 3];                   % Raz�o de curto-circuito
Ssc = Snom .* SCR;              % Pot�ncia de curto-circuito (VA)
Zth = Eac^2 ./ Ssc;            % Imped�ncia equivalente de Thevenin (Ohms)

Rth = 0;                       % Resist�ncia equivalente desprezada
Xth = Zth;                     % Reat�ncia equivalente
Lth = Xth ./ w;                % Indut�ncia equivalente (Henries)

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
flow = 2; % 1 - primeira situa��o, 2- segunda
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













