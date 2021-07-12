clear all; hold off;
%% ini data test
%% #### toleransi data latih dan data uji ####
%% Load data
% load SOM_database.mat;
load cluster_output;
load kelas;
load data_latih;
load data_uji; % data uji 400x105
load group_test; % label yang akan di test
load w.mat; % bobot dari train
load neuron_train; % neuron_labels dari train
% load 'som_wts_1.mat'; % loads into w
% load 'som_labels_1.mat'; % loads into neuron_labels
%% Test SOM:
num_test_data = size(data_uji,2); % 105
correct = 0; %init
table = cell(1,size(data_uji,2));
for i = 1 : num_test_data
    input = data_uji(:,i); % input vektor 400x1
    test_label = char(lah(i)); % mengambil test label dari group ('1')
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
    %output_label = char(neuron_labels(winner_r,winner_c)); % mengambil cluster dari neuron_label train(r = baris c = kolom) 
    closest_table = neuron_labels(winner_r,winner_c);
    table (i)= closest_table;
    if min_dist <= 3.1
        output_label = char(neuron_labels(winner_r,winner_c)); % mengambil cluster dari neuron_label train(r = baris c = kolom) 
        
    if (output_label == test_label)
        fprintf('output:%s ',output_label); % keluaran output_label
        fprintf('testlabel:%s ',test_label);
        fprintf ('CORRECT!\n');
        correct = correct + 1;
    elseif (output_label ~= test_label)
        fprintf('output:%s ',output_label); % keluaran output_label
        fprintf('testlabel:%s ',test_label);
        fprintf ('WRONG!\n');
    end
    else
        fprintf('output:%s ',output_label); % keluaran output_label
        fprintf('testlabel:%s ',test_label); 
        fprintf('TIDAK DIKENAL!\n'); 
    end
%     % compare output label with test label.
%     fprintf('output:%s ',output_label); % keluaran output_label
%     fprintf('testlabel:%s ',test_label);
%     if(output_label == test_label)
%         fprintf ('CORRECT!\n');
%         correct = correct + 1;
%     else
%         fprintf('WRONG!\n');
%     end
%     for t = 1 : i
%         closest_table = output_label;
%         table = closest_table;
%     end
end
    
accuracy = correct / num_test_data*100;
fprintf('Out of %d test data, %d were correctly classified.\n', num_test_data, correct);
fprintf('Accuracy: %f\n\n', accuracy);


% % for n = 1 : 105
%     kelas1 = data_latih(:,1:15);
%     aseman = (kelas1(:,1)+kelas1(:,2)+kelas1(:,3)+kelas1(:,4)+kelas1(:,5)+kelas1(:,6)+kelas1(:,7)+kelas1(:,8)+kelas1(:,9)+kelas1(:,10)+kelas1(:,11)+kelas1(:,12)+kelas1(:,13)+kelas1(:,14)+kelas1(:,15))/15;
%     cluster_latih(:,1) = aseman;
%     save cluster_latih.mat cluster_latih
%     
%     kelas2 = data_latih(:,16:30);
%     bledak = (kelas2(:,1)+kelas2(:,2)+kelas2(:,3)+kelas2(:,4)+kelas2(:,5)+kelas2(:,6)+kelas2(:,7)+kelas2(:,8)+kelas2(:,9)+kelas2(:,10)+kelas2(:,11)+kelas2(:,12)+kelas2(:,13)+kelas2(:,14)+kelas2(:,15))/15;
%     cluster_latih(:,2) = bledak;
%     save cluster_latih.mat cluster_latih
%     
%     kelas3 = data_latih(:,31:45);
%     gunung_ringgit = (kelas3(:,1)+kelas3(:,2)+kelas3(:,3)+kelas3(:,4)+kelas3(:,5)+kelas3(:,6)+kelas3(:,7)+kelas3(:,8)+kelas3(:,9)+kelas3(:,10)+kelas3(:,11)+kelas3(:,12)+kelas3(:,13)+kelas3(:,14)+kelas3(:,15))/15;
%     cluster_latih(:,3) = gunung_ringgit;
%     save cluster_latih.mat cluster_latih
%     
%     kelas4 = data_latih(:,46:60);
%     krecak = (kelas4(:,1)+kelas4(:,2)+kelas4(:,3)+kelas4(:,4)+kelas4(:,5)+kelas4(:,6)+kelas4(:,7)+kelas4(:,8)+kelas4(:,9)+kelas4(:,10)+kelas4(:,11)+kelas4(:,12)+kelas4(:,13)+kelas4(:,14)+kelas4(:,15))/15;
%     cluster_latih(:,4) = krecak;
%     save cluster_latih.mat cluster_latih
%     
%     kelas5 = data_latih(:,61:75);
%     latohan = (kelas5(:,1)+kelas5(:,2)+kelas5(:,3)+kelas5(:,4)+kelas5(:,5)+kelas5(:,6)+kelas5(:,7)+kelas5(:,8)+kelas5(:,9)+kelas5(:,10)+kelas5(:,11)+kelas5(:,12)+kelas5(:,13)+kelas5(:,14)+kelas5(:,15))/15;
%     cluster_latih(:,5) = latohan;
%     save cluster_latih.mat cluster_latih
%     
%     kelas6 = data_latih(:,76:90);
%     tumpal = (kelas6(:,1)+kelas6(:,2)+kelas6(:,3)+kelas6(:,4)+kelas6(:,5)+kelas6(:,6)+kelas6(:,7)+kelas6(:,8)+kelas6(:,9)+kelas6(:,10)+kelas6(:,11)+kelas6(:,12)+kelas6(:,13)+kelas6(:,14)+kelas6(:,15))/15;
%     cluster_latih(:,6) = tumpal;
%     save cluster_latih.mat cluster_latih
%     
%     kelas7 = data_latih(:,91:105);
%     sekar_jagat = (kelas7(:,1)+kelas7(:,2)+kelas7(:,3)+kelas7(:,4)+kelas7(:,5)+kelas7(:,6)+kelas7(:,7)+kelas7(:,8)+kelas7(:,9)+kelas7(:,10)+kelas7(:,11)+kelas7(:,12)+kelas7(:,13)+kelas7(:,14)+kelas7(:,15))/15;
%     cluster_latih(:,7) = sekar_jagat;
%     save cluster_latih.mat cluster_latih
   
    
% end




% a = 1 : 15
% cluster1 = data_latih(:,a);

% for aa = 1 : 15
%     img = cluster1(:,aa)
%     tampung = img;
% end 
% aseman = mean(cluster1);
% coba = aseman(1)+aseman(2)+aseman(3)+aseman(4)+aseman(5)+aseman(6)+aseman(7)+aseman(8)+aseman(9)+aseman(10)+aseman(11)+aseman(12)+aseman(13)+aseman(14)+aseman(15);
% coba1 = coba/15;

%pakeiniya
% aseman = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;
% coba2 = mean(aseman2);
    

% b = 16 : 30
% cluster2 = data_latih(:,b);
% bledak = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;
% c = 31 : 45
% cluster3 = data_latih(:,c);
% gunung_ringgit = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;
% d = 46 : 60
% cluster4 = data_latih(:,d);
% krecak = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;
% e = 61 : 75
% cluster5 = data_latih(:,e);
% latohan = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;
% f = 76 : 90
% cluster6 = data_latih(:,f);
% tumpal = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;
% g = 91 : 105
% cluster7 = data_latih(:,g);
% sekar_jagat = (cluster1(:,1)+cluster1(:,2)+cluster1(:,3)+cluster1(:,4)+cluster1(:,5)+cluster1(:,6)+cluster1(:,7)+cluster1(:,8)+cluster1(:,9)+cluster1(:,10)+cluster1(:,11)+cluster1(:,12)+cluster1(:,13)+cluster1(:,14)+cluster1(:,15))/15;


% a=cell(1,2);
% for i=1:2
%  a(i)=mat2cell(zeros(8,8,2),8,8,2);
%  a{i}(:,:,1)=randi(8,8);
% end

% % cluster_output = cell(400,size(data_uji,2));
% for k = 1 : size(table,2)
%     if char(table(k)) == ['1']
%         Imtx = data_uji(:,k);
%         cluster_output1(:,k) = Imtx;
%         save cluster_output1.mat cluster_output1
%         
%     elseif char(table(k)) == ['2']
%         Imtx = data_uji(:,k);
%         cluster_output2(:,k) = Imtx;
%         save cluster_output2.mat cluster_output2
%         
%     elseif char(table(k)) == ['3']
%         Imtx = data_uji(:,k);
%         cluster_output3(:,k) = Imtx;
%         save cluster_output3.mat cluster_output3
%         
%     elseif char(table(k)) == ['4']
%         Imtx = data_uji(:,k);
%         cluster_output4(:,k) = Imtx;
%         save cluster_output4.mat cluster_output4
%         
%     elseif char(table(k)) == ['4']
%         Imtx = data_uji(:,k);
%         cluster_output4(:,k) = Imtx;
%         save cluster_output4.mat cluster_output4
%         
%     elseif char(table(k)) == ['5']
%         Imtx = data_uji(:,k);
%         cluster_output5(:,k) = Imtx;
%         save cluster_output5.mat cluster_output5
%         
%     elseif char(table(k)) == ['6']
%         Imtx = data_uji(:,k);
%         cluster_output6(:,k) = Imtx;
%         save cluster_output6.mat cluster_output6
%     
%     elseif char(table(k)) == ['7']
%         Imtx = data_uji(:,k);
%         cluster_output7(:,k) = Imtx;
%         save cluster_output7.mat cluster_output7
%     
%     end
%     
%     
%     
% %     if char(table(k)) == ['1']
% %         output = data_uji(:,k);
% %         cluster_output {1,k} = output;
% %     elseif char(table(k)) == ['2']
% %         output = data_uji(:,k);
% %         cluster_output {2,k} = output;
% %     elseif char(table(k)) == ['3']
% %         output = data_uji(:,k);
% %         cluster_output {3,k} = output;
% %     elseif char(table(k)) == ['4']
% %         output = data_uji(:,k);
% %         cluster_output {4,k} = output; 
% %     elseif char(table(k)) == ['5']
% %         output = data_uji(:,k);
% %         cluster_output {5,k} = output;
% %     elseif char(table(k)) == ['6']
% %         output = data_uji(:,k);
% %         cluster_output {6,k} = output;
% %     elseif char(table(k)) == ['7']
% %         output = data_uji(:,k);
% %         cluster_output {7,k} = output; 
% %     end
%     
%     
% end
% cluster_output1 = cluster_output(1,:);
% rata_cluster_output1 = (cluster_output1{1,1}+cluster_output1{1,2}+cluster_output1{1,3}+cluster_output1{1,4}+cluster_output1{1,5}+cluster_output1{1,6}+cluster_output1{1,7}+cluster_output1{1,10})/8;
% masuk_cluster = 

% load cluster_output1.mat

% hasil = 0;
% for i = 2 : 105
%     hasil = cluster_output1(:,i) + cluster_output1(:,1);
% end

% %% untuk train 20x20
% hasil_cluster1 = (cluster_output1(:,1)+cluster_output1(:,2)+cluster_output1(:,3)+cluster_output1(:,4)+cluster_output1(:,5)+cluster_output1(:,6)+cluster_output1(:,7)+cluster_output1(:,10))/8;
% hasilnya(:,1) = hasil_cluster1;
% save hasilnya.mat hasil_cluster1
% hasil_cluster2 = (cluster_output2(:,16)+cluster_output2(:,17)+cluster_output2(:,18)+cluster_output2(:,19)+cluster_output2(:,20)+cluster_output2(:,21)+cluster_output2(:,22)+cluster_output2(:,28))/8;
% hasilnya(:,2) = hasil_cluster2;
% save hasilnya.mat hasilnya
% hasil_cluster3 = (cluster_output3(:,8)+cluster_output3(:,9)+cluster_output3(:,11)+cluster_output3(:,12)+cluster_output3(:,14)+cluster_output3(:,23)+cluster_output3(:,24)+cluster_output3(:,25)+cluster_output3(:,26)+cluster_output3(:,27)+cluster_output3(:,29)+cluster_output3(:,30)+cluster_output3(:,31)+cluster_output3(:,32)+cluster_output3(:,33)+cluster_output3(:,34)+cluster_output3(:,35)+cluster_output3(:,36)+cluster_output3(:,37)+cluster_output3(:,38)+cluster_output3(:,39)+cluster_output3(:,40)+cluster_output3(:,41)+cluster_output3(:,45)+cluster_output3(:,54)+cluster_output3(:,55)+cluster_output3(:,56)+cluster_output3(:,57)+cluster_output3(:,58)+cluster_output3(:,71)+cluster_output3(:,74)+cluster_output3(:,99)+cluster_output3(:,104))/33;
% hasilnya(:,3) = hasil_cluster3;
% save hasilnya.mat hasilnya
% hasil_cluster4 = (cluster_output4(:,15)+cluster_output4(:,46)+cluster_output4(:,47)+cluster_output4(:,48)+cluster_output4(:,49)+cluster_output4(:,50)+cluster_output4(:,51)+cluster_output4(:,52)+cluster_output4(:,53)+cluster_output4(:,105))/10;
% hasilnya(:,4) = hasil_cluster4;
% save hasilnya.mat hasilnya
% hasil_cluster5 = (cluster_output5(:,42)+cluster_output5(:,61)+cluster_output5(:,62)+cluster_output5(:,63)+cluster_output5(:,64)+cluster_output5(:,65)+cluster_output5(:,66)+cluster_output5(:,67)+cluster_output5(:,68)+cluster_output5(:,69)+cluster_output5(:,70)+cluster_output5(:,72)+cluster_output5(:,73)+cluster_output5(:,100))/14;
% hasilnya(:,5) = hasil_cluster5;
% save hasilnya.mat hasilnya
% hasil_cluster6 = (cluster_output6(:,76)+cluster_output6(:,77)+cluster_output6(:,78)+cluster_output6(:,79)+cluster_output6(:,80)+cluster_output6(:,81)+cluster_output6(:,82)+cluster_output6(:,83)+cluster_output6(:,84)+cluster_output6(:,85)+cluster_output6(:,86)+cluster_output6(:,87)+cluster_output6(:,88)+cluster_output6(:,89)+cluster_output6(:,90))/15;
% hasilnya(:,6) = hasil_cluster6;
% save hasilnya.mat hasilnya
% hasil_cluster7 = (cluster_output7(:,13)+cluster_output7(:,43)+cluster_output7(:,44)+cluster_output7(:,59)+cluster_output7(:,60)+cluster_output7(:,75)+cluster_output7(:,91)+cluster_output7(:,91)+cluster_output7(:,93)+cluster_output7(:,94)+cluster_output7(:,95)+cluster_output7(:,96)+cluster_output7(:,97)+cluster_output7(:,98)+cluster_output7(:,101)+cluster_output7(:,102)+cluster_output7(:,103))/17;
% hasilnya(:,7) = hasil_cluster7;
% save hasilnya.mat hasilnya
% 
% %% coba-coba
% 
% for m = 1 : 7
%     input_hasil = hasilnya(:,m);
%     test_output = char(cluster_output(m));
%     winner_n = 0;
%     min_dist_hasil = inf;
%     for n =  1 : 7
%         dist_hasil = norm(input_hasil - cluster_latih(:,n));
%         if (dist_hasil < min_dist_hasil)
%             min_dist_hasil = dist_hasil;
%             winner_n= n;
%         end
%     end
%     output_hasil = char(kelas(winner_n));
%     
%     fprintf('cluster %s ',test_output);
%     fprintf('kelas:%s \n',output_hasil);
% end


% %% coba
% % hasil 42.85
% for m = 1 : 105
%     input_hasil = data_uji(:,m);
%     test_output = char(lah(m));
%     winner_n = 0;
%     min_dist_hasil = inf;
%     for n =  1 : 7
%         dist_hasil = norm(input_hasil - cluster_latih(:,n));
%         if (dist_hasil < min_dist_hasil)
%             min_dist_hasil = dist_hasil;
%             winner_n= n;
%         end
%     end
%     if min_dist_hasil <=3
%         output_hasil = char(kelas(winner_n));
% 
%         fprintf('cluster %s ',test_output);
%         fprintf('kelas:%s \n',output_hasil);
%     else
%         fprintf('cluster %s ',test_output);
%         fprintf('Kelas_Tidak_diketahui\n');
%     end
% end


% %% coba lagi
% % Test SOM:
% num_test_data = size(data_uji,2); % 105
% betul = 0; %init
% table = cell(1,size(data_uji,2));
% for i = 1 : num_test_data
%     input = data_uji(:,i); % input vektor 400x1
%     test_label = char(lah(i)); % mengambil test label dari group ('1')
%     % Find winner neuron
%     min_dist = inf;
%     winner_r = -1; winner_c = -1;
%     for r = 1 : size(w,1) % 1 : 20
%         for c = 1 : size(w,2) % 1 : 20
%             dist = norm(input - shiftdim(w(r,c,:))); % input - shiftdim dari bobot r c 1:400 lalu di norm
%             if (dist < min_dist)
%                 min_dist = dist; % mencari dist terkecil untuk menjadi min_dist
%                 winner_r = r; winner_c = c;
%             end
%         end
%     end % END winner neuron found.
%     
%     closest_table = neuron_labels(winner_r,winner_c);
%     table (i)= closest_table;
%     % compare output label with test label.
%     if min_dist <= 2.95
%         output_label = char(neuron_labels(winner_r,winner_c)); % mengambil cluster dari neuron_label train(r = baris c = kolom) 
%         
%     if (output_label == test_label)
%         fprintf('output:%s ',output_label); % keluaran output_label
%         fprintf('testlabel:%s ',test_label);
%         fprintf ('CORRECT!\n');
%         betul = betul + 1;
%     elseif (output_label ~= test_label)
%         fprintf('output:%s ',output_label); % keluaran output_label
%         fprintf('testlabel:%s ',test_label);
%         fprintf ('WRONG!\n');
%     end
%     else
%         fprintf('output:%s ',output_label); % keluaran output_label
%         fprintf('testlabel:%s ',test_label); 
%         fprintf('TIDAK DIKENAL!\n'); 
%     end
% %     if(output_label == test_label)
% %         fprintf ('CORRECT!\n');
% %         betul = betul + 1;
% %     else
% %         fprintf('WRONG!\n');
% %     end
% %     for t = 1 : i
% %         closest_table = output_label;
% %         table = closest_table;
% %     end
% end
%     
% accuracy = betul / num_test_data*100;
% fprintf('Out of %d test data, %d were correctly classified.\n', num_test_data, betul);
% fprintf('Accuracy: %f\n\n', accuracy);






