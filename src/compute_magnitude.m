%% Funzione che calcola modulo e fase del gradiente. Inoltre restituisce
%% anche l'immagine binarizzata del mosulo del gradiente.

% Input : image = immagine da processare
%         info_visual = Se uguale a 1 attiva visualizzazione risultati

function [magnitude, phase, bin_magnitude] = compute_magnitude(image, info_visual)

  % crea filtro sobel
  sobel_mask = fspecial('sobel');

  % Filtraggio orizzontale e verticale
  conv_h = conv2(image,sobel_mask');
  conv_v = conv2(image,sobel_mask);
  
  % Calcolo modulo
  grad_magnitude = abs(conv_h) + abs(conv_v);
    magnitude =  grad_magnitude- min(min( grad_magnitude));
   magnitude =  magnitude ./ max(max( magnitude));
  % Calcolo fase
  gradfase = atan2(conv_v,conv_h);
  gradfase = gradfase - min(min(gradfase));
  phase = gradfase ./ max(max(gradfase));

  
  % Calcolo dell' immagine binaria del modulo
  %%[x,y ]find(magnitude > 200);
  bin_magnitude = zeros(size(magnitude,1),size(magnitude,2));
  for i=1:size(magnitude,1)
    for j=1:size(magnitude,2)
      if grad_magnitude(i,j) > 160
        bin_magnitude(i,j) = 255;
      end
    end
  end
      
  bin_magnitude = uint8(bin_magnitude);
  
  
  if (info_visual == 1)
    figure(1);
    subplot(2,2,1);imshow(magnitude,[]); title 'Magnitude'
    subplot(2,2,2);imshow(phase,[]); title 'Phase Gardient'
    subplot(2,2,3);imshow(bin_magnitude);title ' Binarized Magnitude'
  end

  return