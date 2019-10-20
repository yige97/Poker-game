classdef Player <handle
    properties (Access = public)
        cards
        playerButton
    end
    
        methods
            function result = Player()
                
            end
            
            function update_cards(obj,played_cards)
               for i = 1: length(played_cards)
                   x= find(played_cards(i) == obj.cards);
                   x = x(1);
                   obj.cards(x) = [];
               end
            end
    end
end

