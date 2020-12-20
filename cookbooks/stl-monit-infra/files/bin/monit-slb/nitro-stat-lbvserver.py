#!/opt/python-nitro/bin/python
# Created by Rafael Haro - NetEng

import argparse
import requests
import sys
import auth
import json
import os
import getpass
import time

parser = argparse.ArgumentParser()
parser.add_argument('-b', dest = 'balanceador', required = True)
parser.add_argument('-u', dest = 'user', required = True)
parser.add_argument('-p', dest = 'password', required = True)
args = parser.parse_args()
netscaler = args.balanceador
user = args.user
password = args.password
headers = {"Content-Type": "application/json"}

def stat_netscaler(host, uri, user=user, password=password):
    netscaler = host
    requests.packages.urllib3.disable_warnings()
    url = 'https://%s/nitro/v1/stat/%s' %(netscaler,uri)
    response = requests.get(url, auth=(user, password),verify=False)
    if response.status_code != 200:
      print(response.status_code)
    return response.json()

timestamp = int(time.time())

def convert_status_to_sensu_vserver(vserver_stat):
    contUP = 0
    contDOWN = 0
    for res in vserver_stat["lbvserver"]:
        if res["state"] == "UP":
            contUP = contUP+1
        if res["state"] == "DOWN":
            contDOWN = contDOWN+1    
        print (("%s.%s.requestsrate %s %s"%(netscaler,res["name"].replace(".","-"), res["requestsrate"], timestamp)))
        print (("%s.%s.requestbytesrate %s %s"%(netscaler,res["name"].replace(".","-"), res["requestbytesrate"], timestamp)))
        print (("%s.%s.responsesrate %s %s"%(netscaler,res["name"].replace(".","-"), res["responsesrate"], timestamp)))
        print (("%s.%s.responsebytesrate %s %s"%(netscaler,res["name"].replace(".","-"), res["responsebytesrate"], timestamp)))
        print (("%s.%s.curclntconnections %s %s"%(netscaler,res["name"].replace(".","-"), res["curclntconnections"], timestamp)))
        print (("%s.%s.cursrvrconnections %s %s"%(netscaler,res["name"].replace(".","-"), res["cursrvrconnections"], timestamp)))
        print (("%s.%s.establishedconn %s %s"%(netscaler,res["name"].replace(".","-"), res["establishedconn"], timestamp)))
        print (("%s.%s.vslbhealth %s %s"%(netscaler,res["name"].replace(".","-"), res["vslbhealth"], timestamp)))
    print "%s.snmp.totalvipup %s %s" %(netscaler,contUP,timestamp)
    print "%s.snmp.totalvipdown %s %s" %(netscaler,contDOWN,timestamp)    

def convert_status_to_sensu_cs(cs_stat):
    for res in cs_stat["csvserver"]:
        print (("%s.%s.requestsrate %s %s"%(netscaler,res["name"].replace(".","-"), res["requestsrate"], timestamp)))
        print (("%s.%s.requestbytesrate %s %s"%(netscaler,res["name"].replace(".","-"), res["requestbytesrate"], timestamp)))
        print (("%s.%s.responsesrate %s %s"%(netscaler,res["name"].replace(".","-"), res["responsesrate"], timestamp)))
        print (("%s.%s.responsebytesrate %s %s"%(netscaler,res["name"].replace(".","-"), res["responsebytesrate"], timestamp)))
        print (("%s.%s.curclntconnections %s %s"%(netscaler,res["name"].replace(".","-"), res["curclntconnections"], timestamp)))
        print (("%s.%s.cursrvrconnections %s %s"%(netscaler,res["name"].replace(".","-"), res["cursrvrconnections"], timestamp)))
        print (("%s.%s.establishedconn %s %s"%(netscaler,res["name"].replace(".","-"), res["establishedconn"], timestamp)))
        print (("%s.%s.curmptcpsessions %s %s"%(netscaler,res["name"].replace(".","-"), res["curmptcpsessions"], timestamp)))

convert_status_to_sensu_vserver(stat_netscaler(netscaler,"lbvserver"))
convert_status_to_sensu_cs(stat_netscaler(netscaler,"csvserver"))

res_sorryserver = stat_netscaler(netscaler,"responderpolicy/sorry-server-1")
rw_sorryserver = stat_netscaler(netscaler,"rewritepolicy/sorry-server-rw_pol2")

res_sorry_hits = res_sorryserver[u'responderpolicy'][0][u'pipolicyhits']
res_sorry_hits_rate = res_sorryserver[u'responderpolicy'][0][u'pipolicyhitsrate']
rw_sorry_hits = rw_sorryserver[u'rewritepolicy'][0][u'pipolicyhits']
rw_sorry_hits_rate = rw_sorryserver[u'rewritepolicy'][0][u'pipolicyhitsrate']

print ( "%s.sorryserver.res_sorry_hits %s %s " %(netscaler,res_sorry_hits, timestamp))
print ( "%s.sorryserver.res_sorry_hits_rate %s %s " %(netscaler,res_sorry_hits_rate, timestamp))
print ( "%s.sorryserver.rw_sorry_hits %s %s " %(netscaler,rw_sorry_hits, timestamp))
print ( "%s.sorryserver.rw_sorry_hits_rate %s %s " %(netscaler,rw_sorry_hits_rate, timestamp))
