clear all
close all
%%load Data

load('trainingSamplesDCT_8.mat');
zig_zag = load('Zig-Zag Pattern.txt');
zig_zag= zig_zag+1;
cheetah = im2double(imread('cheetah.bmp'));
cheetah_mask = imread('cheetah_mask.bmp');
cheetah_mask = cheetah_mask == 255;% create a mask for cheetah
%% Part A
size_BG = size(TrainsampleDCT_BG);%size of backgroung array

size_FG = size(TrainsampleDCT_FG);%size of forgroung array

total_samples= size_BG(1,1)+size_FG(1,1);%total size of samples

pp_FG = size_FG(1,1)/total_samples; %prior probability of forground
pp_BG = size_BG(1,1)/total_samples; %prior probability of Background



%% Part B

[sort_BG,index_BG_sorted] = sort(abs(TrainsampleDCT_BG),2,'descend');%sorted row of background
[sort_FG,index_FG_sorted] = sort(abs(TrainsampleDCT_FG),2,'descend');%sorted row of forground

% Histogram of P_x|Grass
figure(1)
temp_BG_histogram = histogram(index_BG_sorted(:,2),64,'BinLimits',[1,64],'Normalization','probability');
title('P_{X|Y}(x|Grass)')
% Histogram of P_x|cheetah
figure(2)
temp_FG_histogram = histogram(index_FG_sorted(:,2),64,'BinLimits',[1,64],'Normalization','probability');
title('P_{X|Y}(X|Cheetah)')
P_X_cheetah = temp_FG_histogram.Values; % P_x|cheetah
P_X_grass = temp_BG_histogram.Values; % P_x|Grass

%% Part C

padded_cheetah = padarray(cheetah,[7 7],'both');% zero pad the original image
size_cheetah =size(cheetah);
A = zeros(size_cheetah);% empty classified array
for i = 7:size_cheetah(1,1)+6
    for j = 7:size_cheetah(1,2)+6
       
        dct_sec = dct2(padded_cheetah(i:i+7,j:j+7));
        v(zig_zag(:))= abs(dct_sec(:));%vectorize dct_sec
        [dct_sec_sort index] = sort(v,2,'descend');
        
        p_chetah_x = log(P_X_cheetah(index(1,2))) +log(pp_FG);
        p_grass_x = log(P_X_grass(index(1,2))) + log(pp_BG);
        
        A(i-6,j-6) = p_grass_x <p_chetah_x;
   
        
        
    end
end

figure(3)
colormap(gray(255));
imshow(A)
hold

mask_zero = find(~cheetah_mask);

mask_wrong_zero = sum(A(mask_zero)== 1);


mask_one = find(cheetah_mask);

mask_wrong_one = sum(A(mask_one) == 0);


p_error = (mask_wrong_zero*pp_BG)/sum(sum(cheetah_mask == 0)) + (mask_wrong_one * pp_FG)/sum(sum(cheetah_mask == 1)) ;

% imagesc(A);
