function [ SampleArr ] = SplitSample(StableSignal, Fs, t_frame)
    tFrameShift = 0.01;
    t = length(StableSignal) / Fs;
    frameSize = t_frame * Fs;
    totalFrame = 1 + floor((t - t_frame)/(tFrameShift));
    SampleArr = zeros(totalFrame, frameSize);
    
    shiftElement = tFrameShift * Fs;
    left = 1;
    right = frameSize;
    for i = 1:totalFrame
        SampleArr(i,:) = StableSignal(left:right);
        left = left + shiftElement;
        right = left + frameSize - 1;
    end
end

