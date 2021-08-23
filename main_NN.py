import tensorflow as tf
from tensorflow import keras

# Helper libraries
import numpy as np
from Labels_and_classes import generate_classes
from Plots_and_Postprocesing import Predictions_plot, Data_Signals_plot
import matplotlib.pyplot as plt

# Preallocate data
TRN=1000                                 # Number of training data samples
TSN=100                                  # Number of testing data samples
train_labels = np.zeros([TRN])
train_data   = np.zeros([TRN,801, 10])
test_labels  = np.zeros([TSN])
test_data    = np.zeros([TSN,801, 10])

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
                train_data[i,lineNum-3,:] = line_float[0:10]
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
                test_data[i,lineNum-3,:] = line_float[0:10]
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
# This model represents a feed-forward neural network (one that passes values from left to right)
model = keras.Sequential([
    #Reshape the input layer as a vector instead of matrix
    keras.layers.Flatten(input_shape=(801, 10)),                    # input layer (1)
    #First hidden layer is a densely conected 5000 relu neurons
    keras.layers.Dense(5300, activation='relu'),                 # hidden layer (2)
    #Second hidden layer is a densely conected 5000 relu neurons
    keras.layers.Dense(2600, activation='relu'),                 # hidden layer (2)
    #Output layer is 242 neurons (one per class) densely conected
    #Softmax --> Neuron values add up to one
    keras.layers.Dense(Class_numb, activation='softmax')            # output layer (3)
])
print('Model Built')

### Training the Model

#Define the loss function, optimizer and metrics we would like to track
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])
# we pass the data, labels and epochs and train the model
model.fit(train_data, train_labels, epochs=100)

## Evaluating the Model
test_loss, test_acc = model.evaluate(test_data,  test_labels, verbose=1)

print('Test accuracy:', test_acc)

### Making Prediction
predictions = model.predict(test_data)

#look at the predictions for case i
i = 97

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
