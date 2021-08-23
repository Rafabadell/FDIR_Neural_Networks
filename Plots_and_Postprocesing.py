import numpy as np
import matplotlib.pyplot as plt
def Data_Signals_plot(Data):
    G1=Data[:,0]
    G2=Data[:,1]
    G3=Data[:,2]
    G4=Data[:,3]
    G5=Data[:,4]
    G6=Data[:,5]
    R1=Data[:,6]
    R2=Data[:,7]
    R3=Data[:,8]
    R4=Data[:,9]
    T=np.linspace(1,len(G1),len(G1))

    fig, axs = plt.subplots(2)
    axs[0].plot(T,G1,label='Gyro 1')
    axs[0].plot(T,G2,label='Gyro 2')
    axs[0].plot(T,G3,label='Gyro 3')
    axs[0].plot(T,G4,label='Gyro 4')
    axs[0].plot(T,G5,label='Gyro 5')
    axs[0].plot(T,G6,label='Gyro 6')
    axs[0].grid('true')
    axs[0].legend(loc='lower right')

    axs[1].plot(T,R1,label='ReWh 1')
    axs[1].plot(T,R2,label='ReWh 2')
    axs[1].plot(T,R3,label='ReWh 3')
    axs[1].plot(T,R4,label='ReWh 4')
    axs[1].grid('true')
    axs[1].legend(loc='lower right')

def Predictions_plot(Pred,itemnum):
    plt.bar(np.linspace(1,len(Pred),len(Pred)),Pred)
    plt.text(np.argmax(Pred),np.max(Pred), 'Label: '+str(np.argmax(Pred))+', Propability: '+str(np.max(Pred)), fontsize=12)
    plt.grid(True)
    plt.xlim([0, len(Pred)])
    plt.ylabel('Probability')
    plt.title('Probabiblity predictions for test case number '+str(itemnum))