clear;
clf;

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

n = 256;
x = zeros(1,n + 1);

r = 3.6541528853610088;
v = 0.004928673233;
x(1,n) = r;

for i = 1:n - 2
    x(1,n - i) = sqrt(-2 * log(v / x(1,n - i + 1) + f(x(1,n - i + 1))));
end

k = zeros(1,n + 1);

for i = 2:n
    k(1,i) = x(1,i - 1) / x(1,i);
end

k(1,n + 1) = r * f(r) / v;

//disp(x(1,n - 1));
//disp(x(1,2));
//disp(x(1,1));

N = 50000;

res = zeros(1,N);
pos = 1;

while pos <= N do
    U = grand(1,1,"def");
    v = grand(1,1,"uin",2,n + 1);
    X = U * x(1,v);
    
    if(U < k(1,v))
        s = grand(1,1,"uin",0,1);
        
        if s == 0 then
            X = -X;
        end
        
        res(1, pos) = X;
        pos = pos + 1;
    else
        U2 = grand(1,1,"def");
        
        if(v == n)
            X = tail(r);
            s = grand(1,1,"uin",0,1);
            
            if s == 0 then
                X = -X;
            end
            
            res(1, pos) = X;
            pos = pos + 1;
        elseif(f(x(1, v)) + (f(x(1, v)) - f(x(1,v)) * U2 < f(X)))
            s = grand(1,1,"uin",0,1);
            
            if s == 0 then
                X = -X;
            end
            
            res(1,pos) = X;
            pos = pos + 1;
        end
    end
end

p=round(sqrt(N));

x=linspace(-5,5,10000);

y=exp(-x.^2/2)/(sqrt(2*%pi));

histplot(p,res,style=2);

plot2d(x,y,style=5);

xtitle('Histogramme de '+string(N)+' gaussiennes');

show_window;
