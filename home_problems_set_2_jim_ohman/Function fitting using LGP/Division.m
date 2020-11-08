function z = Division(x, y)
    y(y == 0) = 10^(-5);
    z = x ./ y;
end