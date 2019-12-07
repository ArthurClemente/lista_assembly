.data 
	tamanho_lista: .asciiz "Informe o tamanho da lista: "
	zerol: .asciiz "Sua lista tem 0 elementos, escolha 1 para criar uma lista ou 2 para finalizar o programa!"
	negal: .asciiz "Por favor, somente valores positivos"
	op: .asciiz "Escolha > "
	greetgs: .asciiz "Bem Vindo, Escolha uma das op��es abaixo"
	
	opcao1: .asciiz "1 - Adicionar elemento "
	adcv: .asciiz "Qual valor deseja adicionar: "
	adcv2: .asciiz "Valor Inserido na lista!!"
	mql: .asciiz "Lista j� est� completa!!"		
	
	opcao2: .asciiz "2 - Recuperar elemento "
	rec: .asciiz "Posi��o do valor: "
	valr: .asciiz "Valor da posi��o solicitada: "
	posicm: .asciiz "Posi��o n�o encontrada na lista!!"
	posicme: .asciiz "Posi��o inv�lida!!"
	
	opcao3: .asciiz "3 - Imprimir lista "
	pos: .asciiz "� "
	sval: .asciiz "Sem valores, Inicie uma lista com a op��o 1"
	
	opcao4: .asciiz "4 - Deletar elemento "
	del: .asciiz "Qual posi��o deseja excluir: "
	vald: .asciiz "O valor foi exclu�do com sucesso!!"
	
	opcao5: .asciiz "5 - Sair"
	gb: .asciiz "Foi um prazer trabalhar com vo��!!"
	
	escolha: .asciiz "Escolha sua op��o >  "
	errma: .asciiz "Op��o inv�lida, tente novamente"
	errme: .asciiz "Op��o inv�lida, tente novamente"
	nl: .asciiz "\n"
.text
main:
	la $a0, tamanho_lista
	li $v0, 4
	syscall 

	li $v0, 5
	syscall 
	move $t0, $v0 # Tamanho max da lista ($t0)
	beqz $t0, zlist # Caso a lista tenha 0 elementos vai para zlist
	bltz $t0, nlist # Caso o usuario coloque um valor negativo, vai para nlist, que printa uma mensagem de erro
			
	la $a0, nl
	li $v0, 4
	syscall 
	
	li $s0, 0 # Contador ($s0)
	
	la $a0, greetgs # Mensagem de boas vindas
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall
MENU:	
	la $a0, opcao1
	li $v0, 4
	syscall 
	la $a0, nl
	li $v0, 4
	syscall 
	
	la $a0, opcao2
	li $v0, 4
	syscall 
	la $a0, nl
	li $v0, 4
	syscall 
	
	la $a0, opcao3
	li $v0, 4
	syscall 
	la $a0, nl
	li $v0, 4
	syscall 
	
	la $a0, opcao4
	li $v0, 4
	syscall 
	la $a0, nl
	li $v0, 4
	syscall 
	
	la $a0, opcao5
	li $v0, 4
	syscall 
	la $a0, nl
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall
	
	la $a0, escolha
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	la $a0, nl
	li $v0, 4
	syscall	

	beq $t1, 1, ADC # Se o valor do usuario for 1, vai para a fun��o de adicionar
	beq $t1, 2, REC # Se o valor do usuario for 2, vai para a fun��o de recuperar
	beq $t1, 3, PRT # Se o valor do usuario for 3, vai para a fun��o de printar
	beq $t1, 4, DEL # Se o valor do usuario for 4, vai para a fun��o de deletar
	beq $t1, 5, EXT # Se o valor do usuario for 5, finaliza o programa
	bgt $t1, 5, ERRMA # Caso o valor colocado na op��o seja maior que 5 da uma msg de erro
	blt $t1, 1, ERRME # Caso o valor da op��o seja menor que 1 da uma msg de erro

zlist:
	la $a0, zerol
	li $v0, 4
	syscall
		
	la $a0, nl
	li $v0, 4
	syscall
		
	la $a0, op
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, 1, main # Se o usuario desejar criar uma lista, volta para main, para escolher o tamanho dela e iniciar o programa
	beq $t0, 2, EXT # Se a op��o for 2, o programa � finalizado

nlist:
	la $a0, negal
	li $v0, 4
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	
	j main	

ADC:
	beq $s0, $t0, mql1 # Verifica se o tamanho da lista j� est� no m�ximo($s0 = $t0), caso esteja, printa uma mensagem de erro
	
	la $a0, adcv # Mensagem de adicionar o valor digitado pelo usu�rio
	li $v0, 4
	syscall
	
	li $v0, 5 # Entrada do valor
	syscall
	
	move $s1, $v0 #Coloca o valor salvo em $s1
	
	addi $sp, $sp, -4 # Aumentando a stack
	sw $s1, ($sp) # Adiciono o valor de $s1 na pilha
	addi $s0, $s0, 1 #adiciono 1 ao contador
	
	la $a0, adcv2 # Mensagem de valor adicionado
	li $v0, 4
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall	
	j MENU
	
	mql1: # Mensagem de tamanho da lista atingido
		la $a0, mql
		li $v0, 4
		syscall
	
		la $a0, nl
		li $v0, 4
		syscall
		la $a0, nl
		li $v0, 4
		syscall
		j MENU

REC:
	la $a0, rec
	li $v0, 4
	syscall
	li $v0, 5
	syscall
		
	move $s2, $v0 # Coloca o valor do usu�rio em $s2
	
	bgt $s2, $s0, posim # Verifica se o valor inserido � maior que o contador($s0), caso seja pula para posim
	blt $s2, 1, posime # Verifica se o valor inserido � menor que 1, caso seja pula para posime
	
	sub $s2, $s0, $s2 # Subtrai o valor do contador ($s0) pelo que o usuario quer buscar ($s2)
	mul $s2, $s2, 4 # Multiplico o resultado da subtra��o por 4

	add $s2, $s2, $sp # $s2 passa a ser o �ndice da lista
	lw $t2, ($s2) # Salvo o valor recuperado em $t2
	
	la $a0, valr # Mensagem de valor recuperado
	li $v0, 4
	syscall
	
	move $a0, $t2 # Printa o valor escolhido
	li $v0, 1
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall
	j MENU

	posim: # Caso o valor colocado pelo usuario seja maior que a quatidade de itens da lista
		la $a0, posicm
		li $v0, 4
		syscall
	
		la $a0, nl
		li $v0, 4
		syscall
		la $a0, nl
		li $v0, 4
		syscall
		j MENU
	
	posime: # Caso o valor colocado pelo usuario seja menor que 1
		la $a0, posicme
		li $v0, 4
		syscall
	
		la $a0, nl
		li $v0, 4
		syscall
		la $a0, nl
		li $v0, 4
		syscall
		j MENU

PRT:
	beq $s0, 0, sem_list # Caso n�o tenha nenhum valor adicionado na lista uma mensagem de erro aparece
	li $t3, 4 # $t3 recebe o valor 4
	mul $t3, $t3, $s0 # Acha o tamanho max da stack (4 * $s0)
	li $t4, 1 # $t4 recebe o valor 1
	
	forp:
		sub $t3, $t3, 4 # L� a stack a partir do primeiro valor adicionado, como a pilha "come�a" do 0, o 5 valor por exemplo, tem indice 16 e n�o 20
		blt $t3, 0, MENU # Quando o valor de $t3 chegar a zero volta para o menu, pois a lista acabou
	
		move $s2, $t3 # Coloco o valor de $t3, que � o tamanho da stack, em $s2, que vira o indice da lista
		add $s2, $s2, $sp # "Movimenta" a lista de acordo com o indice 
		lw $t5, ($s2) # Carrega o valor em $t5

		move $a0, $t4 # Mostra a posi��o dos valores (1�, 2�, 3�, etc)
		li $v0, 1
		syscall
		la $a0, pos
		li $v0, 4
		syscall
	
		move $a0, $t5 # Printa o valor carregado em $t5
		li $v0, 1
		syscall

		la $a0, nl
		li $v0, 4
		syscall

		addi $t4, $t4, 1 # Adiciono 1 ao contador que mostra a posi��o ($t4)
		j forp # Repete at� que todos os valores inseridos sejam printados
	sem_list: # Mensagem de erro caso n�o tenha iniciado a lista
		la $a0, sval
		li $v0, 4
		syscall
	
		la $a0, nl
		li $v0, 4
		syscall
		la $a0, nl
		li $v0, 4
		syscall
		j MENU

DEL:
	beq $s0, 0, sem_list
	la $a0, del
	li $v0, 4
	syscall
	li $v0, 5
	syscall
		
	move $s3, $v0 # Coloca o valor do usu�rio em $s3
	
	bgt $s3, $s0, posim # Verifica se o valor inserido � maior que o contador($s0), caso seja pula para posim
	blt $s3, 1, posime # Verifica se o valor inserido � menor que 1, caso seja pula para posime
	
	for_del:
		beq $s3, $s0, func_del # Se o valor do usuario for igual ao numero max de valores(valor de $s0), diminui a stack
		add $s3, $s3, 1 # Pego um valor acima do selecionado, e uso como indice para verificar se o tamanho da lista foi atingido
		move $s4, $s3 # Coloco o valor de $s3 em outros registradores, pois quando manipulo o $sp usando somente $s3 da erro de arithmetic overflow
		sub $s4, $s0, $s4 # Subtrai o indice do contador ($s0) pelo que o usuario quer buscar (agora $s4) 
		mul $s4, $s4, 4 # Multiplico o resultado da subtra��o por 4

		move $t3, $s4
		add $t3, $t3, $sp # $t3 passa a ser o �ndice da lista
		lw $t4, ($t3) # Recupero o valor para $t4

		subi $s3, $s3, 1 # Subtrai 1 para localizar o valor que o usuario indicou
		move $s5, $s3 # Mesmo problema do $s4, caso use somente $s3, ap�s fazer todos o procedimentos e retornar ao for_del, da erro de arithmetic overflow
		sub $s5, $s0, $s5 # Subtrai o indice do contador ($s0) pelo que o usuario quer buscar (agora $s5) 
		mul $s5, $s5, 4 # Uso o $s5 para achar o indice
	
		move $s1, $s5 # Coloco o indice em $s1
		add $s1, $s1, $sp
		sw $t4, ($s1) # Salvo o valor que est� em $t4 no local indicado pelo usuario ($t4 � o sucessor do valor indicado pelo usuario)
	
		addi $s3, $s3, 1 # Add 1 ao contador da fun��o for_del para que ele n�o fique em loop, j� que eu adiciono e subtraio 1 na mesma fun��o
		j for_del # O processo repete at� que todos os valores desde o indicado pelo usuario sejam substituidos pelos seus sucessores
	
	func_del:
		addi $sp, $sp, 4 # Diminuo o tamanho da stack
		sub $s0, $s0, 1 # Tiro um do contador para possibilitar adicionar outro valor na lista
	
		la $a0, vald # Mensagem de valor deletado
		li $v0, 4
		syscall
		la $a0, nl
		li $v0, 4
		syscall
		la $a0, nl
		li $v0, 4
		syscall
		j MENU

ERRMA: # Caso a op��o escolhida pelo usu�rio seja maior que 5
	la $a0, errma
	li $v0, 4
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall
	j MENU

ERRME:# Caso a op��o do usu�rio seja menor que 1
	la $a0, errme
	li $v0, 4
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall
	j MENU

EXT: # Finaliza��o do programa
	li $t0, 4 # Carrego 4 em $t0
	mul $t0, $t0, $s0 # Multiplico pelo contador para descobrir o tamanho da stack
	add $sp, $sp, $t0 # Diminuo a stack com o valor encontrado na multiplica��o
	
	la $a0, gb # Mensagem de sa�da
	li $v0, 4
	syscall
	la $a0, nl
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
