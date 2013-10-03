%% Funzione che calcola le distanze tra istogrammi di due immagini secondo 6 diverse metriche.

%Input image1, image2 = Le due immagini su cui calcolare gli istogrammi
%       num_bins = Numero di bins dell'istogramma

% Output distance = vettore di distanze
%            1)Minkowski (l1) (bin-by-bin)
%            2)Histogram Intersect (bin-by-bin)
%            3)istogrammi cumulativi (bin-by-bin)
%            4)distanza CHI-Quadro
%            5)Kolmogorov
%            6)Quadratic-from-distance (cross-bin)
%
% Output:


function [distance, histo1, histo2] = compute_distance_between_histogram( image1, image2, num_bins)

histo1=  compute_histogram(image1,num_bins);
histo2 = compute_histogram(image2,num_bins);

for i=1:6
  distance(i) = compute_distance(histo1,histo2,i);
end

return