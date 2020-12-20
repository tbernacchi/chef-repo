#!/opt/python-nitro/bin/python
# Created by Rafael Haro - NetEng

import argparse
import requests
import auth
import json
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

def stat_health_cpu_memory(host, user=user, password=password): 
    netscaler = host
    requests.packages.urllib3.disable_warnings()
    url = 'https://%s/nitro/v1/stat/system' %netscaler
    response = requests.get(url, auth=(user, password),verify=False)
    if response.status_code != 200:
      print(response.text)
    return response.json()

def stat_health_tcp_conn(host, user=user, password=password): 
    netscaler = host
    requests.packages.urllib3.disable_warnings()
    url = 'https://%s/nitro/v1/stat/protocoltcp' %netscaler
    response = requests.get(url, auth=(user, password),verify=False)
    if response.status_code != 200:
      print(response.text)
    return response.json()

def stat_health_http(host, user=user, password=password): 
    netscaler = host
    requests.packages.urllib3.disable_warnings()
    url = 'https://%s/nitro/v1/stat/protocolhttp' %netscaler
    response = requests.get(url, auth=(user, password),verify=False)
    if response.status_code != 200:
      print(response.text)
    return response.json()

def stat_health_int(host, user=user, password=password): 
    netscaler = host
    requests.packages.urllib3.disable_warnings()
    url = 'https://%s/nitro/v1/stat/Interface' %netscaler
    response = requests.get(url, auth=(user, password),verify=False)
    if response.status_code != 200:
      print(response.text)
    return response.json()

timestamp = int(time.time())

res_stat_health_cpu_memory = stat_health_cpu_memory(netscaler)
res_stat_health_tcp_conn = stat_health_tcp_conn(netscaler)
res_stat_health_http = stat_health_http(netscaler)
res_stat_health_int = stat_health_int(netscaler)

def convert_status_to_sensu_health_cpu_memory(res_json):
    print ("%s.snmp.cpuusagepcnt %s %s" %(netscaler,int(res_json["system"]["cpuusagepcnt"]), timestamp))
    print ("%s.snmp.mgmtcpuusagepcnt %s %s"%(netscaler,int(res_json["system"]["mgmtcpuusagepcnt"]), timestamp))
    print ("%s.snmp.pktcpuusagepcnt %s %s"%(netscaler,int(res_json["system"]["pktcpuusagepcnt"]), timestamp))
    print ("%s.snmp.rescpuusagepcnt %s %s"%(netscaler,int(res_json["system"]["rescpuusagepcnt"]), timestamp))
    print ("%s.snmp.memusagepcnt %s %s"%(netscaler,int(res_json["system"]["memusagepcnt"]), timestamp))

def convert_status_to_sensu_health_tcp_conn(res_json):
    print ("%s.snmp.tcpcurclientconn %s %s" %(netscaler,res_json["protocoltcp"]["tcpcurclientconn"], timestamp))
    print ("%s.snmp.tcpcurclientconnclosing %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurclientconnclosing"], timestamp))
    print ("%s.snmp.tcpcurclientconnestablished %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurclientconnestablished"], timestamp))
    print ("%s.snmp.tcpcurclientconnopening %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurclientconnopening"], timestamp))
    print ("%s.snmp.tcpcurserverconn %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurserverconn"], timestamp))
    print ("%s.snmp.tcpcurserverconnclosing %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurserverconnclosing"], timestamp))
    print ("%s.snmp.tcpcurserverconnestablished %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurserverconnestablished"], timestamp))
    print ("%s.snmp.tcpcurserverconnopening %s %s"%(netscaler,res_json["protocoltcp"]["tcpcurserverconnopening"], timestamp))

def convert_status_to_sensu_health_http(res_json):
    print ("%s.snmp.httpgetsrate %s %s" %(netscaler,res_json["protocolhttp"]["httpgetsrate"], timestamp))
    print ("%s.snmp.httppostsrate %s %s" %(netscaler,res_json["protocolhttp"]["httppostsrate"], timestamp))
    print ("%s.snmp.httpothersrate %s %s" %(netscaler,res_json["protocolhttp"]["httpothersrate"], timestamp))
    print ("%s.snmp.httperrserverbusyrate %s %s" %(netscaler,res_json["protocolhttp"]["httperrserverbusyrate"], timestamp))
    print ("%s.snmp.httprequestsrate %s %s" %(netscaler,res_json["protocolhttp"]["httprequestsrate"], timestamp))
    print ("%s.snmp.httpresponsesrate %s %s" %(netscaler,res_json["protocolhttp"]["httpresponsesrate"], timestamp))
    print ("%s.snmp.httprxrequestbytesrate %s %s" %(netscaler,res_json["protocolhttp"]["httprxrequestbytesrate"], timestamp))
    print ("%s.snmp.httprxresponsebytesrate %s %s" %(netscaler,res_json["protocolhttp"]["httprxresponsebytesrate"], timestamp))

def convert_status_to_sensu_health_int(res_json):
    for res in res_json["Interface"]:
        print (("%s.%s.int.rxbytesrate %s %s"%(netscaler,res["id"].replace("/","-"), res["rxbytesrate"], timestamp)))
        print (("%s.%s.int.rxpktsrate %s %s"%(netscaler,res["id"].replace("/","-"), res["rxpktsrate"], timestamp)))
        print (("%s.%s.int.txbytesrate %s %s"%(netscaler,res["id"].replace("/","-"), res["txbytesrate"], timestamp)))
        print (("%s.%s.int.txpktsrate %s %s"%(netscaler,res["id"].replace("/","-"), res["txpktsrate"], timestamp)))
        print (("%s.%s.int.errpktrxrate %s %s"%(netscaler,res["id"].replace("/","-"), res["errpktrxrate"], timestamp)))
        print (("%s.%s.int.errpkttxrate %s %s"%(netscaler,res["id"].replace("/","-"), res["errpkttxrate"], timestamp)))

convert_status_to_sensu_health_cpu_memory(res_stat_health_cpu_memory)
convert_status_to_sensu_health_tcp_conn(res_stat_health_tcp_conn)
convert_status_to_sensu_health_http(res_stat_health_http)
convert_status_to_sensu_health_int(res_stat_health_int)
