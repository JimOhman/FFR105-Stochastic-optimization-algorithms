function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1)                                % Training
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope == 2)
   alpha = 5 - 2*sin(x/100) - cos(sqrt(2)*x/30);
 elseif (iSlope == 3)
   alpha = 3 + 2*sin(x/50) - cos(sqrt(5)*x/200);
 elseif (iSlope == 4)
   alpha = 2 + x/500 + sin(x/100) + cos(x/50);
 elseif (iSlope == 5)
   alpha = 6 - x/500 + sin(x/100) + cos(3*x/130);
 elseif (iSlope == 6)
   alpha = 2 + x/500 + sqrt(2)*sin(x/30) + cos(5*x/130);
 elseif (iSlope == 7)
   alpha = 7 - x/500 - sqrt(2)*sin(x/60) + cos(2*x/70);
 elseif (iSlope == 8)
   alpha = 5 - x/1500 + sqrt(5)*sin(x/60) + cos(2*x/250);
elseif (iSlope == 9)
   alpha = 7 - x/200 + sin(x/100) - cos(x/70);
 elseif (iSlope == 10)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
 end

elseif (iDataSet == 2)                            % Validation
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
 elseif (iSlope == 2) 
   alpha = 4 + 2*sin(x/30) + cos(sqrt(7)*x/70);
 elseif (iSlope == 3) 
   alpha = 6 - sin(x/30) + cos(sqrt(7)*x/140);
 elseif (iSlope == 4)
   alpha = 3 + 2*sin(x/120) - cos(sqrt(2)*x/70);
 elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
 end
 
elseif (iDataSet == 3)                            % Test
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);
 elseif (iSlope == 2)
   alpha = 5 + (x/1000) - sin(x/70) + cos(sqrt(3)*x/100);
 elseif (iSlope == 3)
   alpha = 6 - (x/500) + sin(x/140) + cos(x/30);
 elseif (iSlope == 4)
   alpha = 4 + 2*sin(x/50) - cos(sqrt(2)*x/250);
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
 end

end
