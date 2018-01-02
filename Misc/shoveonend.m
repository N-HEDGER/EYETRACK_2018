function [newmat]=shoveonend(mat,val)

vect=repmat(val,length(mat),1);
newmat=horzcat(mat,vect);
end

