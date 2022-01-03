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
    pathName='Z:/CM/ABAQUS/InUse/Foil7t11/parametric/uhcfcantilever_33parastiff.cae')
# with open('Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/foil4-3n4Data/foil4-3n4postcalib.csv', 'r') as f:
# 	l = [[float(num) for num in line.split(',')] for line in f]
#with open('Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/foil7t11/foils7-11dimsonlya2t.csv', 'r') as f:
# 	l = [[float(num) for num in line.split(',')] for line in f]
with open('Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/foil7t11/dimensionstotest_PC3.csv', 'r') as f:
 	l = [[float(num) for num in line.split(',')] for line in f]
l=np.asarray(l)
#print(l)

for i in [ 3,8,27,51,52,77]:#range(0, len(l)):
    print('Run %d' %i)
    lengthA=l[i,0]
    lengthB=l[i,1]
    lengthC=l[i,2]
    lengthD=l[i,3]
    lengthE=l[i,4]
    lengtht=l[i,5]
    print('length A = %1.3f' %lengthA)
    print('length B = %1.3f' %lengthB)
    print('length C = %1.3f' %lengthC)
    print('length D = %1.3f' %lengthD)
    print('length E = %1.3f' %lengthE)
    print('thickness= %1.3f' %lengtht)
    p = mdb.models['Model-1'].parts['Part-1']
    s = p.features['Solid extrude-1'].sketch
    mdb.models['Model-1'].ConstrainedSketch(name='__edit__', objectToCopy=s)
    s=mdb.models['Model-1'].sketches['__edit__']
    s.parameters['dimensions_57'].setValues(expression='1e-6*%1.3f'%lengthA)
    s.parameters['dimensions_61'].setValues(expression='1e-6*%1.3f'%lengthB)
    s.parameters['dimensions_62'].setValues(expression='1e-6*%1.3f'%lengthC)
    s.parameters['dimensions_53'].setValues(expression='1e-6*%1.3f'%lengthD)
    s.parameters['dimensions_59'].setValues(expression='1e-6*%1.3f'%lengthE)
    p = mdb.models['Model-1'].parts['Part-1']
    p.features['Solid extrude-1'].setValues(sketch=s)
    p.regenerate()
    p.features['Solid extrude-1'].setValues(depth=lengtht*1e-06)
    p.regenerate()
    c = p.cells
    pickedRegions = c.getSequenceFromMask(mask=('[#f ]', ), )
    p.deleteMesh(regions=pickedRegions)
    seeddens=lengtht*0.058*1.0e-5; 
    p.seedPart(size=seeddens, deviationFactor=0.1, minSizeFactor=0.1)
    p = mdb.models['Model-1'].parts['Part-1']
    p.setMeshControls(regions=pickedRegions, algorithm=MEDIAL_AXIS)
    p.generateMesh()
    c = p.cells
    cells = c.getSequenceFromMask(mask=('[#f ]', ), )
    region = regionToolset.Region(cells=cells)
    p.Set(cells=cells, name='all')
    v = p.vertices
    verts = v.getSequenceFromMask(mask=('[#2 ]', ), )
    p.Set(vertices=verts, name='highstressgeom')
    verts = v.getSequenceFromMask(mask=('[#1 ]', ), )
    p.Set(vertices=verts, name='measuredispnodes')
    #p.SectionAssignment(region=region, sectionName='Section-1', offset=0.0, offsetType=MIDDLE_SURFACE, offsetField='', thicknessAssignment=FROM_SECTION)
    p = mdb.models['Model-1'].parts['Part-2']
    p.features['Solid extrude-1'].setValues(depth=lengtht*1e-06)
    p.regenerate()
    seeddens=lengtht*0.05*1.0e-5; 
    p.seedPart(size=seeddens, deviationFactor=0.1, minSizeFactor=0.1)
    p.generateMesh()
    a = mdb.models['Model-1'].rootAssembly
    a.regenerate() 
    region = a.instances['Part-1-1'].sets['highstressgeom']
    mdb.models['Model-1'].loads['Load-1'].setValues(region=region, cf3=-0.002, distributionType=UNIFORM, field='')
    nam='%d_%d_%d_%d_%d_%d' %(lengthA, lengthB, lengthC, lengthD, lengthE, lengtht)
    print(nam)
    mdb.jobs.changeKey(fromName='stiff33ir_for', toName='stiff33ir_for%s' %nam)
    mdb.jobs['stiff33ir_for%s' %nam].setValues(numCpus=3,numDomains=3)
    mdb.jobs['stiff33ir_for%s' %nam].writeInput(consistencyChecking=OFF)
    mdb.jobs['stiff33ir_for%s' %nam].waitForCompletion()
    mdb.jobs.changeKey(fromName='stiff33ir_for%s' %nam, toName='stiff33ir_for')

