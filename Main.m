RootFolder = 'NguyenAmHuanLuyen-16k';
Folder = ['01MDA', '02FVA', '03MAB', '04MHB', '05MVB', '06FTB', '07FTC', '08MLD', '09MPD', '10MSD', '11MVD', '12FTD', '14FHH', '15MMH', '16FTH', '17MTH', '18MNK', '19MXK','20MVK', '21MTL', '22MHL' ];
Vowels = ['a', 'e', 'i', 'o', 'u'];

RootFolderTest = 'NguyenAmKiemThu-16k';
FolderTest = ['23MTL','24FTL', '25MLM', '27MCM', '28MVN', '29MHN', '30FTN', '32MTP','33MHP', '34MQP', '35MMQ', '36MAQ', '37MDS', '38MDS', '39MTS', '40MHS', '41MVS', '42FQT', '43MNT', '44MTT', '45MDV'];

color = ['g', 'b', 'r', 'm', 'k'];

N_FFT = [512, 1024, 2048];
K = [2, 3, 4, 5];
N_MFCC = [13, 26, 39];

confusionMatrixFFT = zeros(5, 5);
confusionMatrixMFCC = zeros(5, 5);
confusionMatrixMFCC_Mean = zeros(5, 5);

highestRatioFFT = 0;
highestRatioMFCC = 0;
highestRatioMFCC_Mean = 0;

ratioFFT = zeros(1, 3);
ratioMFCC = zeros(1, 3);
ratioMFCCMean = zeros(1, 4);

resultFFT = zeros(21 * 3, 5);
resultMFCCMean = zeros(21 * 4, 5);
figure(1);
for i = 1:length(N_FFT)
    % cm: confusion matrix
    dbFFT = FftOfFiveVowel(N_FFT(i));
    [cmFFT, ratio, result] = GetRatioAndConfusionMatrix(RootFolderTest, FolderTest, Vowels, N_FFT(i), dbFFT, 'FFT');
    ratioFFT(i) = ratio;
    resultFFT((i - 1) * 21 + 1:i * 21,:) = result;
    if (ratio > highestRatioFFT)
        confusionMatrixFFT = cmFFT;
        highestRatioFFT = ratio;
    end
    subplot(length(N_FFT), 1, i);
    for j = 1:5
        plot(dbFFT(j,:),color(j));
        hold on;
    end

    title(['Vector dac trung FFT bieu dien 5 nguyen am (NFFT = ' num2str(N_FFT(i)) ')']);
    legend('A','E','I','O','U');
end
disp(' ');
disp('Ket qua nhan dang FFT');
disp('FileName         512       1024     2048');
for m = 1:21
    for n = 1:5
        FilePath = [FolderTest((m-1)*5+1 : m*5) '/'  Vowels(n) '.wav'];
        resultFFT_512 = 'FALSE';
        resultFFT_1024 = 'FALSE';
        resultFFT_2048 = 'FALSE';
        if (resultFFT(m, n) == 1)
            resultFFT_512 = 'TRUE ';
        end
        if (resultFFT(21 + m, n) == 1)
            resultFFT_1024 = 'TRUE ';
        end
        if (resultFFT(21*2 + m, n) == 1)
            resultFFT_2048 = 'TRUE ';
        end
        disp([FilePath '      ' resultFFT_512 '     ' resultFFT_1024 '    ' resultFFT_2048]);
    end
end

figure(2);
for i = 1:length(N_MFCC)
    % cm: confusion matrix
    dbMFCC = MFCCofFiveVowel(N_MFCC(i));
    [cmMFCC, ratio] = GetRatioAndConfusionMatrix(RootFolderTest, FolderTest, Vowels, N_MFCC(i), dbMFCC, 'MFCC');
    ratioMFCC(i) = ratio;
    if (ratio > highestRatioMFCC)
        confusionMatrixMFCC = cmMFCC;
        highestRatioMFCC = ratio;
    end
    subplot(length(N_MFCC), 1, i);
    for j = 1:5
        plot(dbMFCC(j,:),color(j));
        hold on;
    end
    title(['Vector dac trung MFCC bieu dien 5 nguyen am (N = ' num2str(N_MFCC(i)) ')']);
    legend('A','E','I','O','U');
end

figure(3);
for i = 1:length(K)
    % cm: confusion matrix
    dbMFCCKmean = MFCCKMeanOfFiveVowel(N_MFCC(1), K(i));
    [cmMFCCMean, ratio, result] = GetRatioAndConfusionMatrix(RootFolderTest, FolderTest, Vowels, N_MFCC(1), dbMFCCKmean, 'MFCC_Kmean', K(i));
    ratioMFCCMean(i) = ratio;
    resultMFCCMean((i - 1) * 21 + 1:i * 21,:) = result;
    if (ratio > highestRatioMFCC_Mean)
        confusionMatrixMFCC_Mean = cmMFCCMean;
        highestRatioMFCC_Mean = ratio;
    end
    subplot(length(K), 1, i);
    k = 1;
    for j = 1:K(i):5*K(i)
        plot(dbMFCCKmean(j,:),color(k));
        k = k + 1;
        hold on;
    end
    title(['Vector dac trung MFCC bieu dien 5 nguyen am voi (N_MFCC = ' num2str(N_MFCC(1)) ', K = ' num2str(K(i)) ')']);
    legend('A','E','I','O','U');
end
disp(' ');
disp('Ket qua nhan dang MFCC phan cum');
disp('FileName         2         3        4         5');
for m = 1:21
    for n = 1:5
        FilePath = [FolderTest((m-1)*5+1 : m*5) '/'  Vowels(n) '.wav'];
        resultMFCC_2 = 'FALSE';
        resultMFCC_3 = 'FALSE';
        resultMFCC_4 = 'FALSE';
        resultMFCC_5 = 'FALSE';
        if (resultMFCCMean(m, n) == 1)
            resultMFCC_2 = 'TRUE ';
        end
        if (resultMFCCMean(21 + m, n) == 1)
            resultMFCC_3 = 'TRUE ';
        end
        if (resultMFCCMean(21*2 + m, n) == 1)
            resultMFCC_4 = 'TRUE ';
        end
        if (resultMFCCMean(21*3 + m, n) == 1)
            resultMFCC_5 = 'TRUE ';
        end
        disp([FilePath '      ' resultMFCC_2 '     ' resultMFCC_3 '    ' resultMFCC_4 '    ' resultMFCC_5]);
    end
end

disp(' ');
disp('Thong ke FFT');
disp('N_FFT     512          1024         2048');
disp(['Ratio     ' num2str(ratioFFT)]);
disp(' ');
disp('Thong ke MFCC');
disp('N_MFCC   512          1024         2048');
disp(['Ratio     ' num2str(ratioMFCC)]);

disp(' ');
disp('Thong ke MFCC (N_MFCC = 13)');
disp('K         2              3            4            5');
disp(['Ratio     ' num2str(ratioMFCCMean)]);

disp(' ');
disp('Ma tran nham lan FFT');
disp(['    ' Vowels(1) '   ' Vowels(2) '   ' Vowels(3) '   ' Vowels(4) '   ' Vowels(5) ]);
disp([Vowels(1) '  ' num2str(confusionMatrixFFT(1,:))]);
disp([Vowels(2) '   ' num2str(confusionMatrixFFT(2,:))]);
disp([Vowels(3) '   ' num2str(confusionMatrixFFT(3,:))]);
disp([Vowels(4) '   ' num2str(confusionMatrixFFT(4,:))]);
disp([Vowels(5) '   ' num2str(confusionMatrixFFT(5,:))]);
disp(['Ratio: ' num2str(highestRatioFFT) '%']);
disp(' ');
disp('Ma tran nham lan MFCC');
disp(['    ' Vowels(1) '   ' Vowels(2) '   ' Vowels(3) '   ' Vowels(4) '   ' Vowels(5) ]);
disp([Vowels(1) '  ' num2str(confusionMatrixMFCC(1,:))]);
disp([Vowels(2) '   ' num2str(confusionMatrixMFCC(2,:))]);
disp([Vowels(3) '   ' num2str(confusionMatrixMFCC(3,:))]);
disp([Vowels(4) '   ' num2str(confusionMatrixMFCC(4,:))]);
disp([Vowels(5) '   ' num2str(confusionMatrixMFCC(5,:))]);
disp(['Ratio: ' num2str(highestRatioMFCC) '%']);

disp(' ');
disp('Ma tran nham lan MFCC KMean');
disp(['    ' Vowels(1) '   ' Vowels(2) '   ' Vowels(3) '   ' Vowels(4) '   ' Vowels(5) ]);
disp([Vowels(1) '  ' num2str(confusionMatrixMFCC_Mean(1,:))]);
disp([Vowels(2) '   ' num2str(confusionMatrixMFCC_Mean(2,:))]);
disp([Vowels(3) '   ' num2str(confusionMatrixMFCC_Mean(3,:))]);
disp([Vowels(4) '   ' num2str(confusionMatrixMFCC_Mean(4,:))]);
disp([Vowels(5) '   ' num2str(confusionMatrixMFCC_Mean(5,:))]);
disp(['Ratio: ' num2str(highestRatioMFCC_Mean) '%']);
  

maxFFTTrue = 0; maxFFTFalse = 0;
maxMFCCTrue = 0; maxMFCCFalse = 0;
maxMFCC_MEANTrue = 0; maxMFCC_MEANFalse = 0;
for i = 1:5
    for j = 1 : 5
        if(i == j )
            if(confusionMatrixFFT(i,i) > maxFFTTrue)
                maxFFTTrue = confusionMatrixFFT(i,i);
            end
            if(confusionMatrixMFCC(i,i) > maxMFCCTrue)
                maxMFCCTrue = confusionMatrixMFCC(i,i);
            end
            if(confusionMatrixMFCC_Mean(i,i) > maxMFCC_MEANTrue)
                maxMFCC_MEANTrue = confusionMatrixMFCC_Mean(i,i);
            end
        else
            if(confusionMatrixFFT(i,j) > maxFFTFalse)
                maxFFTFalse = confusionMatrixFFT(i,j);
            end
            if(confusionMatrixMFCC(i,j) > maxMFCCFalse)
                maxMFCCFalse = confusionMatrixMFCC(i,j);
            end
            if(confusionMatrixMFCC_Mean(i,j) > maxMFCC_MEANFalse)
                maxMFCC_MEANFalse = confusionMatrixMFCC_Mean(i,j);
            end
        end
    end
end
    
% columnName =   {'a','e','u', 'o', 'u'};
% rowName = {'a','e','u', 'o', 'u'};
% fig4 = figure(4);
% title('Ma tran nham lan FFT');
% table1 = uitable(fig4, 'Data', confusionMatrixFFT, 'Position' , [10 10 520 380],'ColumnWidth', {80}, 'ColumnName', columnName, 'RowName', rowName);
% fig5 = figure(5);
% title('Ma tran nham lan MFCC');
% table2 = uitable(fig5, 'Data', confusionMatrixMFCC,'Position' , [10 10 520 380],'ColumnWidth', {80}, 'ColumnName', columnName, 'RowName', rowName);
% fig6 = figure(6);
% title('Ma tran nham lan MFCC-MEAN');
% table3 = uitable(fig6, 'Data', confusionMatrixMFCC_Mean,'Position' , [10 10 520 380],'ColumnWidth', {80},'ColumnName', columnName, 'RowName', rowName);
%     
    %maxFFTTrue = strcat(['<html><body bgcolor="' clr '" text="#FF0000" width="100px">'], maxFFTTrue);