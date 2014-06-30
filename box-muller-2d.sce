clear;
clf;

N = 50000;
p = floor(sqrt(N));
scale = 50;

res = zeros(2,N);

for i=1:N
    U = grand(1,2,"unf",0,1);
    
    R = sqrt(-2 * log(U(1,1)));
    
    res(1,i) = R * cos(2 * %pi * U(1,2));
    res(2,i) = R * sin(2 * %pi * U(1,2));
end

lx = min(res(1,:));
rx = max(res(1,:));
ly = min(res(2,:));
ry = max(res(2,:));

disp("lens");

lenx = (rx - lx) / p;
leny = (ry - ly) / p;

x = linspace(lx,rx,p + 1);
y = linspace(ly,ry,p + 1);

M = zeros(p,p);

for i=1:N
    indx = min(floor((res(1,i) - lx) / lenx) + 1,p);
    indy = min(floor((res(2,i) - ly) / leny) + 1,p);
    M(indx, indy) = M(indx, indy) + 1;
end

hist3d(list(M,x,y), leg=" Methode de Box-Muller@X@Y@Z");
