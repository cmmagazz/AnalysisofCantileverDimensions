import sys
from odbAccess import *
from abaqusConstants import*
from types import IntType
import numpy as np

# FILE TO RUN THROUGH ALL STIFFNESS odb. Needs two system inputs as well: filepath and filename.

#sys.argv[0] = script name
filepath=sys.argv[1] #make sure this has the final backslash
filename=sys.argv[2] #make sure this DOESNT have the .odb

# desired name for the results file
results_name=filename+'stiffness'

#Opening the odb
odb = openOdb(filepath+filename+'.odb', readOnly=True)

#Step is stiffness in this case
#session.odbs[name].parts[name].nodeSets[name] KEEPING THIS FOR POSTERITY
#odb.rootAssembly.instances['PART-1-1'].nodeSets['MEASUREDISPNODES']
#odb.steps['stiffness'].frames[1].fieldOutputs['RT'].values[1].instance.nodeSets
#odb.steps['stiffness'].frames[1].fieldOutputs['RT'].values[1].instances['PART-1-1'].nodeSets['MEASUREDISPNODES']

dat0=odb.steps['stiffness'].frames[1].fieldOutputs['U'].values[0].data[2]
dat1=odb.steps['stiffness'].frames[1].fieldOutputs['U'].values[1].data[2]
DAT=[dat0,dat1]

np.savetxt(filepath+results_name+'.txt', DAT)
#Close the odb
odb.close()
