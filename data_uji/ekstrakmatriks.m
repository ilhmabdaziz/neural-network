



for n = 1:105
    Img = imread(strcat('',(strcat(num2str(n),'.jpg'))));
    N = imresize (Img,[20 20]);
    I = rgb2gray(N);
    Nmtx = reshape (I,400,1);
    Imtx = im2double(Nmtx);
    data_uji(:,n) = Imtx;
    save data_uji.mat data_uji
end

   
   