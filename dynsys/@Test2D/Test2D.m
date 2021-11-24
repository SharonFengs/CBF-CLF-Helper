classdef Test2D < CtrlAffineSys
    methods
        function clf = defineClf(obj, params, symbolic_state)
            x = symbolic_state;
            A = zeros(4);
            A(1, 2) = 1;
            A(3, 4) = 1;
            %B = [0 0; 1 0; 0 0; 0 1];
            B = [0 0; 1 0;0 0;0 1];
            Q = eye(size(A));
            R = eye(size(B,2));
            [~,P] = lqr(A,B,Q,R);
            
            e = x - [params.p_d(1); 0; params.p_d(2); 0];
            clf = e' * P * e;        
        end

        function cbf = defineCbf(obj, params, symbolic_state)
            x = symbolic_state;
            x_o = params.x_o; % position of the wall.
            cbf = (x_o - x(1));%boundry function
            
        end


    end    
end
