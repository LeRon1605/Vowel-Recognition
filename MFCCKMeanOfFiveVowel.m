function [ Result ] = MFCCKMeanOfFiveVowel(N_MFCC, k)
    RootFolder = 'NguyenAmHuanLuyen-16k';
    Folder = ['01MDA', '02FVA', '03MAB', '04MHB', '05MVB', '06FTB', '07FTC', '08MLD', '09MPD', '10MSD', '11MVD', '12FTD', '14FHH', '15MMH', '16FTH', '17MTH', '18MNK', '19MXK','20MVK', '21MTL', '22MHL' ];
    Vowels = ['a', 'e', 'i', 'o', 'u'];
    
    Result = zeros(5 * k, N_MFCC);
    for i = 1 : 5
        MFCCofOneVowel = [];
        for j = 1 : 21
            FilePath = [RootFolder '/' Folder((j-1)*5+1 : j*5) '/'  Vowels(i) '.wav'];
            MFCC = MFCCofVowel(FilePath, N_MFCC);
            MFCCofOneVowel = cat(1, MFCCofOneVowel, MFCC);
        end
        Result(k*(i-1)+1:k*i,:) = v_kmeans(MFCCofOneVowel, k);
    end
end

