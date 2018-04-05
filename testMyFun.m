function [out] = testMyFun(num1)
if num1 ~= 2
    error('You should put the number 2')
else
    out = num1*2;
end

