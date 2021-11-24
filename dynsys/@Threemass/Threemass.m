classdef Threemass < CtrlAffineSys
    methods
        function clf = defineClf(obj, params, symbolic_state)
       
        end


        function cbf = defineCbf(obj, params, symbolic_state)
        c=3.15-symbolic_state(3);
        end


    end    
end
