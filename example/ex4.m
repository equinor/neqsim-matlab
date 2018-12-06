clear all
ex2
j=0;
temp = linspace(280,300,50)
pres = linspace(1,20,10)

for temp1 = linspace(280,300,50)
    k=0;
    j = j+1;
    for pres1 = linspace(1,20,10)
        k = k+1;
        a = Z(test,temp1,pres1);
        b= molefrac(test, 1);
        entalp(k,j,:) = a;
        frac(k,j,:) = b;
    end
end

surf(temp,pres,frac(:,:,3))
