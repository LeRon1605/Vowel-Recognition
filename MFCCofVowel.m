function [ MFCC ] = MFCCofVowel(FileAudio, N)
    [x, Fs] = audioread(FileAudio);
    t_frame = 0.02;
    t_frameShift = 0.01;
    frameSize = t_frame * Fs;
    [leftVowel, rightVowel] = Vowel(x, Fs, t_frame);
    [leftStable, rightStable] = StableSignal(leftVowel, rightVowel);
    stable = x(leftStable * frameSize:rightStable * frameSize);
    sampleArr = SplitSample(stable, Fs, t_frame);
    
    MFCC = zeros(size(sampleArr, 1), N);
    for i = 1:size(sampleArr, 1)
        MFCC(i,:) = v_melcepst(sampleArr(i,:), Fs, 'm', N, floor(3 * log(Fs)), t_frame * Fs, t_frameShift * Fs);
    end
end

