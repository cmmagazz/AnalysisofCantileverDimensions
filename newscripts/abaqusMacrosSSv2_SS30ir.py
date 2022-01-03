# -*- coding: mbcs -*-
# Do not delete the following import lines
#from abaqus import *
from abaqusConstants import *
import __main__
import section
import csv
import regionToolset
import displayGroupMdbToolset as dgm
import part
import material
import assembly
import step
import interaction
import load
import mesh
import optimization
import job
import sketch
import visualization
import xyPlot
import displayGroupOdbToolset as dgo
import connectorBehavior
import numpy as np
import os
os.chdir(r"E:\Users\CM_Temp")
mdb=openMdb(
    pathName='Z:/CM/ABAQUS/InUse/Foil2_PC/varthickness/uhcfcantilever_30ir_for70_50_sqpaddle350x1200_postmeas.cae')
# with open('Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/foil4-3n4Data/foil4-3n4postcalib.csv', 'r') as f:
# 	l = [[float(num) for num in line.split(',')] for line in f]
with open('Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\dimensionstotest_PC3.csv', 'r') as f:
 	l = [[float(num) for num in line.split(',')] for line in f]
l=np.asarray(l)
#print(l)
for i in range(0, 10):
    print('Run %d' %i)
    lengtht=55+i*3
    print('thickness= %1.3f' %lengtht)
    p = mdb.models['Model-1'].parts['Part-1']
    s = p.features['Solid extrude-1'].sketch
    mdb.models['Model-1'].ConstrainedSketch(name='__edit__', objectToCopy=s)
    s=mdb.models['Model-1'].sketches['__edit__']
    p = mdb.models['Model-1'].parts['Part-1']
    p.features['Solid extrude-1'].setValues(sketch=s)
    p.regenerate()
    p = mdb.models['Model-1'].parts['Part-1']
    p.features['Solid extrude-1'].setValues(depth=lengtht*1e-06)
    p.regenerate()
    c = p.cells
    pickedRegions = c.getSequenceFromMask(mask=('[#1 ]', ), )
    p.deleteMesh(regions=pickedRegions)
    p = mdb.models['Model-1'].parts['Part-1']
    p.seedPart(size=1.0e-05, deviationFactor=0.1, minSizeFactor=0.1)
    p.generateMesh()
    c = p.cells
    cells = c.getSequenceFromMask(mask=('[#1 ]', ), )
    region = regionToolset.Region(cells=cells)
    p.Set(cells=cells, name='all')
    p = mdb.models['Model-1'].parts['Part-2']
    p.features['Solid extrude-1'].setValues(depth=lengtht*1e-06)
    p.regenerate()
    p.seedPart(size=1.4e-05, deviationFactor=0.1, minSizeFactor=0.1)
    p.generateMesh()
    a = mdb.models['Model-1'].rootAssembly
    a.regenerate() 
    for amp in range(15,21,5):
        amp1=int(amp)+0.0
        mdb.models['Model-1'].boundaryConditions['SteadyStateOscillating'].setValues(u3=amp1*1e-06+0j)
        nam='%d_%d' %(lengtht,amp)
        print(nam)
        mdb.jobs.changeKey(fromName='SS30ir_for', toName='SS30ir_for%s' %nam)
        mdb.jobs['SS30ir_for%s' %nam].setValues(numCpus=3,numDomains=3)
        mdb.jobs['SS30ir_for%s' %nam].writeInput(consistencyChecking=OFF)
        mdb.jobs['SS30ir_for%s' %nam].waitForCompletion()
        mdb.jobs.changeKey(fromName='SS30ir_for%s' %nam, toName='SS30ir_for')
        
        