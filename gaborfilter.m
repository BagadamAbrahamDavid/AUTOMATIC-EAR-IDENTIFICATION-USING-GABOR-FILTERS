function [gabout Fam Fph Fri] = gaborfilter(I,Sx,Sy,f,theta);

if isa(I,'double')~=1 
    I = double(I);
end
sz=16;
for x = -sz:sz
    for y = -sz:sz
        xPrime = x * cos(theta) + y * sin(theta);
        yPrime = y * cos(theta) - x * sin(theta);
        G(fix(sz)+x+1,fix(sz)+y+1) = exp(-.5*((xPrime/Sx)^2+(yPrime/Sy)^2))*exp(2*pi*f*xPrime);%cos(2*pi*f*xPrime);
    end
end


Imgabout = conv2(I,double(imag(G)),'same');
Regabout = conv2(I,double(real(G)),'same');

gabout = sqrt(Imgabout.*Imgabout + Regabout.*Regabout);

Fam=gabout;

Fph=atan(Imgabout/Regabout);
Fri=[Regabout];