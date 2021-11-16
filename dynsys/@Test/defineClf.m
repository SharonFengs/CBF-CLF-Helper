function clf = defineClf(~, params, symbolic_state)
    x = symbolic_state;
    xd = params.xd
    clf = (x-xd)^2;
end

