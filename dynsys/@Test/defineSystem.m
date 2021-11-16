function [x, f, g] = defineSystem(~, params)
    syms x % states
    a = params.a;
    b = params.b;

    % Dynamics
    f = a*x;
    g = b;
end