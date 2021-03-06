% this function is to evaluate nasa polynomial for give coefficient
% as a at temperature T (vector)
function [G] = evaluate_NASA_poly(a,b,T,nasa_format)
if nargin == 3
    nasa_format = 'NASA7';
end

if nasa_format == 'NASA7'
    if length(a)~=7 || length(b)~=7
        disp('error in poly coeff!');
    end
    
    R_gas = 8.3145e-3;
    
    
    N = length(T);
    Cp = zeros(1,N);
    H = zeros(1,N);
    S = zeros(1,N);
    
    for i=1:N
        if T(i)<=1000
            p = a;
        else
            p=b;
        end
        % heat capacity (kJ/mol/K)
        Cp(i) = R_gas*(p(1) + p(2)*T(i) + p(3)*T(i)^2 + ...
            p(4)*T(i)^3 + p(5)*T(i)^4);
        % enthalpy (kJ/mol)
        H(i) = R_gas*T(i)*(p(1) + p(2)*T(i)/2+ p(3)*T(i)^2/3 +p(4)*T(i)^3/4 +...
            p(5)*T(i)^4/5 + p(6)/T(i));
        % entropy (kJ/mol/K)
        S(i) = R_gas*(p(1)*log(T(i)) + p(2)*T(i) + p(3)*T(i)^2/2 + p(4)*T(i)^3/3 ...
            + p(5)*T(i)^4/4 + p(7));
    end
elseif nasa_format == 'NASA9'
    if length(a)~=9 || length(b)~=9
        disp('error in poly coeff!');
    end
    
    R_gas = 8.3145e-3;
    
    
    N = length(T);
    Cp = zeros(1,N);
    H = zeros(1,N);
    S = zeros(1,N);
    
    for i=1:N
        if T(i)<=1000
            p = a;
        else
            p=b;
        end
        % heat capacity (kJ/mol/K)
        Cp(i) = R_gas*(p(1)*T(i)^(-2)+ p(2)*T(i)^(-1)+ p(3) + p(4)*T(i) +...
            p(5)*T(i)^2 + p(6)*T(i)^3 + p(7)*T(i)^4);
        % enthalpy (kJ/mol)
        H(i) = R_gas*T(i)*(-p(1)*T(i)^(-2) + p(2)*T(i)^(-1)*log(T(i)) + ...
            p(3) + p(4)*T(i)/2+ p(5)*T(i)^2/3 +p(6)*T(i)^3/4 +...
            p(7)*T(i)^4/5 + p(8)/T(i));
        % entropy (kJ/mol/K)
        S(i) = R_gas*(-p(1)*T(i)^(-2)/2 - p(2)*T(i)^(-1) + p(3)*log(T(i))...
            + p(4)*T(i) + p(5)*T(i)^2/2 + p(6)*T(i)^3/3 ...
            + p(7)*T(i)^4/4 + p(9));
    end
else
    disp('please specific a NASA polynomial format: NASA7 or NASA9');
end
G = H - T.*S;
