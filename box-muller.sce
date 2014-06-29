clear;
clf;

n = 50000;
p = floor(sqrt(n));
scale = 50;

N = zeros(2,n);

for i=1:n
    U = grand(1,2,"unf",0,1);
    
    R = sqrt(-2 * log(U(1,1)));
    
    N(1,i) = R * cos(2 * %pi * U(1,2));
    N(2,i) = R * sin(2 * %pi * U(1,2));
end

lx = min(N(1,:));
rx = max(N(1,:));
ly = min(N(2,:));
ry = max(N(2,:));

disp("lens");

lenx = (rx - lx) / p;
leny = (ry - ly) / p;

x = linspace(lx,rx,p + 1);
y = linspace(ly,ry,p + 1);

disp(n,p);

M = zeros(p,p);

for i=1:n
    indx = min(floor((N(1,i) - lx) / lenx) + 1,p);
    indy = min(floor((N(2,i) - ly) / leny) + 1,p);
    M(indx, indy) = M(indx, indy) + 1;
end

M = M;

hist3d(list(M,x,y), leg=" Methode de Box-Muller@X@Y@Z");
