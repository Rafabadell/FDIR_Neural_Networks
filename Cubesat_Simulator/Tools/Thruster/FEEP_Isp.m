F=0:0.1:50;
Isp = zeros(1,length(F));

for i=1:length(F)
    if F(i)<=2
        Isp(i) = 8250+250/2*F(i);
    else
        Isp(i) = 8500+(3000-8500)*(1-exp(-(F(i)-2)/9));
    end
end

plot(F,Isp)
        