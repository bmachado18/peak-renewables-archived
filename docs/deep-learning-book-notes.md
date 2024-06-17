**Quick notes from deep-learning-book.org**

https://www.deeplearningbook.org/

## Chapter 1: Using NN's to recognize handwritten digits
- easy for humans to recognize digits
- we carry a super computer in our heads, tuned bu evolution over hundreds and millions of years
- humans are supesndously and astoundingly good at making sense of what our eyes show us
- simple intuitions about how we recognize shapes turn out not to be so simple to express algorithmically
- neural nets approach the problem a different way. Idea => take a large number of handwritten digits, known as training examples
- then develope system which can learn from training examples
- handwritten recognition is a good prototype because its challenging but not so difficult in computational complexity

### perceptrons
- perceptron => type of neuron
- main neuron model is called sigmoid neuron
- sigmoid neuron built off perceptrons
- perceptron takes several binary inputs and produces a single binary output
- each inputs edge into the perceptrons has a corresponding weight associated with it
- weights = real number expressing the important of the respective inputs to the output
- the neurons output is determined by wether the weighted sum of inputs times weights is elss than some threshold
- threshold is a real number which is a parameter of the neuron
- by varying different weights and thresholds, we can get different models of decision-making
- in a more complex network, the next layer of perceptrons is making a decision by weighing up the results from the previous layer.
- even more complex discisions can be made by the last couple layers
- each neuron does no have multiple outputs, just one output that feeds as multiple inputs to the next layers neurons
- the bias is essential the negative of the threshold. moved to the other side of the equation
- bias => measure of how easy it is t get the perceptron to output a 1
- in biological terms, the bias is a measure of how easy it is to get the perceptrons to fire
- if bias is super negative, then its difficult for the perceptron to output a 1
- bias => thresholid
- can use networks of perceptrons to compute any logical function
- if the same input is used twice for one perceptrons, can just combine into one input with the weights added.
- can devise learning algorithms to automatically tune the weights and biases of the network of artificial neurons
- tuning can happen in response to external stimuli, without direct intervention by a programmer

### Sigmoid Neurons
- suppose we like to learn to solve a problem, ieL inputs of network might be raw pixel data from handwritten image of a digit.
- say wed liek the network to learn the wieghts and biases so that the output correctly classifies the digit
- to see how it will work, suppose we make a small change in some weight or bias in the network
- wed like the small change to cause only a small corresponding change in the output from the network
- if it were true, then we could modify the weights and biases of the network to behave more in the manner we want
- suppose the network mistakenly classifyied an image 8 where it should be nine
- we could figure out how to make a small change in the weights and biases so network gets a little closer to classifying the image as 9.
- if we repeat this over and over, the network would improve at producing a better and better output. this is learning
- the problem is this doesnt happen when the networ kcontains perceptrons
- in fact, a small change in wieghts or bias of any single e perceptron in the network can cause the output of the perceptron to completely flip, from 0 to 1.
- that flip may cause the rest of the network to completely change in some very complicated way
- so while 0 might now be classified correctly, the behaviour for other image is likely to have compltely changed
- that makes it difficult to gradually modify the weights and biases
- there mgiht be a clever way to getting around this problem
- we can overcome this problem by introducing sigmoid neurons
- similiar to perceptrons, sigmoid neurons are modified so small changes in their weights and bias cuase only a small chang ein their output
- diagram of sigmoid neuron is identical to perceptron, but instead the inputs can take on any value between 0 and 1.
- sigmoid neuron has weights for each input, and a single bias b
- sigmoid sometimes called logistic function
- algebriacly, the sigmoid function is defined as a 1/ (1 + e^-z).
- for the output of a sigmoid neurons: 1/(1-exp(-sum(w*x) - b))
- algevriac form of sigmoid function seems opaque, but perceptron and sigmoid neurons very similiar. it is a true barrier to understanding

- the shape of the sigmoid function when plotted is a curved line, essentially a smoothed out version of the step function.
- if sigma was a step function, the sgmoid neuron would be a perceptron, since the output would be 1 or 0 wether the inputs, weights + bias was positive or negative
- the smoothness of sigma function means small changes in all of the weights of the input and change in bias will produce small changes in the output
- for calculus, the output is well approximated by the sum of partial derivatives of the output with respect to the weights times the change in weights plus the partial derivative of the output with respect to the bias times the change in bias
- this reresentation says the change in output is a linear function of the changes in weight and bias.
- this linearity makes it easy to choose small changes in weights and biases to achieve any desired small change in th eoutputthis makes it much easier to figure out how changing the weights and biases will change the output
- later in the book, will consider neurons where the output is a function of w dot product with input plis biases for some activiation function.
- main thing that changes when we use a different activation function is that the particular values for the partial derivatives in the previous equation change
- sigma function is commonly used to work on neural nets and is the most common activation function is in book, because simply exponential have some lovely properties when differentiated.
- how should I interpret the outputs of sigmoid neurons?
- since they can be between 0 and 1, values can be useful. because ie if we want to use the output values to represent average pixel intensity in an image input to the neural network.
- sometimes can be a nuisance tho, because suppose we want the output to indicate "the input image is 9" or "the input image is not a 9". 
- it would be easy as a perceptron (0 or 1) but in pracice we can set up a convention to deal with this.
- can use a convention to deal with this by deciding to interpret any output of at least 0.5 as indicating a 9, and indicating and output less than 0.5 as not a 9.
  
### The architecture of neural networks

- will introduce a neural net that can do a good job classifying handwritten digits
- terminology is important
- leftmost layer is called the input layer.
- neurons within the input layer are called input neurons
- the rightmost or output layer cotnains output neurons
- the middle layers are called the hidden layers, meaning not and input or an output
- something that can be confusing is the multiple layer networks are sometimes called multilayer perceptrons or MLP's, despite being made up of sgmoid neurons, not perceptrons.
- a natural way to design the network is to encode the intensities of the image pixels into the input neurons.
- if the image is a 64x64 grayscale image, then we would have 64x64=4,096 input neurons, with the intensities scaled appropriately between 0 and 1.
- there can be quite an art to design the hidden layers
- in particular, its not possible to sum up the design process for hidden lyers with a simple urle of thumb
- instead, neural net researchers have developed many design heuristics for hidden layers which help people get the behaviour they want out of their nets
- for example, such heuristics can be used ot help determine how to trade off the number of hidden layers against the time required to train the network
- this book will go over several such design heuristics
- neural networks where the output of one layer is used to input the next layer are called feedforward neural networks
- meaning there are no loops in the network - information is always fed forward, and never fed back
- there are other models of artificial neural nets in which feedback loops are possible, called recurrent neural networks
- idea is to have neurons which fire for some limited udration of time ebfore becoming quiescent.
- the firing can stimulate other neurons which might fire a bit later, and for limited duration
- that causes more neurons to fire still, so over time there will be a cascade of neurons firing
- loops don't cause problems because a neurons output only affects its inputs at some later time, and not instantaneously
- recurrent neural nets less influential than feedforward networks because learning algorithms are less powerful
- much closer to how our brains work
- possible for reccurrrent networks to solve certain problems

### a simple network to classify handwritten digits
- can split the recognizing handwritten digits into two sub-problems
- first, need a way to break an image containg many digits into a sequence of separate images, ie break the image 504192 into six seperate images
- humans solve the segmentation problem with ease, but its challenging for computer program to correctly break up the image
- once the image has been segmented, the program needs to classify each individual digit
- for instance, need the program to recognize that a handwritten five is a 5
- focus on solving the second problem, because it turns out the the segmentation problem is not so difficult to solve once you have a good way to classify the individual digits
- one approach to segmentation problem is to trial many different ways of segmenting the image using the individual digit classifier to score each trial segmentation
- trial segmentation gets a high score if the individual digit classifier is confident of its classification in all segments, and a low score if classifier is having lots of troulbe
- idea is that the classifier is having trouble somewhere because the semgnetation has been chosen incorrectly

- will use a three-layers neurla networks to recognize individual digits
- where input layers has 784 neurons (28x28 image), the hiddenlayer has 15 neurons, and the output layer has 10 neurons, labelled from 0 to 9
- the input layer of the network contains neurons ecnoding the vlaues of the input pixel
- the input pixels are greuscale, witha  value of 0.0 representing white, and a value of 1.0 representing black, and in ebtween values representing gradual darkening shades of gray
- denote the number of neurons in hidden layer as n, where n = 15
- output contains 10 neurons
- the neuron with the highest activation value is the classified digit
- might think that can just use 4 output neuron of binary values
- should be enough since 2^4 = 16
- the justification for the network design is empirical; we can try both network designs.
- turns out the 10 output neurons are better at learning that the 4 output neurons
- but why? is there some heuristic to tell us in advanced?
- helps to think about what the neural network is doing from first principles
- consider first case where we use 10 output neurons.
- focus on trying to decide weather or not the digit is a 0.
- it is done by wieghing up evidence from the hidden layer of neurons
- what are those neurons doing?
- suppose for sake of argument that the first neuron in hidden layer detects the image is a the top left curve of the digit 0.
- this can be done by heavily weighting input pixels which overlap with the image, and only lightly weighting the other inputs
- in a similar way, suppose the next couple neurons respresent other shapes and edge that make up a zero.
- if all  those four hidden neurons are firing then we can conclude that the digit is a 0
- of course thats not the only evidence, since we could get 0 in other ways, ie: slight distortion, translations, but seems safe to say its 0
- suppose neural net function this way.then we can give a plausible explanation for why its better to have 10 output rather than 4.
- if we had 4 outputs, then the first output neuron would be trying to decide what the most significant bit of the digit was
- theres no easy way to relate that most significant bit to simple shapes
- its hard to imagine any good historical reason the component shape of the digit will be closely related to the most significant bit o fthe outut
  
- just a heuristic; nothing says the network will operate in the way above.
- maybe a clever learning algorithm will find some assignment of weights that lets us use only 4 output neurons
- however this heuristic will work pretty well, and can save alot of time in designing good neural network architectures

### Learning with gradient descent
- now that the design is in place, how can it learn?
- first thing needed is a dataset to learn from, a so-called training dataset
- we'll use the MNIST data set, containg tens of thousands of scanned images of handwritten digits
- comes in two parts: the 60,000 images to be used in the training dataset, which comes from handwriting samples from 250 people.
- the second part of the dataset is 10.000 images to be used as test data.
- use the test data to evaluate how well the neural network has learned to recognize digits.
- to make good test performance, the test data was taken from a different set of 250 people that the training data.
- helps give confidence that the system can recognize digits from people whose writing ti didn't see during training
- x will denote the training input, as 28x28= 784 dimensional vector
- each entry in the vector represents the gray value for a single pixel
- output y is a 10-dimensional vector. where y = y(x)
- ie if training image depict 6, where x is the input, then y(x) = (0, 0, 0 ,0 ,0 , 1, 0 ,0 ,0)^transpose is the desired output fomr the network
- we need an algorithm to find the weights and biases so that the output from the network approximates y(x) for all training inputs x.
- the cost function, or referred to as the loss or objective function, quantifies this goal.
- can be described as the sum of the squared magntiude of vectorial difference between the obtained outputs and corresponding actual outputs, all over 2*(total number of training inputs)
- well call C(the cost function) the quadtratic cost function, or mean squared error (MSE).
- C(w,b) is non-negative
- C(w,b) becomes smaller and converges to 0 when y(x) is approximately equal to our output a, for all training inputs.
- therefor the training algorithm does a good job if it can find the weights and biases so that C(w,b) converges to 0.
- not doing so well if C(w,b) is large
- the aim of our training algo is to minimize the cost C(w,b) as function of weights and biases
- done via an algorthim called gradient descent
  
- need to introduce quadratic cost because then we get a smooth function, making it easy to figure out how exactly to make small changes in the weights and biases to get an improvement in the cost. (minimize it!)
- because just trying to maximize the correctly classified images is not a smooth function, and won't correctly tune all paths

- lets suppose we try to minimze some cost function C(v)
- we like to find where C achieves its global minimum of the plot
- one way is to use calculus to try and find the minimum analytically.
-  can compute derivaites and the try using to find places where C is an extrem
-  sadly itll turn into a nightmare when we have more variables
-  analogy of algo: if we think of the function as a valley, imagine a ball rolling down the slope of the valley.
-  the ball should eventually roll down the slope of the valley
-  can we use this idea as a way to find the min?
-  think about randomly choose a starting point for the ball, and simulate the motion of the ball as it rolled down to the bottom
-  can do this simulation simply by computing derivaites of C, where these derivaite tell us about the local shape of the valley, therefor telling how the ball should roll
-  I'm going to skip the mathematically representation

- several things can go wrong that prevent gradient descent from finding the global min of C, but in practice gradient descent works well in neural nets to minimize the cost function

### Implementing our network to classify digits

- actually going to split the 60,000 training datatset into 50,000 images, and 10,000 validation set
- this set is useful in figuring out how to set certain hyper-parameters of the network, like learning rate

class Network(object):

    def __init__(self, sizes):
        self.num_layers = len(sizes)
        self.sizes = sizes
        self.biases = [np.random.randn(y, 1) for y in sizes[1:]]
        self.weights = [np.random.randn(y,x) for x,y in zip (sizes[:-1], sizes[1:])]

- list sizes contains the number of enurons in the respectives layers
- ie if we want to create a network object with two neurons in the first layer, and 3 neurons in the second layer, and 1 neuron in the final layer, do:

net = Network([2,3,1])

- the biases and weightsand randomly initialized using np.random.randn to generate gaussian distributions with mean 0 and standard eviation 1.
- this random initialization gives our stochastic gradient descent algorithm a place to start fom
- This algorthm assums that the input layer is the first layer, and omits the biases for any of the first layer neurons because the biases are only ever used in computing the outputs from later layers
- note that the biases and weights are stored as lists of numpy matrices
- ie: net.weights[1] is a matrix storing the weights connecting the second and third layers of neurons
- since net.weights[1] is rather verbose, denote that matrix w. its a matrix such the w_jk is the weight for the connection between the kth neuron in the second layer and the jth neuron in the third layer.
- this ordering may seem strange, but the advanatage is that using this ordering is that i means the vector activations of the hird layer of the nurons is: a' = sigma(wa + b)
- where a is the vector of activations of the second layer
- w is weight matrix, and b is the vector of biases in the second layer
- sigma is a sigmoid function elementwise on each vector
  
def sigmoid(z):
    return 1.0/(1.0 + np.exp(-z))

def feedforward(self, a):
    """Return the output of the network if "a" is input"""
    for b, w in zip(self.biases, self.weights):
        a = sigmoid(np.dot(w, a)+ b)
    return a

- this method just apply the sigmoid function to all layers of the network, given an input a, and returns the output of the network

for learning, an SGD method implements stochastic gradient descent

def SGD(self, training_data, epochs, mini_batch_size, eta, test_data=None):
    """Train the neural network using mini-btach stochastic gradient descent. The "training_data" is a list of tuples "(x, y)"
    representing the training inputs and the desired outputs. The other non-optional parameters are self-explanatory. If 
    "test_data" is provided then the network will be evaluated against the test data after each epoch, and partial progress printed out.
    It is useful for tracking progress, but slows thing down substantially.
    """
    if test_data: n_test = len(test_data)
    n = len(training_data)
    for j in xrange(epochs):
    random.shuffle(training_data)
    mini_batches = [
        training_data[k:k+mini_batch_size]
        for k in xrange(0, n, mini_batch_size)
    ]
    for mini_batch in mini_batches:
        self.update_mini_batch(mini_batch, eta)
    if test_data:
        print "Epoch {0}: {1} / {2}".format(j, self.evaluate(test_data), n_test)
    else:
        print "Epoch {0} complete".format(j)


- epochs: number of epochs to train for
- mini_batch_size: size of mini-batches to use when sampling
- eta: learning rate n
- works like so: in each epoch, it starts by randomly shuffling the training data, then partitions it into mini-batches of the appropriate size
- this is an easy way of sampling randomly from the training data
- then for each mini-batch we apply a single step of gradient descent
- self,update_mini_batch() updates the network weights and biases according to a single iteration of gradient descent. using just the training data in mini_batch

def update_mini_batch(self, mini_batch, eta):
    """Update the network's weights and biases by applying gradient descent using backpropagation to a single mini batch. The "mini_batch" is just a list of tuples "(x, y)", and "eta" is the learning rate.
    """
    nabla_b = [np.zeros(b.shape) for b in self.biases]
    nabla_w = [np.zeros(w.shape) for w in self.weights]
    for x, y in mini_batch:
        delta_nabla_b, delta_nabla_w = self.backprop(x, y) # WHERE MOST OF THE WORK IS DONE

        nabla_b = [nb + dnb for nb, dnb in zip(nabla_b, delta_nabla_b)]
        nabla_w = [nw+dnw for nw, dnw in zip(nabla_w, delta_nabla, w)]
    self.weights = [w-(eta/len(mini_batch))*nw for w, nw in zip(self.weights, nabla_w)]
    self.biases = [b - (eta/len(mini_batch))*nb for b, nb in zip(self.biases, nabla_b)]

- all the work is done in the backprop line
- this invokes the backpropogation algorithm, which is a fast way of computing the gradient of the cost function
- not going to show code fo self.backprop right now since will study in next chapter
- just assume it bheaves as claimed, returning the appropriate gradient for the cost associated to the training example x
- 

other functions needed for backprop are sigmoid_prime() and self.cost_deriviative

theres a repo of the code

- poeple routinely train networks with 5 to 10 hidden layers
- performing far better than shallow neural networks
- 