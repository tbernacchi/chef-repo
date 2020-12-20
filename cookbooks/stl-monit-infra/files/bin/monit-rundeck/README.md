## Rundeck extractor

##### About

Script to extract job information from Rundeck.

##### Install

```bash
$ pip install -r requirements.txt
```

##### Environments Variables

```bash
$ export RUNDECK_FILE_PATH="path to generate file"

$ export RUNDECK_URL="Rundeck url"

$ export RUNDECK_TOKEN="Rundeck token"

$ export TIME_ELAPSED=300

```

##### Tech

> Python 3.6.7

> pip 10.0.1 

> VirtualEnv

##### Dependencies

> requests==2.21.0

> xmltodict==0.11.0

##### Run

> after export env's 

```bash
$ python rundeck.py
```

> or export var and start script

```bash
$ sh start.sh
```