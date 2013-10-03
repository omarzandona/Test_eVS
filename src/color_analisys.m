clear all
warning off
positive =0;
if positive == 1
  cd ..\dataset\pos00\
  write_filename = ['positive_color_analisys.mat'];
else
  cd ..\dataset\Negatives\
  write_filename = ['negative_color_analisys.mat'];
end
lista_immagini= dir('*.png');
numero_immagini=size(lista_immagini,1);
cd ..\..\code

sigma = 10;


for i=10:10:100

  filename = lista_immagini(i).name;
  img = imread(filename);
  [dim_y, dim_x, dim_z] = size(img);


  if positive == 0
    y = randint(1,1,[30 dim_y-30]);
    x= randint(1,1,[30 dim_x-30]);
    if (dim_z == 3)
      img_real = img(y-20+1:y+20, x-20+1:x+20,:);
    else
      img_real = img(y-20+1:y+20, x-20+1:x+20);
    end
    clear img
    img = img_real;
  end



  if (dim_z == 3)
     map_red{i/10} = symmetry_score(img(:,:,1),sigma);
     map_green{i/10} = symmetry_score(img(:,:,2),sigma);
     map_blu{i/10} = symmetry_score(img(:,:,3),sigma);

    img_gray = rgb2gray(img);

  else
    img_gray = img;
  end

  map_gray{i/10} = symmetry_score(img_gray,sigma);

  magnitude = compute_magnitude(img_gray,0);
  map_magn{i/10} = symmetry_score(magnitude,sigma);

  log_mask = fspecial('log',[3 3],0.7);
  img_log=imfilter(img_gray,log_mask);
  map_log{i/10} = symmetry_score(img_log,sigma);



end




for i=1:1:240
  f = figure(1)
%    subplot(3,2,1);imshow(map_red{i},[]); title 'Red '
%    subplot(3,2,2);imshow(map_green{i},[]); title 'Green  '
%    subplot(3,2,3);imshow(map_blu{i},[]); title 'blu  '
  subplot(3,2,4);imshow(map_gray{i},[]); title 'Intensity '
  subplot(3,2,5);imshow(map_log{i},[]); title 'laplacian '
    subplot(3,2,6);imshow(map_magn{i},[]); title ' Magnitude '   
  waitforbuttonpress
  close(f)
end

save(write_filename,'map_red','map_green','map_blue','map_gray','map_log','map_magn');


