classdef Controller < handle
    properties(Access = public)
       played_cards = []
    end    
    methods
        
        function result = Controller(cards_played)
            result.played_cards = cards_played;
        end
 
        function repeat = repPlane(~,readyToPlay)  % 飞机中重复的数字
            repeat = [];
            for i = 1:8
                if sum(readyToPlay(:)==readyToPlay(i)) == 3
                    repeat(end+1) = readyToPlay(i);
                end
            end
            repeat = unique(repeat);
        end
        
        function repeat = repTwo(~,readyToPlay)
            repeat = [];
            for i = 1:6
                if sum(readyToPlay(:)==readyToPlay(i)) == 2
                    repeat(end+1) = readyToPlay(i);
                end
            end
            repeat = unique(repeat);
        end
        
        function result = isValid(obj,readyToPlay) % judge if play_cards follow the playing rules  
            if length(readyToPlay) == 0
                result = false;
            elseif length(readyToPlay) == 1
                result = true;
            elseif length(readyToPlay) == 2  
                if readyToPlay(1) == readyToPlay(2)   % length(unique(cards_played))==1
                    result = true;
                elseif (ismember(16,readyToPlay)) && (ismember(17,readyToPlay)) 
                    result = true;
                else
                    result = false;
                end
            elseif length(readyToPlay) == 3
                if length(unique(readyToPlay)) == 1 
                    result = true;
                else
                    result = false;
                end
            elseif length(readyToPlay) == 4
                if length(unique(readyToPlay)) == 1  % bomb
                    result = true;
                elseif length(unique(readyToPlay)) == 2  % 三带一：成功， 连对：失败
                    new_list = unique(readyToPlay);
                    if length(find(new_list(1)==readyToPlay)) == 2  % 连对
                        result = false;
                    else
                        result = true;
                    end
                else
                    result = false;
                end
            elseif length(readyToPlay) == 5
                if length(unique(readyToPlay)) ==2 % 4+1 failed   3+2 success
                    new_list = unique(readyToPlay);
                    if length(find(new_list(1)==readyToPlay)) == 1  || length(find(new_list(1)==readyToPlay))==4 %4+1
                        result = false;
                    else
                        result = true;
                    end
                elseif length(unique(readyToPlay)) == 5 
                    if ismember(16,readyToPlay) || ismember(17,readyToPlay)
                        result = false;
                    elseif readyToPlay(5) - readyToPlay(1)== 4
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;      
                end
            elseif length(readyToPlay) == 6
                if sum(readyToPlay(:)==mode(readyToPlay)) == 4
                    result = true;
                elseif length(obj.repTwo(readyToPlay)) == 3
                    rep = obj.repTwo(readyToPlay);
                    if rep(1) == (rep(2)-1) && rep(2) == (rep(3)-1)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            elseif length(readyToPlay) == 8  % plane
                rep = obj.repPlane(readyToPlay);
                if length(rep) == 2 && rep(1) == (rep(2)-1)
                    result = true;
                else
                    result = false;
                end
            else
                result = false;
            end
        end
        
        
        function result = compare(obj,readyToPlay)
            result = false;
            if length(obj.played_cards) == 0
                result = true;
            elseif length(obj.played_cards) ~=length(readyToPlay) 
                if length(readyToPlay) == 4 && length(unique(readyToPlay)) == 1
                    result = true;
                elseif length(readyToPlay) == 2 && ismember(16,readyToPlay) && ismember(17,readyToPlay)
                    result = true;
                else
                    result = false;
                end
            else
                if length(readyToPlay) ==1 
                    if obj.played_cards(1) < readyToPlay(1)
                        result = true;
                    end
                elseif length(readyToPlay) == 2  
                    if obj.played_cards(1) < readyToPlay(1)
                        result = true;
                    end
                elseif length(readyToPlay) == 3 
                    if obj.played_cards(1) < readyToPlay(1)
                        result = true;
                    end
                elseif length(readyToPlay) == 4
                    if length(unique(readyToPlay)) == 1  && length(unique(obj.played_cards)) == 1 
                        if  obj.played_cards(1) < readyToPlay(1)
                            result = true;
                        end
                    elseif length(unique(obj.played_cards)) == 2  && length(unique(readyToPlay)) ==1   % 三带一 
                        result = true;
                    elseif length(unique(obj.played_cards)) == 2  && length(unique(readyToPlay)) ==2
                        if mode(obj.played_cards) < mode(readyToPlay)
                            result = true;
                        end
                    end
                elseif length(readyToPlay) == 5
                    if length(unique(readyToPlay)) ==2 && length(unique(obj.played_cards)) == 2 % 3+2 success
                        if mode(readyToPlay) > mode(obj.played_cards)
                            result = true;
                        end
                    elseif length(unique(readyToPlay)) == 5 && length(unique(obj.played_cards)) == 5
                        if readyToPlay(1) > obj.played_cards
                            result = true;
                        end
                    end
                elseif length(readyToPlay) == 6
                    if length(obj.repTwo(readyToPlay)) == 3 && length(obj.repTwo(obj.played_cards)) == 3
                        if max(obj.repTwo(readyToPlay)) > max(obj.repTwo(obj.played_cards))
                            result = true;
                        end
                        
                    elseif sum(readyToPlay(:)==mode(readyToPlay)) == 4 && sum(obj.played_cards(:)==mode(obj.played_cards)) == 4
                        if mode(redayToPlay) > mode(obj.played_cards)
                            result = true;
                        end
                    end
                elseif length(readyToPlay) == 8
                    if max(obj.repPlane(readyToPlay)) > max(obj.repPlane(obj.played_cards))
                        result =true;
                    end
                end
            end
            
        end
        
    end
        
        
end
    