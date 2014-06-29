clear;
clf;
stacksize(30000000);

n = 256;
r = 3.6541528853610088;
v = 0.004928673233;

N = 10000000;
p=round(sqrt(N));

tic();

function [y] = f(x)
    y = exp(-x^2 / 2)
endfunction

function [y] = tail(r)
    while 1 do
        U = grand(1,2,"def");
        x = -1/r * log(U(1,1));
        y = -log(U(1,2));
        
        if(2 * y > x * x)
            y = r + x;
            break;
        end
    end
endfunction

function[y] = signe()
    s = grand(1,1,"uin",0,1);
    
    if s == 0 then
        y = -1
    else
        y = 1
    end
endfunction

x = zeros(1,n + 1);
x(1,n + 1) = r;

for i = 1:n - 1
    x(1,n - i + 1) = sqrt(-2 * log(v / x(1,n - i + 2) + f(x(1,n - i + 2))));
end

y = exp(-x.^2 / 2);

k = zeros(1,n);

for i = 1:n - 1
    k(1,i) = x(1,i) / x(1,i + 1);
end

k(1,n) = r * f(r) / v;

res = zeros(1,N);
pos = 1;

while pos <= N do
    U = grand(1,1,"def");
    v = grand(1,1,"uin",1,n);
    X = U * x(1,v);
    
    if(U < k(1,v))
        res(1, pos) = X * signe();
        pos = pos + 1;
    else
        if(v == n)
            res(1, pos) = tail(r) * signe();
            pos = pos + 1;
        else
            U2 = grand(1,1,"def");
            
            if(y(1,v + 1) + (y(1,v) - y(1,v + 1)) * U2 < f(X))
                res(1,pos) = X * signe();
                pos = pos + 1;
            end
        end
    end
end

disp(toc(),'Methode Ziggourat, time = ');

x=linspace(-5,5,10000);

y=exp(-x.^2/2)/(sqrt(2*%pi));

histplot(p,res,style=2);

plot2d(x,y,style=5);

xtitle('Histogramme de '+string(N)+' gaussiennes');

show_window;
