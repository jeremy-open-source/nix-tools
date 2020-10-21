from dotenv import load_dotenv
import logging
import os
import requests
import subprocess
from urllib.parse import urlencode

from requests.auth import HTTPBasicAuth


def main():
    dir_home = os.environ.get('HOME')
    project_dir = os.path.realpath(os.path.dirname(os.path.realpath(__file__)) + "/..")
    load_dotenv(dotenv_path=f"{project_dir}/.env")
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))
    github_com_token = os.environ.get("GITHUB_COM_TOKEN")
    github_com_username = os.environ.get("GITHUB_COM_USERNAME")
    github_com_org_list = os.environ.get("GITHUB_COM_ORGS").split(",")
    base_folder = f"{dir_home}/repos/github_com"
    logging.info(f"Using base folder '{base_folder}'")
    sync_github(base_folder, github_com_username, github_com_token, github_com_org_list)


def sync_github(repos_folder: str, username: str, token: str, github_com_org_list: list):
    projects = get_github_projects_user(username, token)
    for github_com_org in github_com_org_list:
        if github_com_org != "":
            projects = projects + get_github_projects_org(username, token, github_com_org)
    logging.info(f"Found '{len(projects)}' projects")

    for project in projects:
        sync_project(repos_folder, project)


def sync_project(repos_folder: str, project: dict):
    name = project["name"]
    project_dir = f"{repos_folder}/{project['full_name']}"
    git_ssh = project["ssh_url"]
    if not os.path.isdir(project_dir):
        logging.info(f"Project '{name}' does not currently exist, cloning")
        run_command(["git", "clone", git_ssh, project_dir])
    else:
        logging.warning(f"Project '{name}' already exists, skipping")


def run_command(command_params: list) -> str:
    """
    Runs a command
    :param command_params: list
    :return: str
    """
    result = subprocess.run(command_params, stdout=subprocess.PIPE)
    if result.returncode != 0:
        raise Exception("Command failed")
    return result.stdout.decode("utf-8")


def get_github_projects_user(username: str, token: str) -> list:
    headers = {
        "Accept": "application/vnd.github.v3+json"
    }
    page = 0
    per_page = 100
    projects = []

    while True:
        logging.debug(f"Getting users '{username}' projects. Page '{page}'")
        if page >= 1000:
            raise Exception(f"Page too high? Maybe an infinite loop? page='{page}'")
        get_params = {
            "archived": 0,
            "include_subgroups": 1,
            "per_page": per_page,
            "page": page
        }
        url = f"https://api.github.com/users/{username}/repos?{urlencode(get_params)}"
        result = requests.get(url, headers=headers, auth=HTTPBasicAuth(username, token))
        # total_pages = result.headers.get("X-Total-Pages")
        response = result.json()
        projects = projects + response
        if len(response) == 0:
            break
        page = page + 1
    return projects


def get_github_projects_org(username: str, token: str, github_com_org: str) -> list:
    headers = {
        "Accept": "application/vnd.github.v3+json"
    }
    page = 0
    per_page = 100
    projects = []

    while True:
        logging.debug(f"Getting group '{github_com_org}' projects. Page '{page}'")
        if page >= 1000:
            raise Exception(f"Page too high? Maybe an infinite loop? page='{page}'")
        get_params = {
            "archived": 0,
            "include_subgroups": 1,
            "per_page": per_page,
            "page": page
        }
        url = f"https://api.github.com/orgs/{github_com_org}/repos?{urlencode(get_params)}"
        result = requests.get(url, headers=headers, auth=HTTPBasicAuth(username, token))
        # total_pages = result.headers.get("X-Total-Pages")
        response = result.json()
        projects = projects + response
        if len(response) == 0:
            break
        page = page + 1
    return projects


if __name__ == "__main__":
    main()
