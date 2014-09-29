import math
import os

list = []
for i in range(200):
	rad = math.pi*i/100
	list.append(rad)
	#print (rad, end = ', ')

res = map(math.sin, list)

fd = open("../rtl/sine.dat", 'w')
for i in res:
	#dat = hex(int(((i+1)*100)))
	dat = hex(int(((i+1)*499999)))
	print (dat)
	fd.write(dat+'\n')

fd.close()

