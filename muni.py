first = True
print("INSERT INTO Municipio VALUES", end = ' ')
while True:
	try:
		lista = input().split(';')
		if (first == False):
			print(",", end=' ')
		print("(", lista[0], ",", lista[1], "null,", lista[3], ")", end=' ')
		first = False
	except:
		break