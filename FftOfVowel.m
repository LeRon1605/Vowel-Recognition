function [ FFT ] = FftOfVowel(FileAudio, N_FFT)
    [x, Fs] = audioread(FileAudio);
    t_frame = 0.02;
    frameSize = t_frame * Fs;
    [leftVowel, rightVowel] = Vowel(x, Fs, t_frame); 
    [leftStable, rightStable] = StableSignal(leftVowel, rightVowel);
    stable = x(leftStable * frameSize:rightStable * frameSize);
    sampleArr = SplitSample(stable, Fs, t_frame);
    FFT = zeros(size(sampleArr, 1), N_FFT / 2);

    for i = 1:size(sampleArr, 1)
        frameLength = length(sampleArr(i,:));
        frame_unv = hamming(frameLength).*sampleArr(i,:)';
        temp = abs(fft(frame_unv, N_FFT));
        FFT(i,:) = temp(1:N_FFT / 2);
    end
end