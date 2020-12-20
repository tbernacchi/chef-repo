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
url = 'http://localhost:3031/results'

def stat_vserver(host, user=user, password=password): 
    netscaler = host
    requests.packages.urllib3.disable_warnings()
    url = 'https://%s/nitro/v1/stat/lbvserver/' %netscaler
    response = requests.get(url, auth=(user, password),verify=False)
    if response.status_code != 200:
      print(response.status_code)
      sys.exit(2)
    print(response.status_code)  
    return response.json()

timestamp = int(time.time())

def convert_status_to_sensu_vserver(vserver_stat):
    for res in vserver_stat["lbvserver"]:
        if res["state"] == "UP":
            payload = {"name":"nitro_"+res["name"],"output":res["name"]+"("+res["primaryipaddress"]+") is "+res["state"]+" ","source":netscaler,"docs":"https://confluence.wmxp.com.br/display/ti/Procedimentos+NetOps+-+Incidentes+e+Tarefas","status":0,"environment":"net-infra","origem":"nitro-api","aggregate":"netops","assignment_group":"BRe Network Operations"}
            response = requests.post(url, data=json.dumps(payload), headers=headers,verify=False)
            health = int(res["vslbhealth"])
            if health <= 30:
                payload = {"name":"nitro_"+res["name"]+"_health","output":res["name"]+"("+res["primaryipaddress"]+") is partial UP ("+res["vslbhealth"]+"%)","severity":"P4","source":netscaler,"docs":"https://confluence.wmxp.com.br/display/ti/Procedimentos+NetOps+-+Incidentes+e+Tarefas","status":1,"environment":"net-infra","origem":"nitro-api","aggregate":"netops","assignment_group":"BRe Network Operations"}
                response = requests.post(url, data=json.dumps(payload), headers=headers,verify=False)
            else:
                payload = {"name":"nitro_"+res["name"]+"_health","output":res["name"]+"("+res["primaryipaddress"]+") is partial UP ("+res["vslbhealth"]+"%)","severity":"P4","source":netscaler,"docs":"https://confluence.wmxp.com.br/display/ti/Procedimentos+NetOps+-+Incidentes+e+Tarefas","status":0,"environment":"net-infra","origem":"nitro-api","aggregate":"netops","assignment_group":"BRe Network Operations"}
                response = requests.post(url, data=json.dumps(payload), headers=headers,verify=False)
        if res["state"] == "DOWN":
            payload = {"name":"nitro_"+res["name"],"output":res["name"]+"("+res["primaryipaddress"]+") is "+res["state"]+" ","source":netscaler,"docs":"https://confluence.wmxp.com.br/display/ti/Procedimentos+NetOps+-+Incidentes+e+Tarefas","status":2,"environment":"net-infra","origem":"nitro-api","aggregate":"netops","assignment_group":"BRe Network Operations"}
            response = requests.post(url, data=json.dumps(payload), headers=headers,verify=False)

convert_status_to_sensu_vserver(stat_vserver(netscaler))
