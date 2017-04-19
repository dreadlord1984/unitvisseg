% script for selecting bases and creating the visualization with the
% selected bases and its complementary

clear selected

Nx = round(1.2*sqrt(bases.Nbases+1));
Ny = ceil((bases.Nbases+1)/Nx);
Dx = 1/Nx; Dy = 1/Ny;

figure
x = 0; y = 0;
for i = 1:bases.Nbases + 1
    if i <= bases.Nbases
        base = double(bases.B(:,:,:,i));
        base = base - min(base(:));
        base = (base / max(base(:)))*255;
    else
        base = zeros(nrows,ncols,c);
        base(:,:,1) = 255;
    end
    
    selected(i) = 0;
    [nrows ncols c] = size(base);
    
    axes('position', [(x+0.025)*Dx (Ny-y-1+0.025)*Dy Dx*0.95 Dy*0.95]); % create axis
    h_base=imshow(uint8(base)); axis('off'); axis('equal'); hold on
    h_border(i) = plot([1 ncols ncols 1 1], [1 1 nrows nrows 1], 'r', 'linewidth', 7);
    set(h_base, 'ButtonDownFcn', ['selected = toggle(' num2str(i) ', selected, h_border);']);
    drawnow
    
    x = x+1;
    if x>Nx-1 && i < bases.Nbases + 1
        x = 0; y = y+1;
    end
end

while selected(end) == 0
    drawnow
end

close
drawnow

selected(end) = [];


