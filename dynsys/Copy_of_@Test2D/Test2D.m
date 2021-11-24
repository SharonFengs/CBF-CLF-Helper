classdef Test2D < CtrlAffineSys
    methods
        function clf = defineClf(obj, params, symbolic_state)
            x = symbolic_state;
            A = zeros(4);
            A(1, 2) = 1;
            A(3, 4) = 1;
            B = [0 0; 1 0; 0 0; 0 1];
            Q = eye(size(A));
            R = eye(size(B,2));
            [~,P] = lqr(A,B,Q,R);
            e = x - [params.p_d(1); 0; params.p_d(2); 0];
            clf = e' * P * e;        
        end


        function cbf = defineCbf(obj, params, symbolic_state)
            x = symbolic_state;
            x_o = params.x_o; % position of the obstacle.
            y_o = params.y_o;
            %r_o = params.r_o; % radius of the obstacle.
            distance_x = (x(1) - x_o)^2;
            distance_y = (x(3) - y_o)^2;
            derivDistance_x = 2*(x(1)-x_o)*x(2);
%           cbf = derivDistance_x + params.cbf_gamma0 * distance_x;
            derivDistance_y = 2*(x(3)-y_o)*x(4);
            %obscale 1
            p_o = params.p_o; % position of the obstacle.
            r_o = params.r_o; % radius of the obstacle.
            distance = (x(1) - p_o(1))^2 + (x(3) - p_o(2))^2 - r_o^2;
            derivDistance = 2*(x(1)-p_o(1))*x(2) + 2*(x(3)-p_o(2))*x(4);
            cbf3 = derivDistance + params.cbf_gamma0 * distance;
            cbf = [derivDistance_x + params.cbf_gamma0 * distance_x;derivDistance_y + params.cbf_gamma0 * distance_y;cbf3];
        end

        %         function cbf = defineCbf(obj, params, symbolic_state)
%             x = symbolic_state;
%             x_1 = params.x_1; % wall#1.
%             y_1 = params.y_1; % wall#2.
%             %r_o = params.r_o; % radius of the obstacle.
%             distance_x = (x(1) - x_1)^2;
%             distance_y = (x(3) - y_1)^2;
%             derivDistance_x = 2*(x(1)-x_1)*x(2);
%             derivDistance_y = 2*(x(3)-y_1)*x(4);
%             cbf = derivDistance_x + params.cbf_gamma0 * distance_x;
%         end
    end    
end
