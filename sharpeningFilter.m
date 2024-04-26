function sharpeningFilter(image)
    if ndims(image) ~= 3
        error('Input image must be in RGB format.');
    end
    
    methodList = {'Laplacian', 'Unsharp'};
    while true 
        disp('Select a sharpening method:');
        for i = 1:numel(methodList)
            disp([num2str(i) '. ' methodList{i}]);
        end
        selection = input('Enter the number corresponding to the desired method (0 to exit): ');
        
        if selection == 0
            disp('Exiting.');
            return;
        end
        
        if selection < 1 || selection > numel(methodList)
            disp('Invalid selection. Please enter a number between 1 and 2.');
            continue;
        end

        switch selection
            case 1
                sharpenedImage = applySharpening(image, 'laplacian');
            case 2
                sharpenedImage = applySharpening(image, 'unsharp'); 
        end

        figure;
        subplot(1, 2, 1);
        imshow(image);
        title('Original RGB Image');

        subplot(1, 2, 2);
        imshow(sharpenedImage);
        title(['Sharpened Image - Method: ' methodList{selection}]);
    end
end

function sharpenedImage = applySharpening(image, method)
    grayImage = rgb2gray(image);
    
    sharpeningKernels = struct('laplacian', fspecial('laplacian', 0.5),'unsharp', fspecial('unsharp'));
    
    if strcmpi(method, 'laplacian')
        sharpenedImage = imfilter(grayImage, sharpeningKernels.laplacian);
    elseif strcmpi(method, 'unsharp')
        sharpenedImage = imfilter(grayImage, sharpeningKernels.unsharp);
    else
        error('Invalid sharpening method.');
    end
    
    sharpenedImage = im2uint8(sharpenedImage);
end
