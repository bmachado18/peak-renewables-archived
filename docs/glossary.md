# Glossary

| Word | Definition | Referenced | Examples/Application |
| --- | --- | --- | --- |
| Internet of Things (IoT) | network of physical objects that are embedded in sensors, software, or other technology that allow them to connect and exchange data with other things over internet | [1] |  Home Security System |
| Machine Vision | The field of study to use computers to analyze and interpret digital images or video data from the real world | [1] |  |
| Framework | a set of pre-defined rules, conventions, and tools that provide a foundation for developing software applications | [1] |  |
| Mindmap | a diagramming tool that consists of a central idea or topic, which is represented by a large, central image or word. From this central idea, branches extend outwards, representing related subtopics, ideas, or concepts. These branches can further extend into sub-branches, creating a hierarchical structure that visually represents the relationships and connections between different ideas. | [1] |  |
| Entropy | an image metric used as a measure of the amount of uncertainty or randomness in an image. Specifically, it measures the average amount of information contained in each pixel of an image. | [1] |  |
| Universal Quality Index (UQI) | an image metric used to evaluate the similarity between two images. UQI measures the structural similarity between the reference image and the image being evaluated, taking into account both luminance and contrast differences. | [1] |  |
| Rosenberger | an image metric used to evaluate the sharpness of an image. The Rosenberger sharpness index is calculated based on the gradient magnitude of an image, which measures the rate of change of pixel intensity across the image. | [1] |  |
| Convolutional Neural Network (CNN) | a deep learning algorithm inspired by the human brain processing of visual information. It has high performance for image recognition tasks. | [1] | U-Net network |
| Data Augmentation | artificially increase the size and diversity of a dataset by generating new examples from existing ones, typically just by transforming the images a particular fashion. Goal is to improve performance and robustness. improves generalization in classification and prevents overfitting. downside is we cannot ensure variability of phenomenon is sufficiently captured. | [1] | generative adversarial networks (GAN’s) and autoencoders |
| Classification | to assign each object or data point to a predefined class or category, based on its similarity to other objects in that class and its dissimilarity to objects in other classes. | [1] | decision trees. neural networks, support vector machines |
| Hough Transform | a technique used to detect simple geometric shapes like lines, circles and ellipses in an image. First detect edges with a technique like canny edge detector, then for each edge point, find set of lines that pass through the point. This set is represented as a point in the hough space. it is parameterized by the slope and intercept of the lines in the image. once all edge points in hough space, points that lie on the same line in image will accumulate in clusters. Identify clusters with thersholding or clustering, which correspond to lines. | [1] | Detecting geometric shapes in images |
| U-Net Network | a CNN that consists of a contracting path and an expanding path which are connected by a bottleneck layer. good for accuracy, class imbalance, good generalization ability, and efficiency. It is limited just to image segmentation, and it needs large amounts of training data. may overfit | [1] | medical image segmentation, satellite image analysis, semantic segmentation. |
| residual structure  | refers to a type of architecture that uses shortcut connections to help alleviate the problem of vanishing gradients during training. For more depth, see Residual Networks. | [1] |  |
| Residual Networks (ResNets) | a neural network that is trained more efficiency or effectively by adding shortcut connections that bypass one or more layers. This creates a "residual" or "skip" connection that allows the gradient to flow more easily back to the earlier layers. In a residual block, the input to a layer is added to the output of the layer, rather than being concatenated with it. This creates a residual structure that enables the network to learn the residual mapping instead of trying to learn the entire mapping from inputs to outputs. Used in image classification, object detection, and natural language processing. | [2]  |  |
| Hole Convolutional Module | In traditional convolutional layers, each filter applies a convolution operation over a fixed receptive field of the input image, and the output feature map is a combination of local features that are spatially close to each other. The HCM is different in that it uses dilated convolutions, which expand the receptive field of the filters by inserting holes in the filter mask. This allows the filters to capture information from a larger region of the input image, while preserving the spatial resolution of the feature map. | [1] | semantic segmentation tasks |
| Strip Pooling Module (SPM) | a modification of the max pooling operation that aims to retain more information by considering overlapping regions. Specifically, the feature map is divided into strips, where each strip has a fixed width and variable height. Within each strip, the maximum value is taken as usual, but instead of selecting only one maximum value per strip, multiple maxima can be selected. This allows the network to retain more information about the spatial distribution of the features within each strip. | [1] | image classification, object detection tasks |
| max pooling | the feature map is divided into non-overlapping regions and the maximum value of each region is taken as the output. This process reduces the spatial dimension of the feature map, which can be useful for down-sampling and increasing the receptive field of subsequent layers. However, the information contained in the regions that are not selected can be lost. |  |  |
| Attention mechanism module | inspired by the human ability to selectively attend to certain stimuli while ignoring others, it can be seen as a set of weights that are applied to the input, allowing the network to focus on specific parts of the input that are deemed more relevant for the task at hand. These weights are learned during the training process, and can be interpreted as a measure of the importance of each input feature. | [1] | additive attention, multiplicative attention, self-attention |
| Image Thinning (or Skeletonization) | where binary image transformed into simplified representation with preservation of characteristics of shapes on an image. result is the set of curves or lines that represent the central axis or skeleton of objects. Goal ⇒ reduce complexity. involves applying sequence of morphological operations (ie erosion and dilation). Can either be medial axis-based or distance transform-based. | [1] |  |
| Preprocessing | a data preparation step that involves transforming raw data into a format that is suitable for analysis or machine learning algorithms. It typically involves several steps such as cleaning, transforming, and normalizing data. | [1] |  |
| Binarization | the process of converting a grayscale or color image to a binary image, which consists of only black and white pixels. Choose a threshold value that seperates the pixels into white (above) and black (below). | [1] | Extracting certain feature and simplifying images |
| Morphological Transformations | a type of image processing operation that are commonly used in computer vision and image analysis. These operations are based on the mathematical theory of morphology, which is concerned with the study of the shapes and structures of objects. |  | x-reflection, rotation |
| Gradient Descent | an optimization algorithm that is commonly used to minimize the cost or loss function in machine learning and deep learning models. It works by iteratively adjusting the parameters of the model in the direction of steepest descent of the cost function. | [1] |  |
| Class imbalance | refers to a situation where the distribution of classes in the training data is uneven, with one or more classes having significantly fewer examples than others. This can pose a challenge for machine learning algorithms because they may have a tendency to predict the majority class more frequently, leading to poor performance on the minority class |  | binary classification problem where positive class occurs only 10% of time in training data, resulting in tendency to predict negative class over positive. |
| residual structure | neural net that uses skip connection |  |  |
| Convolutional Kernel (filter, feature detector) | matrix of numbers that is used to extract features from an image. |  | used in CNN’s |
| Semantic Segmentation | CV technique involving labelling every pixel in an image with a class label, such as road, sky, building, person, etc |  [2]| uses CNN with larrge dataset. architectures include Fully Convolutional Networks (FCNs), U-Net, SegNet, and Mask R-CNN |
| offline histogram-based model | Applying a graphical representation of the distribution of pixel intensities in the image before applying a filter. it is "offline" because the histogram is only computed once in the entire process, thus making it computationally efficient.| [2] | |
|Batch Normalization|A technique to improve stability and convergence of CNN training by normalizing the input of each layer to have zero mean and unit variance, and then scaling and shifting the normalized values using learnable parameters.| [2]| |
| Rectified Linear Unit (ReLu) layers | an activation function commonly used in neural nets within layers. a simple threshold, setting any negative values to zero and elaving positive values. popular for simplicity and effectiveness. help introduce non-linearity and increase the expressiveness of the model. | [2] |  |
| Downsampling | A technique used in machine learning to reduce the dataset size by randomly removing samples without significantly impacting model training quality | [2] ||
|Common Objects in Context (COCO) Dataset|A large-scale image recognition, segmentation, and captioning dataset that is commonly used for training and evaluating computer vision models. The dataset contains over 330,000 images with more than 2.5 million object instances labeled with 80 different object categories, such as people, animals, vehicles, furniture, and more.| [2] ||
|YOLOv3 | a real time object detection algorithm to classify and detect objects in images/videos. Uses a single neural network architecture that take a single image and outputs the bounding box predictions along with class probabilities. | [4] ||
||||