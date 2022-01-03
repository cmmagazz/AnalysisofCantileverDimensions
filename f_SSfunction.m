
function F = f_SSfunction(a,data)
    pc1 = data(:,1);
    pc2 = data(:,2);
    pc3 = data(:,3);
    %F=a(1)*pc1+a(2)*pc2+a(3)*pc3+a(4)+a(9)*a(10)./((bsxfun(@plus,pc1*a(5)+pc2*a(6)+pc3*a(7),-19725)).^2+a(10)^2);
    F=a(1)*pc1+a(2)*pc2+a(3)*pc3+a(4)+a(9)*a(10)./((pc1*a(5)+pc2*a(6)+pc3*a(7)+a(8)).^2+a(10)^2);
end
