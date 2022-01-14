import numpy as np
def generate_classes():
    # Initialize matrices
    Gyros = np.zeros(6)
    ReWhe = np.zeros(4)
    # Thrus = np.zeros(8)

    # Compute total number of combinations for a maximum of two failures per system (combination =exactly 0 + exactly 1  +exactly 2 failed)
    GyroLen=Gyros.__len__()
    ReWheLen=ReWhe.__len__()
    GyroComb = 1 + GyroLen + (GyroLen*(GyroLen-1))/2; # 1(no failure)+n(anyone failed)+n*(n-1)/2(Nc2 any two failed)
    #for sumval in range(Gyros.__len__()):
        #GyroComb = GyroComb + sumval
    ReWheComb = 1 + ReWheLen + (ReWheLen*(ReWheLen-1))/2; # 1(no failure)+n(anyone failed)+n*(n-1)/2(Nc2 any two failed)
    #for sumval in range(ReWhe.__len__():
        #ReWheComb = ReWheComb + sumval
    # ThrusComb = 1 + Thrus.__len__()
    # for sumval in range(Thrus.__len__()):
    #     ThrusComb = ThrusComb + sumval

    TotalComb=GyroComb*ReWheComb#+ThrusComb

    # Generate and label the posible combinations
    GC=np.zeros([GyroComb,Gyros.__len__()])
    idx=0
    idx1=0
    idx2=1
    for count in range(GyroComb):
        if ((count+1) > (Gyros.__len__() + 1)):
            Gyros[Gyros.nonzero()] = 0
            Gyros[idx1] = 1
            Gyros[idx2] = 1
            if idx2 == (Gyros.__len__()-1):
                idx1=idx1+1
                idx2=idx1+1
            else:
                idx2=idx2+1
        elif ((count+1) > 1):
            Gyros[Gyros.nonzero()] = 0
            Gyros[idx]=1
            idx=idx+1
        GC[count,:]=Gyros
        # print(Gyros)
    generate_classes
    RC=np.zeros([ReWheComb,ReWhe.__len__()])
    idx=0
    idx1=0
    idx2=1
    for count in range(ReWheComb):
        if ((count+1) > (ReWhe.__len__() + 1)):
            ReWhe[ReWhe.nonzero()] = 0
            ReWhe[idx1] = 1
            ReWhe[idx2] = 1
            if idx2 == (ReWhe.__len__()-1):
                idx1=idx1+1
                idx2=idx1+1
            else:
                idx2=idx2+1
        elif ((count+1) > 1):
            ReWhe[ReWhe.nonzero()] = 0
            ReWhe[idx]=1
            idx=idx+1
        RC[count,:]=ReWhe
        # print(ReWhe)
    count = 0
    TC=np.zeros([TotalComb,(Gyros.__len__()+ReWhe.__len__())])
    for G in GC:
        for R in RC:
            TC[count, 0:Gyros.__len__()]=G
            TC[count, (Gyros.__len__()):]=R
            # print(TC[count, :])
            count=count+1

    return TotalComb, TC
