function [letter] = get_letter_place(row)
    for i = 1:26
        if row(i) == 1
               letter = i;
        end
    end
end

