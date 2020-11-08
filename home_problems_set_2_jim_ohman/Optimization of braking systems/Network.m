function output = Network(input, architecture)
    output = input;
    for i = 1:(architecture.numberOfLayers)
        output = output * architecture.weights{i};
        output = output + architecture.biases{i};
        output = architecture.activations{i}(output);
    end
end