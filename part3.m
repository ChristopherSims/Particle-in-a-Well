clear all;clc;clf;
D = 5;
alpha = 0.5;
Kb = 1.38E-23;
R_max = 3E-10;
r = -R_max:R_max/10000:R_max;
T = 300;
C = Kb*T;
%%%%%%%%%%%
%
%%%%%%%%%%%
V_N = D*(1-exp(-alpha*r)).^2;
p_N = exp(-V_N/(Kb*T));
figure(1)
subplot(2,1,1);plot(r,V_N)
subplot(2,1,2);plot(r,p_N)
%%%%%%%%%%%%%%%
% Harmonic Approximation
%%%%%%%%%%%%%%%
K = D*alpha^2;
V_L = 0.5*K*r.^2;
P_L = exp(-V_L/(Kb*T));
figure(2)
subplot(2,1,1);plot(r,V_L);
title('Harmonic Approximation') 
subplot(2,1,2);plot(r,P_L);
figure(3)
hold on
plot(r,V_L,'b');
plot(r,V_N,'r');
legend('Harmonic Approximation','Morse Potential')
hold off
e = 5E-23;
p_L = [];
p_N = [];
average_L = [];
average_N =[];
for T = 1:300
for i = 1:length(r)
  if((V_L(i) < Kb*T + e)&&(V_L(i) > Kb*T - e))
      p_L = [p_L,r(i)];    
  end
   if((V_N(i) < Kb*T + e)&&(V_N(i) > Kb*T - e))
   p_N = [p_N,r(i)];
   end
end
average_L = [average_L,(p_L(1) + p_L(2))/2];
average_N = [average_N,(p_N(1) + p_N(2))/2];
p_L = [];
p_N = [];
end
figure(4)
hold on
plot(1:300,average_L,'b');
plot(1:300,average_N,'g');
legend('approximation','Morse')
xlabel('Tempurature')
ylabel('Position')
hold off
N = sum(average_L)/300;
L = sum(average_N)/300;



