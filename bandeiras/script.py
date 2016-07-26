while True:
	try:
		uf = input()
		src = input()
		print("UPDATE Estado SET bandeira=\"", end="")
		print(src, end="")
		print("\" WHERE uf=\"", end="")
		print(uf, end="")
		print("\";")
	except:
		break
