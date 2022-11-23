function result = VoiceStatistic(sample, n_frame, t_frame)
    result = zeros(1, n_frame);
    for i=1:length(sample) - 1
        left = floor((sample(i, 1) / t_frame)) + 1;
        right = ceil(sample(i + 1, 1) / t_frame); 
        for j=left:right
            result(j) = sample(i, 2);
        end
    end
end

