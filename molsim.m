clc;clear all;clf;
%%% Contants
KbT = 0.5;
N = 1000000;
M = 1;
gamma = 1;
dt = 0.001;
%%%%%%%%%%%%%%
%Potential Well
x =-2:0.000001:2 ;
V = -0.5*x.^2 + 0.25*x.^4;
figure(1)
plot(x,V);
title('Potential Well')
xlabel('X')
ylabel('E potential')
%print('-dpng','Well')
%%%%%%%%%%%%%%%
N = 100000;
X_0 = 0;
V_0 = KbT;
x = zeros(1,N);
v = zeros(1,N);
x(1) = X_0;
v(1) = V_0;
Dwell = 0;
Tau_Dwell = 0;
FirstTime = 0;
for T = 1:N-1
Dwell = Dwell + dt;
F_R = sqrt((2*M*KbT*gamma)/dt)*randn();
F_C = x(T) - x(T)^3;
x(T+1) = x(T) + v(T)*dt + 0.5*(-gamma*v(T) + (1/M)*(F_R + F_C))*(dt^2);
v(T+1) = v(T) + (-gamma*v(T) + (1/M)*(F_R + F_C))*dt;
if ((x(T) > 0 && x(T+1) < 0) || (x(T) < 0 && x(T+1) > 0))
    if (FirstTime == 0)
    Tau_Dwell = Dwell;
    FirstTime = FirstTime + 1;
    end
    if (FirstTime == 1)
    Tau_Dwell = (Tau_Dwell + Dwell)/2;
    end
    Dwell = 0;
end
end
figure(2)
subplot(3,1,1);plot(x)
title('Position')
ylabel('X (arb units)')
xlabel('Steps')
subplot(3,1,2);plot(v)
title('Velocity')
ylabel('V(arb units)')
xlabel('Steps')
subplot(3,1,3);plot(x,v)
title('Phase Plot')
ylabel('V (arb units)')
xlabel('X (arb units)')
%print('-dpng','ParticleMotion')
figure(3)
hist(x)
title('Histogram of Position')
xlabel('X position')
ylabel('Count')
%print('-dpng','HIST')
figure(4)
xlim([-2, 2]) 
plot(x,v)
title('Phase Plot')
ylabel('V (arb units)')
xlabel('X (arb units)')



