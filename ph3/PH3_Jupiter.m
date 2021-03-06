clear all;
close all;

T_data = [450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100 1150 1200 1250 1300 ...
    1350 1400 1450 1500];
PG_data = [26.11888627 37.28801102  51.47093862...
    69.10266133 90.64326221 116.5812512...
     147.4369918  183.7665559  226.1655185...
     275.2726254  331.7730034  396.4009975...
     469.9423185  553.2361601  647.1768949...
     752.7160803  870.8644035  1002.692785...
    1149.33307  1311.980671  1491.89799...
    1690.413976];

X_H2 = 0.864;
X_P = 7.0e-7*X_H2;
g = 24.79;
alpha = 1.0;

N_K_eddy = 30; 
X_H2O = 9.8e-4*[1,10,20,30]*X_H2;
N_H2O = length(X_H2O);
K_eddy = 10.^linspace(3,13,N_K_eddy);
X_PH3_quench = zeros(N_H2O,N_K_eddy);
for j=1:N_H2O
for i=1:N_K_eddy
    [X_PH3_quench(j,i), quench_T quench_PG,k_1_f,T ] = XPH3_quench(T_data, PG_data,...
    K_eddy(i), X_H2O(j), X_H2, X_P,g,alpha);
end
end

% cover to mixing ratio
q_PH3_quench = X_PH3_quench/X_H2;

% for a variety of K
figure()
set(gca,'FontSize',14);
semilogx(K_eddy,q_PH3_quench(1,:),'b','LineWidth',3);
xlabel('$K_{\rm eddy}$ (cm$^2$ s$^{-1}$)','interpreter','latex')
ylabel('mixing ratio','interpreter','latex')
xlim([1e3,1e13])
ylim([0,1e-6])

hold on;
semilogx(K_eddy,q_PH3_quench(2,:),'k','LineWidth',3);
semilogx(K_eddy,q_PH3_quench(3,:),'g','LineWidth',3);
semilogx(K_eddy,q_PH3_quench(4,:),'r','LineWidth',3);

% Create legend
legend1 = legend('$E_{\rm H_2O}$ = 1','$E_{\rm H_2O}$ = 10','$E_{\rm H_2O}$ = 20',...
    '$E_{\rm H_2O}$ = 30');

set(legend1,'Interpreter','latex','YColor',[1 1 1],'XColor',[1 1 1],...
    'Position',[0.622154017857143 0.301785714285715 0.266964285714286 0.321130952380952],...
    'FontSize',12);

% Create textbox
annotation('textbox',...
    [0.448214285714286 0.742857142857143 0.0875 0.0942380952380953],...
    'Interpreter','latex',...
    'String',{'PH$_3$'},...
    'FontWeight','bold',...
    'FontSize',18,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation('textbox',...
    [0.682499999999999 0.14904761904762 0.0875 0.0942380952380953],...
    'Interpreter','latex',...
    'String',{'Jupiter'},...
    'FontWeight','bold',...
    'FontSize',18,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

%% add two horizontal lines
hold on;
semilogx(logspace(3,13,30),(7.0-1.0)*1e-7*ones(1,30),'k--','LineWidth',1);
hold on;
semilogx(logspace(3,13,30),(7.0+1.0)*1e-7*ones(1,30),'k--','LineWidth',1);

%% add two vertical lines
N_points = 30;
x1 = 1e7*ones(1,N_points);
x2 = 1e9*ones(1,N_points);
y = linspace(0e-6,1e-6,N_points);
hold on;
semilogx(x1,y,'k--','LineWidth',1);
hold on;
semilogx(x2,y,'k--','LineWidth',1);

% %% add simulation points
% %% 10/20/30 times solar
% K_eddy = [1e5,1e6,1e7];
% X_PH3 = [1.81e-6 1.81e-6 1.81e-6;
%     1.66e-6 1.72e-6 1.74e-6;
%     1.44e-6 1.55e-6 1.60e-6];
% X_H2 = [0.856 0.850 0.843];
% q_PH3=zeros(3,3);
% for i=1:3
%     q_PH3(i,:)=X_PH3(i,:)/X_H2(i);
% end
% hold on;
% semilogx(K_eddy,q_PH3(1,:),'k*')
% hold on;
% semilogx(K_eddy,q_PH3(2,:),'g*')
% hold on;
% semilogx(K_eddy,q_PH3(3,:),'r*')

%% fit the forward reaction rate for PO2 + H2O - HOPO2 + H
n = length(T);
A = [ones(n,1) -1./T'];
b = log(k_1_f');
x = A\b;