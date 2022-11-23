function [left, right] = Vowel(x, Fs, t_frame)
    framesize = t_frame * Fs;
    nFrame = floor(length(x) / framesize);
    threshold = 0.0184; % STEThreshold(t_frame);
    ste = STE(x, nFrame, framesize);
    ste = ste / max(abs(ste));
    j = 1;
    statistic = [];
    for i=1:(nFrame - 1)
        if (ste(i) >= threshold && ste(i + 1) < threshold)
            % silence
            statistic(j, 1) = i;
            statistic(j, 2) = -1;
            j = j + 1;
        elseif (ste(i) < threshold && ste(i + 1) >= threshold)
            % speech
            statistic(j, 1) = i;
            statistic(j, 2) = 1;
            j = j + 1;
        end 
    end
    left = 1; right = 1; maxSTE = 0;
    for i = 1:length(statistic) - 1
        s = sum(ste(statistic(i):statistic(i + 1)));
        if (s > maxSTE)
            left = statistic(i, 1);
            right = statistic(i + 1, 1);
            maxSTE = s;
        end
    end
end