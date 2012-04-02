#!/bin/sh 
#
# sareatualiza.sh - atualizacao de regras do rules emporium 
# 
# HomePage : http://www.ataliba.eti.br
# Autor : Ataliba Teixeira < ataliba em ataliba ponto eti ponto br 
#################################################
# Uso : 
# Copie este arquivo para um dos diretórios cron do SlackwareBox 
# cron.daily / cron.weekly / cron.monthly 
# e dê permissão de execução ao mesmo 
# chmod 755 sareatualiza.sh 
#
##################################################
# 


{
SPAMDIR=/tmp/spamassassin

mkdir $SPAMDIR

cd $SPAMDIR

wget http://www.rulesemporium.com/rules/72_sare_redirect_post3.0.0.cf

wget http://www.rulesemporium.com/rules/70_sare_evilnum0.cf
wget http://www.rulesemporium.com/rules/70_sare_evilnum1.cf
wget http://www.rulesemporium.com/rules/70_sare_evilnum2.cf

wget http://www.rulesemporium.com/rules/70_sare_bayes_poison_nxm.cf

wget http://www.rulesemporium.com/rules/70_sare_html0.cf
wget http://www.rulesemporium.com/rules/70_sare_html1.cf
wget http://www.rulesemporium.com/rules/70_sare_html2.cf
wget http://www.rulesemporium.com/rules/70_sare_html3.cf
wget http://www.rulesemporium.com/rules/70_sare_html_eng.cf

wget http://www.rulesemporium.com/rules/70_sare_header.cf

wget http://www.rulesemporium.com/rules/70_sare_specific.cf

wget http://www.rulesemporium.com/rules/70_sare_adult.cf

wget http://www.rulesemporium.com/rules/72_sare_bml_post25x.cf

wget http://www.rulesemporium.com/rules/99_sare_fraud_post25x.cf

wget http://www.rulesemporium.com/rules/70_sare_spoof.cf

wget http://www.rulesemporium.com/rules/70_sare_random.cf

wget http://www.rulesemporium.com/rules/70_sc_top200.cf

wget http://www.rulesemporium.com/rules/70_sare_oem.cf

wget http://www.rulesemporium.com/rules/70_sare_genlsubj.cf

wget http://www.rulesemporium.com/rules/70_sare_highrisk.cf

wget http://www.rulesemporium.com/rules/70_sare_unsub.cf

wget http://www.rulesemporium.com/rules/70_sare_uri0.cf
wget http://www.rulesemporium.com/rules/70_sare_uri1.cf
wget http://www.rulesemporium.com/rules/70_sare_uri2.cf
wget http://www.rulesemporium.com/rules/70_sare_uri3.cf
wget http://www.rulesemporium.com/rules/70_sare_uri4.cf

wget http://www.rulesemporium.com/rules/70_sare_whitelist.cf

wget http://www.rulesemporium.com/rules/70_sare_obfu.cf
wget http://www.rulesemporium.com/rules/70_sare_obfu2.cf
wget http://www.rulesemporium.com/rules/70_sare_obfu3.cf
wget http://www.rulesemporium.com/rules/70_sare_obfu4.cf

wget http://www.rulesemporium.com/rules/70_sare_stocks.cf

mv * /usr/share/spamassassin

PID=`ps ax | grep "/usr/bin/spamd -L" | grep -v grep |awk -F" " '{print $1}'`

kill -9 $PID

cd ~

rm -rf $SPAMDIR


} & 

