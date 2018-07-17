function [ y, yi ] = enumerate( x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
y = nan(sum(x),1);
yi = y;
count = 1;
for i = 1:numel(x)
    y(count:count+x(i)-1) = i;
    yi(count:count+x(i)-1) = 1:x(i);
    count = count + x(i);
end

end

