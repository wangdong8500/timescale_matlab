function [X_GeH4_eq]=GeH4equ(T,PG,X_H2,X_H2S,X_Ge)
% equilibrium between GeH4 and GeS

% created on 6/29/2015

% % nasa polynomial for GeH4
% GeH4_nasa_coeff_low = [2.54992789E+00 7.13885765E-03 1.43758337E-05 ...
% -2.33592977E-08 9.65676013E-12 9.69756465E+03 9.02678812E+00 ];
% GeH4_nasa_coeff_high = [5.41474159E+00 7.24155154E-03 -2.71818301E-06 ...
%     4.51535021E-10 -2.75635275E-14 8.46356611E+03 -7.83419271E+00 ];
% G_0_GeH4 = evaluate_NASA_poly(GeH4_nasa_coeff_low,GeH4_nasa_coeff_high,T);

% nasa polynomial for GeH4 from CEA thermo.inp (NASA9)
GeH4_nasa_coeff_low = [-2.568398191D+05 -4.132811450D+01 7.755116280D+00...
    2.129640783D-03 7.255053610D-07 -5.096314010D-10 1.431608261D-13 ...
    7.881538040D+03 -2.030107999D+01 ];
GeH4_nasa_coeff_high = [-3.809805880D+06 1.093167093D+04 -5.149675410D+00 ...
    9.485931370D-03 -1.649459859D-06 1.419674126D-10 -5.004639750D-15 ...
    -6.158518520D+04 7.168961273D+01 ];
G_0_GeH4 = evaluate_NASA_poly(GeH4_nasa_coeff_low,GeH4_nasa_coeff_high,T,...
    'NASA9');

% nasa polynomial for H2S
H2S_nasa_coeff_low = [4.12024455E+00 -1.87907426E-03 8.21426650E-06 ...
-7.06425730E-09 2.14234860E-12 -3.68215173E+03 1.53174068E+00];
H2S_nasa_coeff_high = [2.97879430E+00 3.59760372E-03 -1.22803151E-06 ...
    1.96833209E-10 -1.16716162E-14 -3.51607638E+03 6.77921228E+00 ];
G_0_H2S = evaluate_NASA_poly(H2S_nasa_coeff_low,H2S_nasa_coeff_high,T);

% nasa polynomial for H2
H2_nasa_coeff_low = [2.344331120E+00,   7.980520750E-03, ... 
               -1.947815100E-05,   2.015720940E-08,  -7.376117610E-12, ...
               -9.179351730E+02,   6.830102380E-01];
H2_nasa_coeff_high = [ 3.337279200E+00,  -4.940247310E-05, ... 
                4.994567780E-07,  -1.795663940E-10,   2.002553760E-14, ...
               -9.501589220E+02,  -3.205023310E+00];
G_0_H2 = evaluate_NASA_poly(H2_nasa_coeff_low,H2_nasa_coeff_high,T);

% % nasa polynomial for GeS
% GeS_nasa_coeff_low = [2.73200768E+00 7.57876715E-03 -1.36729169E-05 ...
%  1.15657364E-08 -3.73031714E-12 1.18053453E+04 1.17059782E+01];
% GeS_nasa_coeff_high = [4.28047398E+00 2.89388180E-04 -1.17808888E-07 ...
%     2.25879711E-11 -1.36411854E-15 1.15231957E+04 4.43685469E+00 ];
% G_0_GeS = evaluate_NASA_poly(GeS_nasa_coeff_low,GeS_nasa_coeff_high,T);

% % nasa polynomial for GeS from CEA thermo.inp (NASA9)
GeS_nasa_coeff_low = [3.661018430D+04 -5.659653500D+02 6.152936410D+00 ...
    -2.746908039D-03 2.733435196D-06 -1.460209187D-09 3.278709470D-13 ...
    1.274175754D+04 -7.705659460D+00];
GeS_nasa_coeff_high = [-2.351367441D+06 7.211581860D+03 -4.362526310D+00...
     5.451737750D-03 -1.721002774D-06 2.632908084D-10 -1.394374040D-14 ...
     -3.583317250D+04 6.505566891D+01 ];
G_0_GeS = evaluate_NASA_poly(GeS_nasa_coeff_low,GeS_nasa_coeff_high,T,...
    'NASA9');

% nasa polynomial for GeS from burcat database (NASA9)
% GeS_nasa_coeff_low = [3.421047800D+04 -5.310850490D+02 5.956878860D+00 ...
%     -2.206812457D-03 1.945205879D-06 -8.844303550D-10 1.604034649D-13 ...
%      1.430422120D+04 -5.931179660D+00];
% GeS_nasa_coeff_high = [-1.640259055D+05 3.923976240D+02 3.944958910D+00...
%      4.197595720D-04 -1.417701557D-07 2.445085905D-11 -1.400097548D-15 ...
%       8.926225530D+03 6.945441940D+00 ];
% G_0_GeS = evaluate_NASA_poly(GeS_nasa_coeff_low,GeS_nasa_coeff_high,T,...
%     'NASA9');

G_0_reaction = G_0_GeS + 3*G_0_H2 - G_0_GeH4 - G_0_H2S;

Rgas = 8.3145e-3;
K_eq = exp(-G_0_reaction/(Rgas*T));

alpha = K_eq*X_H2S/(X_H2^3*PG*PG);
X_GeH4_eq = X_Ge/(1+alpha);
end
