function [varargout] = cellintersect(varargin)
%works for all input types not just char vectors
if nargin<2
    warning('There should be at least 2 input arguments.')
else
    data = cellfun(@(x)reshape(x,[],1),varargin,'UniformOutput',false);
    X = cat(1,data{:});
    nX = size(X,1);
    L = false(nX,nX);
    for i = 1:nX-1 %columnwise
        idx = cellfun(@(x)isequal(X{i},x),X(i+1:end));
        L(i+1:end,i) = idx; L(i,i+1:end) = idx;
    end

    vb = [0 cumsum(cellfun(@numel,varargin))];
    for i = 1:nargin
        [ri,ci] = find(L(vb(i+1)+1:end,vb(i)+1:vb(i+1)));
        ri = ri + vb(i+1); ci = ci + vb(i);
        L(vb(i+1)+1:end,vb(i)+1:vb(i+1)) = false;
        L(vb(i)+1:vb(i+1),vb(i)+1:end) = false;
        [~,ui] = unique(ri);
        L(sub2ind(size(L),[ri(ui);ci(ui)],[ci(ui);ri(ui)])) = true;
    end
    L(sum(L,2)<nargin-1,:) = false;

    [~,ci] = find(L); %ind2sub(size(L),find(L));
    [vi,vii] = enumerate(cellfun(@numel,varargin));
    xi = unique([vi(ci),vii(ci)],'rows');
    
    varargout = cell(1,max(nargout,2));
    varargout{2} = xi(xi(:,1)==1,2);
    varargout{1} = varargin{1}(varargout{2});
    for i = 3:nargout
        varargout{i}  = xi(xi(:,1)==i-1,2);
    end
end