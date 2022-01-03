import sys
from odbAccess import *
from abaqusConstants import*
from types import IntType
import numpy as np

# FILE TO RUN THROUGH ALL STEADYSTATE odb. Needs two system inputs as well: filepath and filename.


#sys.argv[0] = script name
filepath=sys.argv[1] #make sure this has the final backslash
filename=sys.argv[2] #make sure this DOESNT have the .odb


# desired name for the results file
results_name=filename+'maxstress'


#Opening the odb
odb = openOdb(filepath+filename+'.odb', readOnly=True)

#Initializing Arrays
DAT=[[0,0,0,0,0,0,0,0,0,0,0,0]]

#Step is SteadyState in this case

#Creating a for loop to iterate through all frames in the step
for x in odb.steps['SteadyState'].frames:
	#for every frame (frequency), find the following:
	#the frameValue (the testing freq), the maxstress, and the coordinates of the four corners of the paddle
	frameno=x.frameId
	#NEW METHOD - STRESS
	#NEWER METHOD BUT SLOW - getSubset
	frame=odb.steps['SteadyState'].frames[frameno]
	#start with stress
	stressesall=frame.fieldOutputs['S'] #define the entire stress fieldoutput#
	stress=np.empty((len(odb.rootAssembly.instances['PART-1-1'].elementSets['EDGEDE'].elements),1))
	for i in range(0,len(odb.rootAssembly.instances['PART-1-1'].elementSets['EDGEDE'].elements),1):
		elem = odb.rootAssembly.instances['PART-1-1'].elementSets['EDGEDE'].elements[i] #take the element in question
		stresselem = stressesall.getSubset(region=elem)
		stress[i]=stresselem.values[0].mises #doesn't need value specification, there's only 1 element. take mises
	#average across the entire neck
	avestress=np.average(stress,axis=0)
	# now go through the elements that define the set EDGE in order to get the X and Z locations, and just add them to the end.
	numel = 5
	firstel = int(len(odb.rootAssembly.instances['PART-1-1'].nodeSets['EDGE'].nodes)-numel)
	nodeslabelforcorners = [0]*numel
	originalcoordinates = np.empty((numel,2))
	deformedcoordinates = np.empty((numel,2))
	changeincoordinates = np.empty((numel,2))
	for y in range(firstel,len(odb.rootAssembly.instances['PART-1-1'].nodeSets['EDGE'].nodes)):
		nodeslabelforcorners[y-firstel]=odb.rootAssembly.instances['PART-1-1'].nodeSets['EDGE'].nodes[y].label
		originalcoordinates[y-firstel]=odb.rootAssembly.instances['PART-1-1'].nodeSets['EDGE'].nodes[y].coordinates[::2]
		deformedcoordinates[y-firstel]=odb.steps['SteadyState'].frames[frameno].fieldOutputs['U'].values[nodeslabelforcorners[y-firstel]-1].data[::2]
		changeincoordinates =deformedcoordinates-originalcoordinates
	positionof4corners=np.reshape(changeincoordinates, numel*2)
	temp=np.insert(positionof4corners,[0, 0],[[x.frameValue,avestress]])
	DAT=np.append(DAT, [temp], axis=0)
####Writing to a .csv file

np.savetxt(filepath+results_name+'.txt', DAT)
#Close the odb
odb.close()
