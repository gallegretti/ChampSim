import sys
import matplotlib.pyplot as plt
import numpy as np
import re
from os import listdir
from os.path import isfile, join

def readFile(filePath):
    with open(filePath, 'r') as file:
        dic = {}
        data = file.read()
        dic['traceFile'] = re.findall(r'TRACE_(\d+).(.*)-', filePath)[0][1]
        result = re.findall(r'Finished CPU (\d+) instructions: (\d+) cycles: (\d+) cumulative IPC: ((\d+).(\d+))', data)
        dic['totalInstruction'] = float(result[0][1])
        dic['totalCycles'] = float(result[0][2])
        dic['cumulativeIPC'] = float(result[0][3])
        result = re.findall(r'Prediction Accuracy: ((\d+).(\d+))', data)
        dic['bpAccuracy'] = float(result[0][0]) / 100

        # Specific for prefetcher
        iptSize = re.findall(r'ipt_(\d+)', filePath)
        if (iptSize):
            dic['iptSize'] = int(iptSize[0])
        return dic

def genericPlot(barWidth, allBars, allColors, allLabels, xlabel):    
    # Set position of bar on X axis
    r1 = np.arange(len(allBars[0]))
    allPositions = [r1]
    for i in range(1, len(allBars)):
        allPositions.append([x + barWidth for x in allPositions[i-1]])

    # Make the plot
    for i in range(len(allBars)):
        plt.bar(allPositions[i], allBars[i], color=allColors[i], width=barWidth, edgecolor='white', label=allLabels[i])
    
    plt.yscale('log')
    # Add xticks on the middle of the group bars
    plt.xlabel(xlabel, fontweight='bold')
    plt.xticks([r + barWidth for r in range(len(allBars[0]))], ['A', 'B', 'C', 'D', 'E'])

    # Create legend & Show graphic
    plt.legend()
    plt.show()

def prefetcherPlot(data):
    # Prefetcher
    iptSizes = sorted(set(map(lambda x : x['iptSize'], data)))
    traceFiles = list(set(map(lambda x : x['traceFile'], data)))
    labels = list(map(lambda x : str(x) + ' entries', iptSizes))

    iptBars = []
    for size in iptSizes:
        iptBars.append([])
        for trace in traceFiles:
            iptBars[len(iptBars) - 1].append(list(filter(lambda x : x['iptSize'] == size and x['traceFile'] == trace, data))[0]['totalCycles'])

    barWidth = 0.25
    allColors = [
        '#00876c',
        '#4b9d72',
        '#79b379',
        '#a5c983',
        '#d2dd91',
        '#fff1a3',
        '#fad082',
        '#f5ae68',
        '#ee8b58',
        '#e36651',
        '#d43d51'
    ]
    genericPlot(barWidth = barWidth, allBars = iptBars, allColors = allColors, allLabels = labels, xlabel = traceFiles[0])


def main():
    if len(sys.argv) != 3:
        print('Usage: [PATH] [PLOT_TYPE]')
        return

    path = sys.argv[1]
    plotType = sys.argv[2]
    resultFiles = [f for f in listdir(path) if isfile(join(path, f))]
    filesContent = []
    for file in resultFiles:
        filePath = path + '/' + file
        filesContent.append(readFile(filePath))

    if (plotType == 'prefetcher'):
        prefetcherPlot(filesContent)
    else:
        # Add plotters here
        print('Unknown plotter')

if __name__ == "__main__":
    main()