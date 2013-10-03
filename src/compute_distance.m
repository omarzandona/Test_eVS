% Usage
%[distance] = compute_distance(histo1,histo2,metric)
%
% Input:
%       histo1: First Histogram
%       histo2: Second Histogram
%       metric: Measure of distance to compute
%            1)Minkowski (l1) (bin-by-bin)
%            2)Histogram Intersect (bin-by-bin)
%            3)istogrammi cumulativi (bin-by-bin)
%            4)distanza CHI-Quadro
%            5)Kolmogorov
%            6)Quadratic-from-distance (cross-bin)
%
% Output:
%       distance: Value of distance between two histogram computed by
%                 metric measure chosed
%

function [distance] = compute_distance(histo1,histo2,metric)


%% Normalizzo gli istogrammi
histo1_norm = zeros(size(histo1,1),1);
histo2_norm = zeros(size(histo2,1),1);
for i=1:1:size(histo1,1)
    histo1_norm(i) = histo1(i)/sum(histo1);
    histo2_norm(i) = histo2(i)/sum(histo2);
end

%% Calcola gli istogrammi cumulativi
histo1_cum = zeros(size(histo1_norm,1),1);
histo2_cum = zeros(size(histo2_norm,1),1);
histo1_cum(1) = histo1_norm(1);
histo2_cum(1) = histo2_norm(1);
for i=2:1:size(histo1_norm,1)
    histo1_cum(i) = histo1_cum(i-1) + histo1_norm(i);
    histo2_cum(i) = histo2_cum(i-1) + histo2_norm(i);
end

%% Normalizza l'istogramma comulativo

histo1_cum_norm = zeros(size(histo1_cum,1),1);
histo2_cum_norm = zeros(size(histo2_cum,1),1);
for i=1:1:size(histo1,1)
    histo1_cum_norm(i) = histo1_cum(i)/sum(histo1_cum);
    histo2_cum_norm(i) = histo2_cum(i)/sum(histo2_cum);
end

% Inizializzo il valore della distanza da restituire
distance = 0;

%% Se metric vale 1 calcola la distanza di Minkowski L1
if(metric == 1)
    for i=1:1:size(histo1_norm,1)
        distance = distance + abs(histo1_norm(i)-histo2_norm(i));
    end
    
    %% Se metric vale 2 calcola la distanza Histogram Intersect
elseif (metric == 2)
    
    
    temp = 0;
    for i=1:1:size(histo1_norm,1)
        temp = temp + min(histo1_norm(i),histo2_norm(i));
    end
    
    distance = 1 - (temp/sum(histo2_norm));
    
    %% Se metric vale 3 calcola la distanza tra istogrammi cumulativi
elseif (metric == 3)
    
    
    % Calcola la distanza effettiva
    for i=1:1:size(histo1_cum_norm,1)
        
        distance = distance + abs(histo1_cum_norm(i)-histo2_cum_norm(i));
    end
    
    %% Se metric vale 4 calcola la distanza CHI-Quadro
elseif (metric == 4)
    for i=1:1:size(histo1_norm,1)
        m = (histo1_norm(i) + histo2_norm(i))/2;
        if (m ~= 0)
            distance = distance + (((histo1_norm(i)-m)^2)/m);
        end
    end
    
    
    %% Se metric vale 5 calcola la distanza di kolmogorov
elseif (metric == 5)
   
    % Calcola la distanza effettiva
    for i=1:1:size(histo1_cum_norm,1)
        max_distance = abs(histo1_cum_norm(i) - histo2_cum_norm(i));
        % Se è la distanza massima calcolata fino adesso la sostituisco
        if (max_distance > distance)
            distance = max_distance;
        end
    end
    
    
    %% Se metric vale 6 calcola la Quadratic-from-distance
elseif (metric == 6)
    
    % Calcola la matrice A con i peso a 0.5 per i bins vicini
    dim_diag = size(histo1_norm,1)-1;
    dim_diag_1 = size(histo1_norm,1)-2;
    A = diag(ones(dim_diag_1,1)*0.25,-2)+diag(ones(dim_diag_1,1)*0.25,2)+diag(ones(dim_diag,1)*0.5,1)+ diag(ones(dim_diag,1)*0.5,-1)+diag(ones(size(histo1_norm,1),1));
    distance =  sqrt((histo1_norm-histo2_norm)'*A*(histo1_norm-histo2_norm));
    
end
 
    
end
