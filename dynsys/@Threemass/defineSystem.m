function [x, f, g] = defineSystem(~, ~)
    syms x1 x2 x3 x1_d x2_d x3_d;
    x = [x1; x2; x3; x1_d; x2_d; x3_d];
    k=10;
    m1=5;
    m2=5;
    m3=5;
    
    A=[0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1; -k/m1 k/m1 0 0 0 0;k/m2 -2*k/m2 k/m2 0 0 0;
        0 k/m3 -k/m3 0 0 0]; 
    B=[0;0;0;1/m1;0;0]

    f = A * x;
    g = B;
end