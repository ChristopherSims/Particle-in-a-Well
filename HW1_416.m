clear all;clc;clf;
fid = fopen('4.xyz','r');
num = fscanf(fid,'%f',1);
header = fscanf(fid,'%s',3);
table = zeros(num,6);
% load Values
for i = 1:num-1
type= fscanf(fid,'%s',1); % read num of types 
if size(type) == 1
  table(i,1:3) = [type,0,0];
elseif size(type) == 2
  table(i,1:3) = [type,0];
elseif size(table) == 3
    table(i,1:3) = type;
end
table(i,4:6) = fscanf(fid,'%f %f %f',3)';
end
fclose(fid);

%find max dx,dy,dz
x0 = table(round(num/2),4);
y0 = table(round(num/2),5);
z0 = table(round(num/2),6);
xmax = 0;ymax = 0;zmax = 0; % set max to zero
for i = 1:num-1
 x = abs(x0 - table(i,4));
    if x > xmax
xmax = x;
    end
y = abs(y0 - table(i,5));
if y > ymax
    ymax = y;
end
z = abs(z0 - table(i,6));
if z > zmax
zmax = z;
end
end
RadialMax = sqrt(xmax^2 + ymax^2 + zmax^2); % calculate radial max in spherical
NUM_BIN = 600; % number of Bins
BIN_Width = RadialMax/NUM_BIN; %Bin width

%Radial Distance
%find max dx,dy,dz
x0 = table(1,4);y0 = table(1,5);z0 = table(1,6);
xmax = 0;ymax = 0;zmax = 0; % set max to zero
Radial = 1:num-1;
for i = 1:num-1
x = abs(x0 - table(i,4));
y = abs(y0 - table(i,5));
z = abs(z0 - table(i,6));
Radial(i) = sqrt(x^2 + y^2 + z^2);
end
V = 0:BIN_Width:RadialMax;
figure(1)
hold on
title('5')
ylabel('count')
xlabel('Radial distance')
xlim([0,10])
hist(Radial,V)
hold off
figure(2)
n = histc(Radial,0:BIN_Width:RadialMax);
plot(V,n)
xlim([0,10])
Ratio = [0,0,0];
NUM = [0,0,0];
order = 0;
for i = 2:length(V)
    if (n(i) ~= 0) && (order == 0)
   Ratio(1) = V(i);
   NUM(1) = n(i);
   order = order+ 1;
    elseif (n(i) ~= 0) && (order == 1)
        Ratio(2) = V(i);
        NUM(2) = n(i);
        order = order+1;
        elseif (n(i) ~= 0) && (order == 2)
        Ratio(3) = V(i);
        NUM(3) = n(i);
        order = order+1;
    end
end
R = Ratio;
BCC = [sqrt(3)/2,1,sqrt(3)];
FCC = [sqrt(2)/2, 1,sqrt(2)];
Graphene = [0.5,sqrt(3)/2, 1];
Water = [1,2];
figure(3)
plot(NUM,Ratio)