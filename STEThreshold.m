function silenceThreshold = STEThreshold(t_frame)
    % 04MHB
    [x1, Fs1] = audioread('TinHieuHuanLuyen-16k/04MHB.wav');
    frameSizeMHB = floor(t_frame * Fs1);
    nFrameMHB = floor(length(x1) / frameSizeMHB);
    steMHB = STE(x1, nFrameMHB, frameSizeMHB);
    
    % 10MSD
    [x2, Fs2] = audioread('TinHieuHuanLuyen-16k/10MSD.mp3');
    frameSizeMSD = floor(t_frame * Fs2);
    nFrameMSD = floor(length(x2) / frameSizeMSD);
    steMSD = STE(x2, nFrameMSD, frameSizeMSD);
    
    % 14FFH
    [x3, Fs3] = audioread('TinHieuHuanLuyen-16k/14FFH.wav');
    frameSizeFFH = floor(t_frame * Fs3);
    nFrameFFH = floor(length(x3) / frameSizeFFH);
    steFFH = STE(x3, nFrameFFH, frameSizeFFH);
    
    % 06FTB
    [x4, Fs4] = audioread('TinHieuHuanLuyen-16k/06FTB.wav');
    frameSizeFTB = floor(t_frame * Fs4);
    nFrameFTB = floor(length(x4) / frameSizeFTB);
    steFTB = STE(x4, nFrameFTB, frameSizeFTB);
    
    % Sample
    MHB = [0 -1;0.23 1;1.79 -1];
    MSD = [0 -1;0.49 1;0.75 -1;1 1;1.23 -1;1.61 1;1.84 -1;2.01 1;2.29 -1;2.63 1;2.84 -1];
    FFH = [0 -1;1.86 1;1.26 -1;1.85 1;2.2 -1;3.01 1;3.34 -1;4.04 1;4.4 -1;4.74 1;5.05 -1];
    FTB = [0 -1;0.99 1;1.32 -1;2.21 1;2.55 -1;3.29 1;3.63 -1;4.61 1;4.97 -1;5.75 1;6.06 -1];
    
    vMHB = VoiceStatistic(MHB, nFrameMHB, t_frame);
    vMSD = VoiceStatistic(MSD, nFrameMSD, t_frame);
    vFFH = VoiceStatistic(FFH, nFrameFFH, t_frame);
    vFTB = VoiceStatistic(FTB, nFrameFTB, t_frame);
    
    % Normalize
    steMHB = steMHB / max(abs(steMHB));
    steMSD = steMSD / max(abs(steMSD));
    steFFH = steFFH / max(abs(steFFH));
    steFTB = steFTB / max(abs(steFTB));
    
    silence_count = 0;
    voiceStatistic = [vMHB, vMSD, vFFH, vFTB];
    for i = 1:length(voiceStatistic)
        if (voiceStatistic(i) ~= 1)
            silence_count = silence_count + 1;
        end
    end
    
    % Calculate attribute function average
    silenceValue_average = 0;
    for i=1:length(vMHB)
        if (vMHB(i) ~= 1)
            silenceValue_average = silenceValue_average + steMHB(i);
        end
    end

    for i=1:length(vMSD)
        if (vMSD(i) ~= 1)
            silenceValue_average = silenceValue_average + steMSD(i);
        end
    end
    
    for i=1:length(vFFH)
        if (vFFH(i) ~= 1)
            silenceValue_average = silenceValue_average + steFFH(i);
        end
    end
    
    for i=1:length(vFTB)
        if (vFTB(i) ~= 1)
            silenceValue_average = silenceValue_average + steFTB(i);
        end
    end

    silenceValue_average = silenceValue_average / silence_count;
    
    sSilence = 0;
    for i=1:length(steMHB)
        if (vMHB(i) ~= 1)
            sSilence = sSilence + (steMHB(i) - silenceValue_average)^2;
        end
    end
    for i=1:length(steMSD)
        if (vMSD(i) ~= 1)
            sSilence = sSilence + (steMSD(i) - silenceValue_average)^2;
        end
    end
    for i=1:length(steFFH)
        if (vFFH(i) ~= 1)
            sSilence = sSilence + (steFFH(i) - silenceValue_average)^2;
        end
    end
    for i=1:length(steFTB)
        if (vFTB(i) ~= 1)
            sSilence = sSilence + (steFTB(i) - silenceValue_average)^2;
        end
    end
    
    sSilence = sqrt(sSilence / (silence_count - 1));
    silenceEpsilon = (1.645 * sSilence) / sqrt(silence_count);
    silenceThreshold = silenceValue_average + silenceEpsilon;
end


