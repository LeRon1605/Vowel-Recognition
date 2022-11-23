function [ Result ] = MFCCofFiveVowel(N)
    RootFolder = 'NguyenAmHuanLuyen-16k';
    Folder = ['01MDA', '02FVA', '03MAB', '04MHB', '05MVB', '06FTB', '07FTC', '08MLD', '09MPD', '10MSD', '11MVD', '12FTD', '14FHH', '15MMH', '16FTH', '17MTH', '18MNK', '19MXK','20MVK', '21MTL', '22MHL' ];
    Vowels = ['a', 'e', 'i', 'o', 'u'];

    Result = zeros(5, N);
    for i = 1 : 5
        MFCCofOneVowel = [];
        for j = 1 : 21
            FilePath = [RootFolder '/' Folder((j-1)*5+1 : j*5) '/'  Vowels(i) '.wav'];
            MFCC_MEAN = mean(MFCCofVowel(FilePath, N));
            MFCCofOneVowel = cat(1, MFCCofOneVowel, MFCC_MEAN);
        end
        Result(i,:) =  mean(MFCCofOneVowel, 1);  
    end
end

