start:
	kubectl apply -f manifestos/database
	kubectl apply -f manifestos/sistema
	kubectl apply -f manifestos/portal