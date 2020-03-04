function weights = kaimingUniform(sz, layer)
    switch layer
        case "conv"
            k = 1/prod(sz(1:3));
        case "fc"
            k = 1/sz(2);
        otherwise
            error("Unrecognised layer")
    end
    weights = sqrt(k)*(2*rand(sz) - 1);
end