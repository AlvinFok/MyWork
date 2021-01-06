#%%
import pandas as pd
dataFrame = pd.read_csv("order_brush_order.csv")
print(dataFrame.head())
#%%
data = dict()
for i in dataFrame.itertuples():
    if (i[2] in data.keys()):
        if (i[3] in data[i[2]]):
            data[i[2]][i[3]].append(i[4])
            if (len(data[i[2]][i[3]])):
                print(data[i[2]][i[3]])
        else:
            data[i[2]][i[3]] = [i[4]]
    else:
        data[i[2]] = {}

#print(data[93950878])


# %%
for shopid in data.keys():
    for userid in data[shopid]:
        for time in data[shopid][userid]:

        break


# %%
def more(timeList):
    for i in range(len(timeList)):
        