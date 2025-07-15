accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 15 --mask False --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 15 --mask False --edge False   --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1

mkdir -p /dss/dssmcmlfs01/pn36te/pn36te-dss-0000/ge32dim2/diff_sr_rwa_pca
scp -r ~/Downloads/script_rwa/RWA_PCA/* ge32dim2@login.ai.lrz.de:/dss/dssmcmlfs01/pn36te/pn36te-dss-0000/ge32dim2/diff_sr_rwa_pca
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 15 --mask False --edge False  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 15 --mask False --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 16 --mask True --edge False  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 14 --mask True --edge True  --l1_lambda 1 --l2_lambda 0 --l3_lambda 0
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 15 --mask True --edge True  --l1_lambda 0 --l2_lambda 1 --l3_lambda 0
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --train_batch_size 16 --timesteps 500 --num_epochs 16 --mask True --edge True  --l1_lambda 0 --l2_lambda 0 --l3_lambda 1

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 31 --train_batch_size 16 --timesteps 500 --num_epochs 40 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 31 --train_batch_size 16 --timesteps 500 --num_epochs 20 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
{'MPSNR': 25.992031848323826, 'MSSIM': 0.5717371053411704, 'ERGAS': 10.921342551547063, 'SAM': 8.462209261069477, 'CrossCorrelation': 0.70768005, 'RMSE': 0.06124689601455407}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 16 --train_batch_size 16 --timesteps 500 --num_epochs 39 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 16 --train_batch_size 16 --timesteps 500 --num_epochs 25 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
{'MPSNR': 25.802457787378, 'MSSIM': 0.5689011634765875, 'ERGAS': 11.07352978945674, 'SAM': 8.336002497609027, 'CrossCorrelation': 0.69527483, 'RMSE': 0.062499810706364144}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --pca_bands 6 --train_batch_size 16 --timesteps 500 --num_epochs 90 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 60
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 61 --pca_bands 6 --train_batch_size 16 --timesteps 500 --num_epochs 90 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 
{'MPSNR': 25.43029995372458, 'MSSIM': 0.5499027178772891, 'ERGAS': 11.914309880279385, 'SAM': 8.940378652073498, 'CrossCorrelation': 0.6574499, 'RMSE': 0.06189737514834447}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 121 --pca_bands 10 --train_batch_size 16 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 160
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 121 --pca_bands 10 --train_batch_size 16 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 

{'MPSNR': 47.68532691302493, 'MSSIM': 0.993053501812858, 'ERGAS': 1.4378141409233207, 'SAM': 2.1382622507976747, 'CrossCorrelation': 0.99670756, 'RMSE': 0.0062059031301573845}
1

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 4 --timesteps 500 --num_epochs 120 --mask True --edge False  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 80
{'MPSNR': 27.91335186179164, 'MSSIM': 0.6453416009778498, 'SAM': 12.561747225500966, 'CrossCorrelation': 0.71888685, 'RMSE': 0.07102120230496896, 'FID': 75.26762390136719, 'lv pred': 0.006867627, 'lv true': 0.023523524}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1
{'MPSNR': 25.621736017640615, 'MSSIM': 0.5536516563628296, 'SAM': 8.995235568853413, 'CrossCorrelation': 0.6700597, 'RMSE': 0.06097862366071886, 'FID': 39.074928283691406, 'lv pred': 0.005296533, 'lv true': 0.015502878}
{'MPSNR': 27.477594241906942, 'MSSIM': 0.5674369498661664, 'ERGAS': 22687.62126147057, 'SAM': 13.247693952989398, 'CrossCorrelation': 0.63167584, 'RMSE': 0.07335042873026511, 'FID': 56.02751541137695, 'lv pred': 0.007925421, 'lv true': 0.023523524}

0.99365234375 0.9951171875 -0.044647216796875
-0.2110595703125 0.2440185546875 -0.0001461505889892578
-0.994140625 0.9951171875 0.0509033203125
-0.2373046875 0.232666015625 -0.0004456043243408203
-0.990234375 0.994140625 0.04254150390625
-0.219970703125 0.2186279296875 0.0029582977294921875
-0.9970703125 0.9892578125 -0.04827880859375
-0.27099609375 0.317626953125 0.0023441314697265625
-0.9892578125 0.98681640625 0.00885009765625
-0.257568359375 0.2274169921875 0.00568389892578125
-0.99853515625 0.9951171875 0.0209197998046875
-0.252685546875 0.27880859375 0.009307861328125
-0.998046875 0.9990234375 0.00885772705078125
-0.22509765625 0.2471923828125 -0.00040030479431152344
-0.99853515625 0.99658203125 -0.002471923828125
-0.225830078125 0.27294921875 0.00664520263671875
-0.99755859375 0.99853515625 0.01329803466796875
-0.2271728515625 0.2371826171875 -0.0064849853515625
-0.99755859375 0.99951171875 0.0285186767578125
-0.2318115234375 0.2186279296875 0.0009512901306152344
-0.9970703125
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.0005 --sigma_max 80 --sigma_data 0.5 --rho 7
{'MPSNR': 27.636547830048556, 'MSSIM': 0.6244192791348968, 'SAM': 12.561268634201646, 'CrossCorrelation': 0.6993754, 'RMSE': 0.0741848290478937, 'FID': 50.13416290283203, 'lv pred': 0.02017451, 'lv true': 0.023523524}\
{'MPSNR': 27.723102038074224, 'MSSIM': 0.6323690083166279, 'SAM': 12.438909247855971, 'CrossCorrelation': 0.7040294, 'RMSE': 0.07325554467967203, 'FID': 22.359867095947266, 'lv pred': 0.02021508, 'lv true': 0.023523524}
{'MPSNR': 27.689348679820036, 'MSSIM': 0.6264675645417963, 'SAM': 12.576990650094066, 'CrossCorrelation': 0.7011181, 'RMSE': 0.07407454223993573, 'FID': 16.819734573364258, 'lv pred': 0.020571752, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.0005 --sigma_max 5 --sigma_data 0.5 --rho 7
{'MPSNR': 26.830293550386504, 'MSSIM': 0.566151006875601, 'SAM': 13.834437965148648, 'CrossCorrelation': 0.6409369, 'RMSE': 0.08081829854583321, 'FID': 32.76103973388672, 'lv pred': 0.027036302, 'lv true': 0.023523524}
{'MPSNR': 26.941720330954876, 'MSSIM': 0.5741680125726393, 'SAM': 13.699915307955102, 'CrossCorrelation': 0.64921397, 'RMSE': 0.08013424753143802, 'FID': 59.188907623291016, 'lv pred': 0.02753272, 'lv true': 0.023523524}
{'MPSNR': 26.909417376382425, 'MSSIM': 0.571251163113424, 'SAM': 13.763164831363357, 'CrossCorrelation': 0.6463512, 'RMSE': 0.08004042864665278, 'FID': 43.59678268432617, 'lv pred': 0.027091507, 'lv true': 0.023523524}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 7
{'MPSNR': 27.595686860448087, 'MSSIM': 0.6246247782451734, 'SAM': 12.522310957121887, 'CrossCorrelation': 0.696424, 'RMSE': 0.07436526353790052, 'FID': 44.84507751464844, 'lv pred': 0.02044683, 'lv true': 0.023523524}
{'MPSNR': 27.717213258542607, 'MSSIM': 0.6270197893482938, 'SAM': 12.457564230438031, 'CrossCorrelation': 0.7029633, 'RMSE': 0.07377152172526913, 'FID': 29.164180755615234, 'lv pred': 0.02006933, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 7
{'MPSNR': 27.69579910165126, 'MSSIM': 0.6270024830256807, 'SAM': 12.464921000458235, 'CrossCorrelation': 0.7023429, 'RMSE': 0.07386242864597545, 'FID': 37.26704025268555, 'lv pred': 0.020161513, 'lv true': 0.023523524}
{'MPSNR': 27.55902627694245, 'MSSIM': 0.6222170975267565, 'SAM': 12.498781700988221, 'CrossCorrelation': 0.6934941, 'RMSE': 0.07479263258180098, 'FID': 36.42353057861328, 'lv pred': 0.02008609, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 6
{'MPSNR': 27.721443611500806, 'MSSIM': 0.6304778201244127, 'SAM': 12.472202980157483, 'CrossCorrelation': 0.70312023, 'RMSE': 0.07363715757221641, 'FID': 43.167179107666016, 'lv pred': 0.020066861, 'lv true': 0.023523524}
{'MPSNR': 27.728895449205393, 'MSSIM': 0.6309565459402499, 'SAM': 12.440695513694862, 'CrossCorrelation': 0.70461583, 'RMSE': 0.07367259924028238, 'FID': 38.40861892700195, 'lv pred': 0.019908182, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 6
{'MPSNR': 27.552904550561937, 'MSSIM': 0.6217925112895512, 'SAM': 12.575845023037663, 'CrossCorrelation': 0.69349885, 'RMSE': 0.07498968825624783, 'FID': 43.994285583496094, 'lv pred': 0.020310372, 'lv true': 0.023523524}
{'MPSNR': 27.6753474204919, 'MSSIM': 0.626423084828627, 'SAM': 12.460824151338771, 'CrossCorrelation': 0.70121694, 'RMSE': 0.07390179380248463, 'FID': 32.26237106323242, 'lv pred': 0.020286387, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 5
{'MPSNR': 27.633612311469943, 'MSSIM': 0.6261856315386004, 'SAM': 12.492081986579713, 'CrossCorrelation': 0.69931066, 'RMSE': 0.07396335119050063, 'FID': 34.84735107421875, 'lv pred': 0.019932335, 'lv true': 0.023523524}
{'MPSNR': 27.633612311469943, 'MSSIM': 0.6261856315386004, 'SAM': 12.492081986579713, 'CrossCorrelation': 0.69931066, 'RMSE': 0.07396335119050063, 'FID': 34.84735107421875, 'lv pred': 0.019932335, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 5
{'MPSNR': 27.578277173756526, 'MSSIM': 0.619570763770285, 'SAM': 12.575466263777665, 'CrossCorrelation': 0.6947551, 'RMSE': 0.07487202958133214, 'FID': 36.99964141845703, 'lv pred': 0.02028155, 'lv true': 0.023523524}
{'MPSNR': 27.80383334823556, 'MSSIM': 0.6340489945403384, 'SAM': 12.435037680908243, 'CrossCorrelation': 0.7084433, 'RMSE': 0.07316443085625485, 'FID': 37.708335876464844, 'lv pred': 0.01995884, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 4
{'MPSNR': 27.698895147851307, 'MSSIM': 0.6305119729341915, 'SAM': 12.427260401216078, 'CrossCorrelation': 0.7030827, 'RMSE': 0.07357975356454456, 'FID': 24.796344757080078, 'lv pred': 0.019883526, 'lv true': 0.023523524}
{'MPSNR': 27.734523153939158, 'MSSIM': 0.6284536829325137, 'SAM': 12.498992814518193, 'CrossCorrelation': 0.7048687, 'RMSE': 0.07343699835710649, 'FID': 23.169565200805664, 'lv pred': 0.019947063, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 4
{'MPSNR': 27.669227160845743, 'MSSIM': 0.6271722419464845, 'SAM': 12.590124521886544, 'CrossCorrelation': 0.6997487, 'RMSE': 0.07430323103995584, 'FID': 32.87677764892578, 'lv pred': 0.020590693, 'lv true': 0.023523524}
{'MPSNR': 27.738812231461882, 'MSSIM': 0.6288613178362474, 'SAM': 12.541925685248712, 'CrossCorrelation': 0.7049156, 'RMSE': 0.07375384303808466, 'FID': 22.357650756835938, 'lv pred': 0.02021937, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 3
{'MPSNR': 27.613816788650926, 'MSSIM': 0.6239058336343464, 'SAM': 12.637452307662157, 'CrossCorrelation': 0.6961037, 'RMSE': 0.07453683952665668, 'FID': 42.03152847290039, 'lv pred': 0.020309381, 'lv true': 0.023523524}
{'MPSNR': 27.64957401930059, 'MSSIM': 0.6273773551707142, 'SAM': 12.48777480334103, 'CrossCorrelation': 0.69903094, 'RMSE': 0.07428916165561657, 'FID': 43.937660217285156, 'lv pred': 0.02019506, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 3
{'MPSNR': 27.642129753918336, 'MSSIM': 0.6246719888623108, 'SAM': 12.5738185786597, 'CrossCorrelation': 0.69824666, 'RMSE': 0.07427826477951066, 'FID': 19.987606048583984, 'lv pred': 0.021266608, 'lv true': 0.023523524}
{'MPSNR': 27.60098278183165, 'MSSIM': 0.6253385051322804, 'SAM': 12.693186144429754, 'CrossCorrelation': 0.6956228, 'RMSE': 0.07462140909395963, 'FID': 28.472309112548828, 'lv pred': 0.021384371, 'lv true': 0.023523524}
{'MPSNR': 27.619348139046203, 'MSSIM': 0.6216504817545371, 'SAM': 12.660377768084889, 'CrossCorrelation': 0.69654644, 'RMSE': 0.07451827958718515, 'FID': 29.776081085205078, 'lv pred': 0.021533264, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 2
{'MPSNR': 27.661172080130935, 'MSSIM': 0.6263020454444574, 'SAM': 12.48790470432355, 'CrossCorrelation': 0.7000449, 'RMSE': 0.07386292674509422, 'FID': 34.976226806640625, 'lv pred': 0.020121276, 'lv true': 0.023523524}
{'MPSNR': 27.6844405892946, 'MSSIM': 0.62809288311779, 'SAM': 12.4484773881411, 'CrossCorrelation': 0.7007058, 'RMSE': 0.07389089692637872, 'FID': 30.200904846191406, 'lv pred': 0.019786559, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 2
{'MPSNR': 27.39070647984684, 'MSSIM': 0.6087171590710577, 'SAM': 12.865255810767207, 'CrossCorrelation': 0.6804446, 'RMSE': 0.07659103094469746, 'FID': 13.526473999023438, 'lv pred': 0.02401017, 'lv true': 0.023523524}
{'MPSNR': 27.39496173792354, 'MSSIM': 0.6096004618150431, 'SAM': 12.906784015182458, 'CrossCorrelation': 0.68137133, 'RMSE': 0.07635796653549558, 'FID': 21.186731338500977, 'lv pred': 0.02416043, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 1
{'MPSNR': 27.435614075157456, 'MSSIM': 0.6073255231852568, 'SAM': 13.105247624189616, 'CrossCorrelation': 0.6810811, 'RMSE': 0.07670641368979356, 'FID': 29.84455680847168, 'lv pred': 0.028043177, 'lv true': 0.023523524}
{'MPSNR': 27.325036296592067, 'MSSIM': 0.6007613685101605, 'SAM': 13.0411471532443, 'CrossCorrelation': 0.6755886, 'RMSE': 0.07725869066655358, 'FID': 26.933574676513672, 'lv pred': 0.027394501, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 1
{'MPSNR': 26.483656733879076, 'MSSIM': 0.5688483580515039, 'SAM': 13.720431966450226, 'CrossCorrelation': 0.6137477, 'RMSE': 0.08435419690705961, 'FID': 29.542823791503906, 'lv pred': 0.018037219, 'lv true': 0.023523524}
{'MPSNR': 26.47728537237064, 'MSSIM': 0.5655887451612228, 'SAM': 13.718069464148751, 'CrossCorrelation': 0.61202145, 'RMSE': 0.08478872325214357, 'FID': 41.84264373779297, 'lv pred': 0.017916085, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.7
{'MPSNR': 26.202687895700286, 'MSSIM': 0.5377693678123477, 'SAM': 14.29633523445137, 'CrossCorrelation': 0.5883953, 'RMSE': 0.08703615413907512, 'FID': 30.334388732910156, 'lv pred': 0.024183718, 'lv true': 0.023523524}
{'MPSNR': 26.20643479396363, 'MSSIM': 0.5373185714685397, 'SAM': 14.393673319865194, 'CrossCorrelation': 0.58755153, 'RMSE': 0.08724580788969503, 'FID': 34.004417419433594, 'lv pred': 0.02432288, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.7
{'MPSNR': 27.723732998102975, 'MSSIM': 0.6572192076437127, 'SAM': 11.732166754734827, 'CrossCorrelation': 0.70994574, 'RMSE': 0.07247675521288774, 'FID': 69.18092346191406, 'lv pred': 0.0103888335, 'lv true': 0.023523524}
{'MPSNR': 27.74174190309948, 'MSSIM': 0.6532009611860642, 'SAM': 11.780221094366354, 'CrossCorrelation': 0.71079296, 'RMSE': 0.07242958905787236, 'FID': 60.683128356933594, 'lv pred': 0.010260225, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 80 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 28.06770935481836, 'MSSIM': 0.6732708823133999, 'SAM': 11.60041069596733, 'CrossCorrelation': 0.72998214, 'RMSE': 0.06982810931732257, 'FID': 41.851600646972656, 'lv pred': 0.009391522, 'lv true': 0.023523524}
{'MPSNR': 27.94135688385878, 'MSSIM': 0.6679029754476363, 'SAM': 11.556983674810295, 'CrossCorrelation': 0.72308475, 'RMSE': 0.07062442421002404, 'FID': 45.49482727050781, 'lv pred': 0.009433555, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 28.358108305950697, 'MSSIM': 0.6906641853731763, 'SAM': 11.254606744441856, 'CrossCorrelation': 0.7477305, 'RMSE': 0.06713086427389267, 'FID': 59.72831344604492, 'lv pred': 0.008024238, 'lv true': 0.023523524}
{'MPSNR': 28.570543273381055, 'MSSIM': 0.6942681219264014, 'SAM': 11.291411734755089, 'CrossCorrelation': 0.75833297, 'RMSE': 0.06598850842879003, 'FID': 70.74258422851562, 'lv pred': 0.0083995825, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.5
{'MPSNR': 29.259904728859894, 'MSSIM': 0.7279218551034173, 'SAM': 10.670057352056661, 'CrossCorrelation': 0.7918903, 'RMSE': 0.06058686104074673, 'FID': 98.80836486816406, 'lv pred': 0.0052850414, 'lv true': 0.023523524}
{'MPSNR': 29.147014592493022, 'MSSIM': 0.7250294284539545, 'SAM': 10.659320251498322, 'CrossCorrelation': 0.78680795, 'RMSE': 0.06115888573179996, 'FID': 104.540283203125, 'lv pred': 0.0052562198, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.5
{'MPSNR': 29.53659656995855, 'MSSIM': 0.7395323191508457, 'SAM': 10.59895308979796, 'CrossCorrelation': 0.8038003, 'RMSE': 0.058457249753061546, 'FID': 113.44088745117188, 'lv pred': 0.0043211095, 'lv true': 0.023523524}
{'MPSNR': 29.561669658531663, 'MSSIM': 0.7396509764575758, 'SAM': 10.580754091196866, 'CrossCorrelation': 0.80480784, 'RMSE': 0.058284884468778726, 'FID': 120.40956115722656, 'lv pred': 0.004329096, 'lv true': 0.023523524}
{'MPSNR': 29.501386974860242, 'MSSIM': 0.7403727335485745, 'SAM': 10.541728491874327, 'CrossCorrelation': 0.80234486, 'RMSE': 0.05852982279466563, 'FID': 131.5072784423828, 'lv pred': 0.0042756167, 'lv true': 0.023523524}


accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 28.477500137033548, 'MSSIM': 0.6930626657331335, 'SAM': 11.323899898767738, 'CrossCorrelation': 0.7528842, 'RMSE': 0.06651652414693451, 'FID': 54.39536666870117, 'lv pred': 0.008360978, 'lv true': 0.023523524}
{'MPSNR': 28.39349777405564, 'MSSIM': 0.6920505614934293, 'SAM': 11.224631395494729, 'CrossCorrelation': 0.7496166, 'RMSE': 0.06683215040083755, 'FID': 82.90496826171875, 'lv pred': 0.0081788935, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 70 --sigma_data 0.5 --rho 0.6
{'MPSNR': 29.405885334307946, 'MSSIM': 0.7358445801897285, 'SAM': 10.606166817601993, 'CrossCorrelation': 0.7984932, 'RMSE': 0.05921647925060511, 'FID': 104.19612121582031, 'lv pred': 0.0045783254, 'lv true': 0.023523524}
{'MPSNR': 29.438773185428285, 'MSSIM': 0.7364925474438291, 'SAM': 10.559538183785284, 'CrossCorrelation': 0.80042607, 'RMSE': 0.0590460488898221, 'FID': 115.59578704833984, 'lv pred': 0.004617913, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 60 --sigma_data 0.5 --rho 0.6
{'MPSNR': 29.380100464604396, 'MSSIM': 0.7344372126068295, 'SAM': 10.613091779618514, 'CrossCorrelation': 0.79717344, 'RMSE': 0.059496096769753114, 'FID': 113.18704223632812, 'lv pred': 0.0047661616, 'lv true': 0.023523524}
{'MPSNR': 29.36729994552558, 'MSSIM': 0.7338726107206405, 'SAM': 10.633093910742105, 'CrossCorrelation': 0.79642403, 'RMSE': 0.05967569981738476, 'FID': 129.85308837890625, 'lv pred': 0.00472312, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 50 --sigma_data 0.5 --rho 0.6
{'MPSNR': 27.72512288078212, 'MSSIM': 0.6531384669975696, 'SAM': 12.044890383647463, 'CrossCorrelation': 0.7070566, 'RMSE': 0.0730102117060218, 'FID': 37.476131439208984, 'lv pred': 0.0108626, 'lv true': 0.023523524}
{'MPSNR': 27.44111722752488, 'MSSIM': 0.6393172661866294, 'SAM': 12.035882623293672, 'CrossCorrelation': 0.6907983, 'RMSE': 0.0748963521444546, 'FID': 55.98792266845703, 'lv pred': 0.011020429, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 40 --sigma_data 0.5 --rho 0.6
{'MPSNR': 27.171185202124754, 'MSSIM': 0.6210845227931799, 'SAM': 12.50445464200712, 'CrossCorrelation': 0.6689322, 'RMSE': 0.07790831920031041, 'FID': 30.10199737548828, 'lv pred': 0.012841055, 'lv true': 0.023523524}
{'MPSNR': 27.1466028675569, 'MSSIM': 0.6209930263906234, 'SAM': 12.596626173283333, 'CrossCorrelation': 0.66793156, 'RMSE': 0.0780113797395146, 'FID': 62.56581115722656, 'lv pred': 0.012824287, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 30 --sigma_data 0.5 --rho 0.6
{'MPSNR': 26.708009565064508, 'MSSIM': 0.5928487146936389, 'SAM': 13.253308179105286, 'CrossCorrelation': 0.631994, 'RMSE': 0.0817214058895979, 'FID': 36.751136779785156, 'lv pred': 0.014893723, 'lv true': 0.023523524}
{'MPSNR': 26.751918591732675, 'MSSIM': 0.5924059977285179, 'SAM': 13.175528374853538, 'CrossCorrelation': 0.63599753, 'RMSE': 0.0816898723838484, 'FID': 28.378219604492188, 'lv pred': 0.014594832, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 20 --sigma_data 0.5 --rho 0.6
{'MPSNR': 26.175031759922845, 'MSSIM': 0.5540068597084193, 'SAM': 13.846376725694022, 'CrossCorrelation': 0.5867452, 'RMSE': 0.08720651170075615, 'FID': 34.46333312988281, 'lv pred': 0.018720055, 'lv true': 0.023523524}
{'MPSNR': 26.274002952237794, 'MSSIM': 0.5552565015854893, 'SAM': 14.016547886551196, 'CrossCorrelation': 0.5943035, 'RMSE': 0.08649284294645286, 'FID': 17.776042938232422, 'lv pred': 0.018503668, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 10 --sigma_data 0.5 --rho 0.6
{'MPSNR': 25.93391838361722, 'MSSIM': 0.515750802695987, 'SAM': 14.83511518111394, 'CrossCorrelation': 0.5616067, 'RMSE': 0.08999155246116593, 'FID': 53.728370666503906, 'lv pred': 0.028083548, 'lv true': 0.023523524}
{'MPSNR': 25.894710569973288, 'MSSIM': 0.5156915467464583, 'SAM': 14.82934305259316, 'CrossCorrelation': 0.55564594, 'RMSE': 0.09028238104201783, 'FID': 35.30479431152344, 'lv pred': 0.02775158, 'lv true': 0.023523524}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.0002 --sigma_max 70 --sigma_data 0.5 --rho 0.6
{'MPSNR': 29.45946007047854, 'MSSIM': 0.7377069985765969, 'SAM': 10.578071748099422, 'CrossCorrelation': 0.80056727, 'RMSE': 0.05902409421327961, 'FID': 120.5556640625, 'lv pred': 0.004647056, 'lv true': 0.023523524}
{'MPSNR': 29.401799737349865, 'MSSIM': 0.7343454320034056, 'SAM': 10.685879575966812, 'CrossCorrelation': 0.798231, 'RMSE': 0.059413688186319265, 'FID': 108.2404556274414, 'lv pred': 0.004665096, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.02 --sigma_max 70 --sigma_data 0.5 --rho 0.6
{'MPSNR': 28.496216894286846, 'MSSIM': 0.6944827653365162, 'SAM': 11.200636256657955, 'CrossCorrelation': 0.755332, 'RMSE': 0.06599423273712415, 'FID': 73.43204498291016, 'lv pred': 0.008342714, 'lv true': 0.023523524}
{'MPSNR': 28.423583486956193, 'MSSIM': 0.6895920362972897, 'SAM': 11.382184483948816, 'CrossCorrelation': 0.7501862, 'RMSE': 0.06668711926357988, 'FID': 59.698394775390625, 'lv pred': 0.008654121, 'lv true': 0.023523524}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.02 --sigma_max 10 --sigma_data 0.5 --rho 0.6
{'MPSNR': 26.550219277070337, 'MSSIM': 0.559831370961062, 'SAM': 13.60383297762725, 'CrossCorrelation': 0.61839145, 'RMSE': 0.08397469135694079, 'FID': 39.45034408569336, 'lv pred': 0.02323145, 'lv true': 0.023523524}
{'MPSNR': 26.620738536691974, 'MSSIM': 0.5678866664928206, 'SAM': 13.532311256503364, 'CrossCorrelation': 0.62493706, 'RMSE': 0.08301484669201706, 'FID': 41.379661560058594, 'lv pred': 0.023077842, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.0002 --sigma_max 10 --sigma_data 0.5 --rho 0.6
{'MPSNR': 25.63852766504114, 'MSSIM': 0.4975282385081933, 'SAM': 15.391248006365624, 'CrossCorrelation': 0.5298693, 'RMSE': 0.09334781329097554, 'FID': 27.79206657409668, 'lv pred': 0.030885419, 'lv true': 0.023523524}
{'MPSNR': 25.539280603553586, 'MSSIM': 0.4914347073352544, 'SAM': 15.45084350520552, 'CrossCorrelation': 0.5207381, 'RMSE': 0.09388887920603166, 'FID': 26.16009521484375, 'lv pred': 0.030234586, 'lv true': 0.023523524}



accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 10 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 29.220379892296666, 'MSSIM': 0.7261794572870859, 'SAM': 10.823444139405309, 'CrossCorrelation': 0.7898166, 'RMSE': 0.060795112450770745, 'FID': 106.9489974975586, 'lv pred': 0.005649286, 'lv true': 0.023523524}
{'MPSNR': 29.190696933829724, 'MSSIM': 0.7271346610409267, 'SAM': 10.808314716099076, 'CrossCorrelation': 0.7890235, 'RMSE': 0.06085274635034355, 'FID': 93.22566986083984, 'lv pred': 0.0055950065, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 20 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.7
{'MPSNR': 28.680178029307406, 'MSSIM': 0.7050719013719577, 'SAM': 11.094434511414443, 'CrossCorrelation': 0.7636952, 'RMSE': 0.06464854516867823, 'FID': 72.69146728515625, 'lv pred': 0.007318155, 'lv true': 0.023523524}
{'MPSNR': 28.684550173922823, 'MSSIM': 0.7039447321061131, 'SAM': 11.194256436934412, 'CrossCorrelation': 0.76367974, 'RMSE': 0.06482440480985577, 'FID': 84.93913269042969, 'lv pred': 0.0076058554, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.7
{'MPSNR': 28.358108305950697, 'MSSIM': 0.6906641853731763, 'SAM': 11.254606744441856, 'CrossCorrelation': 0.7477305, 'RMSE': 0.06713086427389267, 'FID': 59.72831344604492, 'lv pred': 0.008024238, 'lv true': 0.023523524}
{'MPSNR': 28.570543273381055, 'MSSIM': 0.6942681219264014, 'SAM': 11.291411734755089, 'CrossCorrelation': 0.75833297, 'RMSE': 0.06598850842879003, 'FID': 70.74258422851562, 'lv pred': 0.0083995825, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 100 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 28.05949058229621, 'MSSIM': 0.6692395444760783, 'SAM': 11.663312749277685, 'CrossCorrelation': 0.72776514, 'RMSE': 0.07044894772201478, 'FID': 35.54583740234375, 'lv pred': 0.010055459, 'lv true': 0.023523524}
{'MPSNR': 27.96915748844912, 'MSSIM': 0.6662448376550024, 'SAM': 11.591876287885317, 'CrossCorrelation': 0.72435474, 'RMSE': 0.07039887726598383, 'FID': 57.255897521972656, 'lv pred': 0.010178616, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 500 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 26.660498312221886, 'MSSIM': 0.5786357192118108, 'SAM': 13.43615284968692, 'CrossCorrelation': 0.6286724, 'RMSE': 0.08300887716565525, 'FID': 32.79750061035156, 'lv pred': 0.017096456, 'lv true': 0.023523524}
{'MPSNR': 26.683918745241108, 'MSSIM': 0.576748139104478, 'SAM': 13.40461566172154, 'CrossCorrelation': 0.6299964, 'RMSE': 0.0825333840838187, 'FID': 31.019380569458008, 'lv pred': 0.016945673, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 1000 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 26.498773008958977, 'MSSIM': 0.5603400115152428, 'SAM': 13.776182148957309, 'CrossCorrelation': 0.61369675, 'RMSE': 0.0843740825564934, 'FID': 24.830238342285156, 'lv pred': 0.021229783, 'lv true': 0.023523524}
{'MPSNR': 26.453564900428685, 'MSSIM': 0.5542132135975273, 'SAM': 13.864188050132086, 'CrossCorrelation': 0.61097854, 'RMSE': 0.08481804979564378, 'FID': 30.001893997192383, 'lv pred': 0.021185575, 'lv true': 0.023523524}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 70 --sigma_data 0.5 --rho 0.6
{'MPSNR': 29.405885334307946, 'MSSIM': 0.7358445801897285, 'SAM': 10.606166817601993, 'CrossCorrelation': 0.7984932, 'RMSE': 0.05921647925060511, 'FID': 104.19612121582031, 'lv pred': 0.0045783254, 'lv true': 0.023523524}
{'MPSNR': 29.438773185428285, 'MSSIM': 0.7364925474438291, 'SAM': 10.559538183785284, 'CrossCorrelation': 0.80042607, 'RMSE': 0.0590460488898221, 'FID': 115.59578704833984, 'lv pred': 0.004617913, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 70 --sigma_data 0.1 --rho 0.6
{'MPSNR': 29.433375017530892, 'MSSIM': 0.7342172954213366, 'SAM': 10.736225337273298, 'CrossCorrelation': 0.7995215, 'RMSE': 0.059165696129681165, 'FID': 120.1427993774414, 'lv pred': 0.004581438, 'lv true': 0.023523524}
{'MPSNR': 29.41765033860976, 'MSSIM': 0.7344744820199275, 'SAM': 10.769707058989955, 'CrossCorrelation': 0.79856294, 'RMSE': 0.05924700506352205, 'FID': 132.0015106201172, 'lv pred': 0.004559311, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 70 --sigma_data 1 --rho 0.6
{'MPSNR': 29.36265691571388, 'MSSIM': 0.7339803802708087, 'SAM': 10.554829890902516, 'CrossCorrelation': 0.7969278, 'RMSE': 0.059591662832985726, 'FID': 107.11863708496094, 'lv pred': 0.0051737875, 'lv true': 0.023523524}
{'MPSNR': 29.36530071479466, 'MSSIM': 0.7336537748800552, 'SAM': 10.553817383819476, 'CrossCorrelation': 0.7966788, 'RMSE': 0.05965177956508899, 'FID': 115.7310791015625, 'lv pred': 0.005216833, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 70 --sigma_data 5 --rho 0.6
{'MPSNR': 27.826231518355247, 'MSSIM': 0.6867121029190763, 'SAM': 11.230468463373722, 'CrossCorrelation': 0.7275574, 'RMSE': 0.06899914211162021, 'FID': 100.84713745117188, 'lv pred': 0.009756378, 'lv true': 0.023523524}
{'MPSNR': 27.725810913607333, 'MSSIM': 0.6862372887889274, 'SAM': 11.197203945243523, 'CrossCorrelation': 0.7243751, 'RMSE': 0.06939343737403468, 'FID': 74.47704315185547, 'lv pred': 0.009654899, 'lv true': 0.023523524}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 70 --sigma_data 0.01 --rho 0.6
{'MPSNR': 29.42961474160677, 'MSSIM': 0.7338804812450571, 'SAM': 10.753914535848097, 'CrossCorrelation': 0.7996462, 'RMSE': 0.05906094971653655, 'FID': 125.7217025756836, 'lv pred': 0.0046308613, 'lv true': 0.023523524}
{'MPSNR': 29.480030067275596, 'MSSIM': 0.7360540826027611, 'SAM': 10.814018094699055, 'CrossCorrelation': 0.80115825, 'RMSE': 0.05896023024319056, 'FID': 113.55552673339844, 'lv pred': 0.0046640923, 'lv true': 0.023523524}



no edge 
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge False  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 28.12571080076688, 'MSSIM': 0.672398124656978, 'SAM': 11.524262887861155, 'CrossCorrelation': 0.7361053, 'RMSE': 0.06857094545687627, 'FID': 93.07293701171875, 'lv pred': 0.0076776175, 'lv true': 0.023523524}
{'MPSNR': 28.174352554258387, 'MSSIM': 0.6736606751467689, 'SAM': 11.48981420063551, 'CrossCorrelation': 0.7386451, 'RMSE': 0.0683121791331461, 'FID': 92.1028060913086, 'lv pred': 0.0076731774, 'lv true': 0.023523524}

no mask
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask False --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 100

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask False --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6

l1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 1 --l2_lambda 0 --l3_lambda 0 --recall 100

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 1 --l2_lambda 0 --l3_lambda 0 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6


l2
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0 --l2_lambda 1 --l3_lambda 0 --recall 60

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0 --l2_lambda 1 --l3_lambda 0 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6


l3
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0 --l2_lambda 0 --l3_lambda 1 --recall 60

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0 --l2_lambda 0 --l3_lambda 1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6


no spectral 
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 100
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6


no 3d unet 
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 40
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6

3bands
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 61 --pca_bands 3 --train_batch_size 4 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 100
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 61 --pca_bands 3 --train_batch_size 1 --timesteps 50 --num_epochs 120 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 26.510344480705655, 'MSSIM': 0.6479929481136624, 'SAM': 11.720150255811369, 'CrossCorrelation': 0.6720822, 'RMSE': 0.07650856105675669, 'FID': 47.6753044128418, 'lv pred': 0.0066603655, 'lv true': 0.022321485}
{'MPSNR': 26.410013137410616, 'MSSIM': 0.6397567858824457, 'SAM': 11.785321177474367, 'CrossCorrelation': 0.66487384, 'RMSE': 0.07763670191931611, 'FID': 62.58147048950195, 'lv pred': 0.006488404, 'lv true': 0.022321485}

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test2.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.2 --sigma_max 90 --sigma_data 0.5 --rho 0.6

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 6
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 10 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 5
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 4
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 3
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 2
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 1
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.7
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.5
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 181 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.2

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test_enmap.py --compack_bands 120 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask False --edge False  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.2 --sigma_max 80 --sigma_data 0.5 --rho 0.6

scp ge32dim2@login.ai.lrz.de:/dss/dssmcmlfs01/pn36te/pn36te-dss-0000/ge32dim2/diff_sr/result/hist_20bands.png  ~/Downloads/SOTA
scp ge32dim2@login.ai.lrz.de:/dss/dssmcmlfs01/pn36te/pn36te-dss-0000/ge32dim2/diff_sr/result/*.npy  ~/Downloads/SOTA/mine/enmap

accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/train.py --compack_bands 121 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --recall 140
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test.py --compack_bands 121 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.002 --sigma_max 80 --sigma_data 0.5 --rho 0.6
{'MPSNR': 27.53682999139167, 'MSSIM': 0.7008069958209666, 'SAM': 10.792200272014101, 'CrossCorrelation': 0.7347629, 'RMSE': 0.06754097609909376, 'FID': 17.451616287231445, 'lv pred': 0.006734925, 'lv true': 0.022321485}
{'MPSNR': 27.496503710695922, 'MSSIM': 0.7012692151807541, 'SAM': 10.803931980315284, 'CrossCorrelation': 0.7320332, 'RMSE': 0.06772304282159747, 'FID': 26.314496994018555, 'lv pred': 0.0067997794, 'lv true': 0.022321485}

epoch 120
{'MPSNR': 26.989982072976744, 'MSSIM': 0.6579300273253019, 'SAM': 11.485646609090454, 'CrossCorrelation': 0.6993008, 'RMSE': 0.072539324125268, 'FID': 30.11029624938965, 'lv pred': 0.00838114, 'lv true': 0.022321485}
Clipping input data to the valid range for imshow with RGB data ([0..1] for floats or [0..255] for integers). Got range [-0.37258009270156256..3.2678886685086326].
Clipping input data to the valid range for imshow with RGB data ([0..1] for floats or [0..255] for integers). Got range [0.08843392..1.8336396].
{'MPSNR': 27.01349597182628, 'MSSIM': 0.6573626386645038, 'SAM': 11.501056690060572, 'CrossCorrelation': 0.7008953, 'RMSE': 0.07262905093421601, 'FID': 35.904563903808594, 'lv pred': 0.008453834, 'lv true': 0.022321485}
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test2.py --compack_bands 121 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.2 --sigma_max 90 --sigma_data 0.5 --rho 0.7
accelerate launch --multi_gpu --num_processes 4 --mixed_precision=fp16 diff_sr_rwa_pca/test_enmap.py --compack_bands 121 --pca_bands 20 --train_batch_size 1 --timesteps 50 --num_epochs 200 --mask True --edge True  --l1_lambda 0.8 --l2_lambda 0.1 --l3_lambda 0.1 --sigma_min 0.2 --sigma_max 80 --sigma_data 0.5 --rho 0.7
