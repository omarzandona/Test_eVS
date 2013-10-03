
function [ncc] = compute_ncc(leftImage,rightImage,windowSize)



leftImage = double(leftImage);
rightImage = double(rightImage);
win=(windowSize-1)/2;
ncc = 0;
nrLeft = size(leftImage,1);
ncLeft = size(leftImage,2);
for(i=1+win:1:nrLeft-win)
  for(j=1+win:1:ncLeft-win)
    nccNumerator=0.0;
    nccDenominator=0.0;
    nccDenominatorRightWindow=0.0;
    nccDenominatorLeftWindow=0.0;
    for(a=-win:1:win)
      for(b=-win:1:win)
        nccNumerator=nccNumerator+(rightImage(i+a,j+b)*leftImage(i+a,j+b));
        nccDenominatorRightWindow=nccDenominatorRightWindow+(rightImage(i+a,j+b)*rightImage(i+a,j+b));
        nccDenominatorLeftWindow=nccDenominatorLeftWindow+(leftImage(i+a,j+b)*leftImage(i+a,j+b));
      end
    end
    nccDenominator=sqrt(double(nccDenominatorRightWindow*nccDenominatorLeftWindow));
    ncc=ncc + nccNumerator/nccDenominator;
  end
end

return