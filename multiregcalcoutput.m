%% Calculate output from regression
%CMM 2020
function [output]= multiregcalcoutput(inputmatrix, numbComp, PolynomialFormula)
%To avoid the faff of having this block here, it just calculates the output
%from polynomialformula after a regression
if numbComp==2
    x1=inputmatrix(:,1);
    x2=inputmatrix(:,2);
    output=PolynomialFormula(x1,x2);
elseif numbComp==3
    x1=inputmatrix(:,1);
    x2=inputmatrix(:,2);
    x3=inputmatrix(:,3);
    output=PolynomialFormula(x1,x2,x3);
elseif numbComp==4
    x1=inputmatrix(:,1);
    x2=inputmatrix(:,2);
    x3=inputmatrix(:,3);
    x4=inputmatrix(:,4);
    output=PolynomialFormula(x1,x2,x3,x4);
elseif numbComp==5
    x1=inputmatrix(:,1);
    x2=inputmatrix(:,2);
    x3=inputmatrix(:,3);
    x4=inputmatrix(:,4);
    x5=inputmatrix(:,5);
    output=PolynomialFormula(x1,x2,x3,x4,x5);
elseif numbComp==6
    x1=inputmatrix(:,1);
    x2=inputmatrix(:,2);
    x3=inputmatrix(:,3);
    x4=inputmatrix(:,4);
    x5=inputmatrix(:,5);
    x6=inputmatrix(:,6);
    output=PolynomialFormula(x1,x2,x3,x4,x5,x6);
end

end
