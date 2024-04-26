function edgeDetection(image)
    methodList = {'Sobel', 'Prewitt', 'Roberts', 'LoG', 'Canny', 'ZeroCross'};

    if ndims(image) == 3
        grayImage = rgb2gray(image);
    else
        grayImage = image;
    end
    
    while true
        disp('Select a method:');
        for i = 1:numel(methodList)
            disp([num2str(i) '. ' methodList{i}]);
        end
        
        selection = input('Enter the number corresponding to the desired method (0 to exit): ');
        
        if selection == 0
            disp('Exiting.');
            return;
        end
        
        if selection < 1 || selection > numel(methodList)
            disp('Invalid selection. Please enter a number between 1 and 7.');
            continue;
        end
        
        edgeMethod = methodList{selection};
          
        edgeImage = edge(grayImage, edgeMethod);
        
        figure;
        subplot(1, 2, 1);
        imshow(grayImage);
        title('Original Image');

        subplot(1, 2, 2);
        imshow(edgeImage);
        title(['Edge Detection Result - Method: ' methodList{selection}]);
    end
end
