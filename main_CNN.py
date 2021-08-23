import tensorflow as tf
from tensorflow.keras import datasets, layers, models

# Helper libraries
import numpy as np
from Labels_and_classes import generate_classes
from Plots_and_Postprocesing import Predictions_plot, Data_Signals_plot
import matplotlib.pyplot as plt

# Preallocate data
TRN=1000                                 # Number of training data samples
TSN=100                                  # Number of testing data samples
train_labels = np.zeros([TRN])
train_data   = np.zeros([TRN,801, 10, 1])
test_labels  = np.zeros([TSN])
test_data    = np.zeros([TSN,801, 10, 1])

# Class names
Class_numb, Class_description = generate_classes()

# Load training data and labels
print('Loading training data...')
for i in range(TRN):
    lineNum = 0
    dummy_labels = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    with open ('Training_data\TR'+str(i+1)+'.txt','r') as df:
        for line in df:
            line_split = line.split()
            line_float = [float(item) for item in line_split]
            if lineNum < 3:
                dummy_labels =  [sum(x) for x in zip(dummy_labels, line_float[0:10])]# read
                lineNum = lineNum+1
            else:
                train_data[i,lineNum-3,:, 0] = line_float[0:10]
                lineNum = lineNum + 1
    df.close()
    train_labels[i]=Class_description.tolist().index(dummy_labels)
print('Training data loaded')

# Load testing data and labels
print('Loading testing data...')
for i in range(TSN):
    lineNum = 0
    dummy_labels = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    with open ('Test_data\TS'+str(i+1)+'.txt','r') as df:
        for line in df:
            line_split = line.split()
            line_float = [float(item) for item in line_split]
            if lineNum < 3:
                dummy_labels =  [sum(x) for x in zip(dummy_labels, line_float[0:10])]# read
                lineNum = lineNum+1
            else:
                test_data[i,lineNum-3,:, 0] = line_float[0:10]
                lineNum = lineNum + 1
    df.close()
    test_labels[i]=Class_description.tolist().index(dummy_labels)
print('Testing data loaded')

# Data_Signals_plot(train_data[997,:,:])
# Preprocessing data
print('Preprocessing data...')
for i in range(TRN):
    Gmin =train_data[i, :, :6].min()
    train_data[i, :, :6] = train_data[i, :, :6] - Gmin
    Rmin =train_data[i, :, 6:].min()
    train_data[i, :, 6:] = train_data[i, :, 6:] - Rmin
    Gmax=train_data[i, :, :6].max()
    train_data[i, :, :6] = train_data[i, :, :6] / Gmax
    Rmax=train_data[i, :, 6:].max()
    train_data[i, :, 6:] = train_data[i, :, 6:] / Rmax

for i in range(TSN):
    Gmin =test_data[i, :, :6].min()
    test_data[i, :, :6] = test_data[i, :, :6] - Gmin
    Rmin =test_data[i, :, 6:].min()
    test_data[i, :, 6:] = test_data[i, :, 6:] - Rmin
    Gmax=test_data[i, :, :6].max()
    test_data[i, :, :6] = test_data[i, :, :6] / Gmax
    Rmax=test_data[i, :, 6:].max()
    test_data[i, :, 6:] = test_data[i, :, 6:] / Rmax

print('Finished preprocessing data')

# Data_Signals_plot(train_data[997,:,:])
### Building the Model

print('Building the model')
# This model represents a CNN with a stack of Conv2D and MaxPooling2D layers followed by a few denesly connected layers.
# The idea is that the stack of convolutional and maxPooling layers extract the features from the data.
# Then these features are flattened and fed to densly connected layers that determine the class (type of failure scenario)
# based on the presence of features.
model = models.Sequential()
# **Layer 1**
# The input shape of our data will be 801, 10 and we will process 80 filters of size 10x1 over our input data.
# We will also apply the activation function relu to the output of each convolution operation.
model.add(layers.Conv2D(10, (100, 1), activation='relu', input_shape=(801, 10, 1)))
# **Layer 2**
# This layer will perform the max pooling operation using 2x2 samples and a stride of 2.
model.add(layers.MaxPooling2D((2, 1)))
# **Other Layers**
# The next set of layers do very similar things but take as input the feature map from the previous layer.
# They also increase the frequency of filters from 32 to 64.
# We can do this as our data shrinks in spacial dimensions as it passed through the layers, meaning we can afford (computationally) to add more depth.
model.add(layers.Conv2D(20, (50, 1), activation='relu'))
model.add(layers.MaxPooling2D((2, 1)))
model.add(layers.Conv2D(40, (25, 1), activation='relu'))

model.add(layers.Flatten())
model.add(layers.Dense(5000, activation='relu'))
model.add(layers.Dense(Class_numb, activation='softmax'))

# summary of the model
model.summary()
print('Model Built')

### Training the Model

#Define the loss function, optimizer and metrics we would like to track
model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])

# we pass the data, labels and epochs and train the model
history = model.fit(train_data, train_labels, epochs=30, validation_data=(test_data, test_labels))

## Evaluating the Model
test_loss, test_acc = model.evaluate(test_data,  test_labels, verbose=2)

print('Test accuracy:', test_acc)

### Making Prediction
predictions = model.predict(test_data)

#look at the predictions for case i
i = 37

Predictions_plot(predictions[i],i)
pred=np.argmax(predictions[i])
Corr=int(test_labels[i])
pr = [str(int(item)) for item in Class_description[pred]]
co = [str(int(item)) for item in Class_description[Corr]]
p=''
c=''
for i in range(len(Class_description[pred])):
    p = p +pr[i]
    c = c +co[i]
print('Prediction: '+p)
print('Correct   : '+c)
