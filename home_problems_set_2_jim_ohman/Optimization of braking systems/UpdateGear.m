function gear = UpdateGear(gear, gearChange)
    suggestedGear = floor(10*gearChange + 1);
    if gear < suggestedGear
        gear = gear + 1;
    elseif gear > suggestedGear
        gear = gear - 1;
    end
end