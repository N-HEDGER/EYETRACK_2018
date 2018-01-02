function outimage = coladjust(inimage,lum,con);

  a=im2uint8(rgb2hsv(inimage));
  b=a(:,:,3);
  
  imcell=cell(1,1);
  imcell{1}=b;
  
  stats=imstats(imcell);
  b=lumMatch(imcell,[],[stats.meanLum*lum stats.meanStd*con]);
  
  a(:,:,3)=b{1};
  a=im2double(a);
  outimage=im2uint8(hsv2rgb(a));
end
