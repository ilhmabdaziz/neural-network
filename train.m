%% dimensi dan accuracy iterasi:1000
% iterasi 300 dimensi bobot 30x30

% 50x50 / 75x75 accuracy data_train: 100%
% 50x50 / 75x75 accuracy data_test: 69.523810%
% 40x40 accuracy data_train: 100%. kalau iterasi 100 accuracy: 99.047619
% 40x40 accuracy data_test: 68.571429%.kalau iterasi 100 accuracy: 62.85
% 35x35 accuracy data_train: 100%
% 35x35 accuracy data_test: 68.571429%
% 30x30 accuracy data_train: 100%
% 30x30 accuracy data_test: 70.476190%
% 25x25 accuracy data_train: 100%
% 25x25 accuracy data_test: 68.571429%
% 20x20 accuracy data_train: 98.095238%
% 20x20 accuracy data_test: 70.476190% 
% 15x15 accuracy data_train: 62.857143%
% 15x15 accuracy data_test: 41.904762%
% 10x10 accuracy data_train: 36.190476%
% 10x10 accuracy data_test: 31.428571%
% 5x5   accuracy data_train: 32.380952%
% 5x5   accuracy data_test: 30.476190%
% 2x2   accuracy data_train: 13.333333%
% 2x2   accuracy data_test: 13.3333333%

clear all;
clc;
hold off;
%% ini train
%% #### harus belajar : (exp,log,norm) 
%% ini contoh untuk 1 iterasi yang di komentari
%% Load data
% load SOM_database.mat;
load data_latih;
load group.mat;
% Attributes:
% train_data: training data, 320x225 matrix 
% train_classlabel: the labels of the training data, 1x225 vector 
% train_classcount: no of training images for each alphabet 
% test_data: test data, 320x90 matrix 
% test_classlabel: the labels of the testing data, 1x90 vector 
% test_classcount: no of test images for each alphabet

% You may view an alphabet using the code below:
% tmp=reshape(train_data(:,2),20,16);
% imshow(train_data);

%% Variables concerning data set
img_size = [20 20];
% Have 10 x 10 neurons. Each neuron will have a 20 x 16 weight matrix.
% This weight matrix is reshaped to a 320 x 1 weight vector for
% convenience.
lattice_num_rows = 30; lattice_num_cols = 30;
min_val_in_train_data = min(data_latih(:));
max_val_in_train_data = max(data_latih(:));
% Number of images in training data set:
num_training_input_vector = size(data_latih,2);
%% SOM Training

% No. of training iterations:
num_epoch = 300;
% Learning rate:
learning_rate_0 = 0.1;
learning_rate = @(epoch) learning_rate_0 * exp(-epoch / num_epoch);
% Sigma of neighbourhood function:
sigma_0 = norm([lattice_num_rows, lattice_num_cols]) / 2; %sqrt(800)/2 %%20^2=400 20^2=400 400+400 = 800 sqrt(800)=28.2843/2 = 14.1421
tau_1 = num_epoch / log(sigma_0); %1/log(14.1421) = 0.3775
sigma = @(epoch) sigma_0 * exp (-epoch / tau_1);
% Neighbourhood function:
% r1, c1, r2, c2 means row of neuron 1, col of neuron 1, row of neuron 2,
% col of neuron 2 respectively.
neighbourhood_func =  @(r1, c1, r2, c2, epoch) exp( -(norm([r1 c1] - [r2 c2],2)^2) / (2 * sigma(epoch)^2) );

% 1. Randomly initialize weights with upper and lower bounds taken from train_data.
% 1. Inisialisasi bobot secara acak dengan batas atas dan bawah yang diambil dari train_data.
rng(1);
w = rand(lattice_num_rows, lattice_num_cols, img_size(1) * img_size(2)); %rand(20,20,20*20) = rand(20,20,400)
w = w * (max_val_in_train_data - min_val_in_train_data) + min_val_in_train_data; % w * (0.9843-0.0510) + 0.0510

for epoch = 1 : num_epoch 
    fprintf('Now at iteration %d out of %d.\n', epoch, num_epoch);
    for img_idx = randperm(num_training_input_vector) % randperm(105) atau img_idx = ...
        % 2. Choose an image from train_data.
        % 2. Pilih gambar dari train_data.
        img = data_latih(:,img_idx); %ambil satu vector dari data_latih
        % 3. Determine winner neuron. Winner neuron is neuron that is closest to training image.
        % 3. Tentukan neuron pemenang. Neuron pemenang adalah neuron yang paling dekat dengan citra latihan.
        winner_r = -1; winner_c = -1; %init.
        min_dist = inf; % init
        for r = 1 : lattice_num_rows % 1 : 20
            for c = 1 : lattice_num_cols % 1 : 20
                dist = norm(shiftdim(w(r,c,:))-img); % shiftdim(w(r,c,:)) = bobot baris kolom r c 1:400 di shiftdim lalu di kurang vektor img , hasilnya di normkan
                if (dist < min_dist)
                    min_dist = dist;
                    winner_r = r; winner_c = c;
                end
            end
        end % END finding winner neuron.
        %4. Update weight vectors in lattice using neighbourhood func.
        %4. Perbarui vektor bobot dalam kisi menggunakan fungsi lingkungan.
        for r = 1 : lattice_num_rows % 1 : 20
            for c = 1: lattice_num_cols % 1 : 20
                w(r,c,:) = w(r,c,:) + learning_rate(epoch) * neighbourhood_func(r,c,winner_r,winner_c,epoch) * (shiftdim(img,-2) - w(r,c,:));  %pembaruan bobot wij'=wij+learningrate[xi-wij]
            end
        end % END updating neighbouring neurons.
    end % END foreach image in train_data.
end % END iterations.
    save w.mat w
% Label the neurons (in the lattice).  A neuron is labelled with the label of 
% the input vector in the training set closest to it.
neuron_labels = cell(lattice_num_rows, lattice_num_cols); % cell(20,20)
for r = 1 : lattice_num_rows % r = 1 : 20
    for c = 1 : lattice_num_cols %c = 1 : 20
        closest_img_idx = -1; %init
        min_dist = inf; %init
        for img_idx = 1 : num_training_input_vector % 1 : 105
            img = data_latih(:,img_idx); % 400x1
            dist = norm(img - shiftdim(w(r,c,:))); % (1)400x1 - (1)400-1 % (2)400x1 - (1)400x1 ...... % (105)-(1)
            if (dist < min_dist)
                closest_img_idx = img_idx; % mencari closest_img_idx dengan dist paling kecil
                min_dist = dist;
            end
        end % END Found input vector in train_data that is closest to w(r,c,:).
        closest_label = lah(closest_img_idx); % mengambil dari lah(group(105))
        neuron_labels(r,c) = closest_label; % melabelkan r c dari lah(group)
    end
end % END finished labelling.
    save neuron_train.mat neuron_labels

%% Print out labels of SOM.
% display(neuron_labels);
