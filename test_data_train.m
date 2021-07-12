clear all; hold off;
%% ini data train
%% #### toleransi data latih dan data uji ####
%% Load data
% load SOM_database.mat;
load data_latih; % data uji 400x105
load group; % label yang akan di test
load w.mat; % bobot dari train
load neuron_train; % neuron_labels dari train
% load 'som_wts_1.mat'; % loads into w
% load 'som_labels_1.mat'; % loads into neuron_labels
%% Test SOM:
num_test_data = size(data_latih,2);
correct = 0; %init
for i = 1 : num_test_data
    input = data_latih(:,i); % input vektor 400x1
    test_label = char(lah(i)); % mengambil test label dari group
    % Find winner neuron
    min_dist = inf;
    winner_r = -1; winner_c = -1;
    for r = 1 : size(w,1) % 1 : 20
        for c = 1 : size(w,2) % 1 : 20
            dist = norm(input - shiftdim(w(r,c,:))); % input - shiftdim dari bobot r c 1:400 lalu di norm
            if (dist < min_dist)
                min_dist = dist; % mencari dist terkecil untuk menjadi min_dist
                winner_r = r; winner_c = c;
            end
        end
    end % END winner neuron found.
    output_label = char(neuron_labels(winner_r,winner_c)); % mengambil cluster dari neuron_label train(r = baris c = kolom) 
    % compare output label with test label.
    fprintf('output:%s ',output_label); % keluaran output_label
    fprintf('testlabel:%s ',test_label);
    if(output_label == test_label)
        fprintf ('CORRECT!\n');
        correct = correct + 1;
    else
        fprintf('WRONG!\n');
    end
end
accuracy = correct / num_test_data*100;
fprintf('Out of %d test data, %d were correctly classified.\n', num_test_data, correct);
fprintf('Accuracy: %f\n', accuracy);