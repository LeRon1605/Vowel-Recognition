function [confusionMatrix, ratio, result] = GetRatioAndConfusionMatrix(RootFolder, Folder, Vowels, N, db, Mode, KMean)
    
    confusionMatrix = zeros(5, 5);   
    countTrue = 0;
    result = zeros(21, 5);

    for i = 1:5
        for j = 1:21
            FilePath = [RootFolder '/' Folder((j-1)*5+1 : j*5) '/'  Vowels(i) '.wav'];
            
            if (strcmp(Mode, 'FFT'))
                c_vector = mean(FftOfVowel(FilePath , N));
            else
                c_vector = mean(MFCCofVowel(FilePath, N));
            end
            
            if (strcmp(Mode, 'MFCC_Kmean'))
                vowel = DecisionKMean(c_vector, db, KMean);
            else
                vowel = Decision(c_vector, db);
            end

            if (strcmp(vowel, Vowels(i)))
                countTrue = countTrue + 1;
                confusionMatrix(i, i) = confusionMatrix(i, i) + 1;
                result(j, i) = 1;
            else
                [value, index] = find(Vowels == vowel);
                confusionMatrix(i, index) = confusionMatrix(i, index) + 1;
                result(j, i) = 0;
            end
        end  
    end
    
    ratio = (countTrue * 100)/(21 * 5);
end

