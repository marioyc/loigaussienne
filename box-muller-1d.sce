clear;
clf;
stacksize(30000000);

N = 100000;
p = floor(sqrt(N));

tic();

res = zeros(1,N);

for i=1:N
    U = grand(1,2,"unf",0,1);
    
    R = sqrt(-2 * log(U(1,1)));
    
    res(1,i) = R * cos(2 * %pi * U(1,2));
end

disp(toc(),'Methode Box-Muller, time = ');

x=linspace(-5,5,10000);

y=exp(-x.^2/2)/(sqrt(2*%pi));

histplot(p,res,style=2);

plot2d(x,y,style=5);

xtitle('Histogramme de '+string(N)+' gaussiennes');

show_window;
