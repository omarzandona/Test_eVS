function [histogram] = compute_histogram(image,num_bins)


histo = imhist(image);
[histogram] = histogram_binning(histo,num_bins);

end