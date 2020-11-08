function chromosome = Mutate(chromosome, mutateProbability)
    mutateAt = rand(size(chromosome)) < mutateProbability;
    chromosome(mutateAt) = 1 - chromosome(mutateAt);
end