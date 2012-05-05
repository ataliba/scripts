#!/usr/bin/env python
# -*- coding: iso-8859-1 -*-

import sys


def calculando_emprestimo(valor,meses,taxa_mensal): 
 
 coeficiente = (1 + taxa_mensal ) ** meses # calcula o coeficiente

 parcela = valor * ( ( taxa_mensal * coeficiente) / ( coeficiente - 1 ) ) / meses
 
 return parcela




if __name__ == "__main__" :


 if len(sys.argv) >= 3: 
  
  (valor,meses,taxa_mensal) = \
  (int(sys.argv[1]),int(sys.argv[2]),float(sys.argv[3]))

 else:
  valor = int(raw_input("Entre com o valor do emprestimo : "))
  meses = int(raw_input("Entre com o numero de meses : "))
  taxa_mensal = float(raw_input("Entre com a taxa mensal :"))

 parcelas = calculando_emprestimo(valor,meses,taxa_mensal)

 valor_total = parcelas * 24
 
 print "+-------------------------------------------+"
 print "Seu valores do emprestimo sao \n"
 print "Valor da parcela : %.2f \nValor total pago : %.2f \n" % ( parcelas,
   valor_total) 
 print "+-------------------------------------------+"
