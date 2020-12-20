import json
import sys
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning

host = sys.argv[1]
port = sys.argv[2]
uri = sys.argv[3]

uri_req = ('http://' + host + ':' + port + '/' + uri)

app_url = uri_req
try:
    inputs = requests.get(app_url, timeout=3)
except requests.exceptions.Timeout as e:
    print('Nao foi possivel realizar a request - Timeout 3s')
    sys.exit(1)

data_inputs = json.loads(inputs.text)
healt_list = list(data_inputs.keys())
key_name = []
key_status = []
cup = 0
cdown = 0
kdown = []
#pprint(data_inputs)
for key_name in healt_list:
    if key_name == 'status':
        if data_inputs['status'] == 'UP':
            cup = cup + 1
        else:
            cdown = cdown + 1
            kdown.append(str(key_name))
    else:
        key_status = data_inputs[key_name]['status']
        if key_status == 'UP':
            cup = cup + 1
        else:
            cdown = cdown + 1
            kdown.append(str(key_name))

#print('UP: %s - DOWN: %s - Servicos Down %s' %(cup, cdown, kdown))
if cdown > 0:
  print('Service Failed: UP: %s - DOWN: %s - Servicos Down %s' %(cup, cdown, kdown))
else:
  print('Services are success: UP: %s - DOWN: %s - Servicos Down %s' %(cup, cdown, kdown))
