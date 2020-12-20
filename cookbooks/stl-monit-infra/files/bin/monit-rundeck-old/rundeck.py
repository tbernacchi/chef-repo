# encoding: utf-8

import os
import xmltodict
from requests import get

URL = os.environ.get("RUNDECK_URL")

TOKEN = os.environ.get("RUNDECK_TOKEN")

FILE_PATH = os.environ.get("RUNDECK_FILE_PATH")

TIME_ELAPSED = int(os.environ.get("TIME_ELAPSED"))


def elapsed(response):
    start = int(response["date-started"]["@unixtime"])
    end = int(response["date-ended"]["@unixtime"])

    return end - start


def get_jobs_information():
    url = URL + TOKEN

    result = get(url, headers={"Content-Type": "application/json"})
    return xmltodict.parse(result.text)["executions"]["execution"]


def message(response, information):
    return response['job']['project'] + " - " + response['job']['name'] + " " + information


def set_jobs_status(response):
    status = execution["@status"]

    time = elapsed(response)

    if status == "aborted" and time > TIME_ELAPSED:
        return message(response, "Long-Run - Time : " + str(time))

    elif status == "aborted" and time < TIME_ELAPSED:
        return message(response, "Aborted - Time : " + str(time))

    elif status == "failed" and time > TIME_ELAPSED:
        return message(response, "Job-Failed - Time : " + str(time))

    elif status == "succeeded" and time > TIME_ELAPSED:
        return message(response, "Takes-too-long - Time : " + str(time))

    elif status == "succeeded" and time < TIME_ELAPSED:
        return message(response, "Success - Time : " + str(time))


if __name__ == "__main__":
    file = open(FILE_PATH, "w+")
    for execution in get_jobs_information():
        status = set_jobs_status(execution)
	if status:
		file.write(status.encode("utf-8") + "\n")

    file.close()
