function newIndividuals = Cross(individuals)
   
   [numberOfGenes, ~] = size(individuals{1}.genes);
   crossAtOne = sort(randperm(numberOfGenes, 2));
   
   [numberOfGenes, ~] = size(individuals{2}.genes);
   crossAtTwo = sort(randperm(numberOfGenes, 2));
   
   newIndividuals = individuals;
   
   newGenes = [individuals{1}.genes(1:crossAtOne(1)-1, :);
               individuals{2}.genes(crossAtTwo(1):crossAtTwo(2), :);
               individuals{1}.genes(crossAtOne(2)+1:end, :)];
   
   newIndividuals{1}.genes = newGenes;
   
   newGenes = [individuals{2}.genes(1:crossAtTwo(1)-1, :);
               individuals{1}.genes(crossAtOne(1):crossAtOne(2), :);
               individuals{2}.genes(crossAtTwo(2)+1:end, :)];

   newIndividuals{2}.genes = newGenes;
   
end