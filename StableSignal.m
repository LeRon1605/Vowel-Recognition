function [left, right] = StableSignal(leftVowel, rightVowel)
    length = rightVowel - leftVowel;
    frameLength = floor(length / 3);
    left = leftVowel + frameLength;
    right = rightVowel - frameLength;
%     signal = vowel(startTime:endTime);
end

