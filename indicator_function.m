function x = indicator_function(c,t)

n = length(t);
x = c;
if n>2
    for j=2:n-1
        x(c>=(t(j-1)+t(j))/2 & c<(t(j+1)+t(j))/2) = t(j);
    end

    x(c<(t(2)+t(1))/2) = t(1);

    x(c>=(t(n-1)+t(n))/2) = t(n);
else
    x(c<(t(2)+t(1))/2) = t(1);

    x(c>=(t(n-1)+t(n))/2) = t(n);
end