#!/usr/bin/env python3

from dotenv import load_dotenv
import logging
import os
import requests
import subprocess
from urllib.parse import urlencode


def main():
    dir_home = os.environ.get('HOME')
    project_dir = os.path.realpath(os.path.dirname(os.path.realpath(__file__)) + "/..")
    load_dotenv(dotenv_path=f"{project_dir}/.env")
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))
    logging.info(f"Home dir of '{dir_home}'")
    gitlab_com_token = os.environ.get("GITLAB_COM_TOKEN")
    gitlab_com_top_groups = os.environ.get("GITLAB_COM_TOP_GROUP_IDS").split(",")
    base_folder = f"{dir_home}/repos/gitlab_com"
    logging.info(f"Using base folder '{base_folder}'")
    sync_gitlab(base_folder, gitlab_com_token, gitlab_com_top_groups)


def sync_gitlab(repos_folder: str, token: str, group_ids: list):
    projects = []
    for group_id in group_ids:
        projects = projects + get_gitlab_projects(token, group_id)
    logging.info(f"Found '{len(projects)}' projects")

    for project in projects:
        sync_project(repos_folder, project)


def sync_project(repos_folder: str, project: dict):
    name = project["path_with_namespace"]
    project_dir = f"{repos_folder}/{project['path_with_namespace']}"
    git_ssh = project["ssh_url_to_repo"]
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


# def get_gitlab_group(token: str, group_id: int) -> dict:
#     headers = {"PRIVATE-TOKEN": token}
#     response = requests.get(f"https://gitlab.com/api/v4/groups/{group_id}", headers=headers)
#     group = response.json()
#     return group
#
#
# def get_gitlab_subgroups(token: str, top_group: str) -> list:
#     headers = {"PRIVATE-TOKEN": token}
#     response = requests.get(f"https://gitlab.com/api/v4/groups/{top_group}/subgroups?per_page=100", headers=headers)
#     sub_groups = response.json()
#     if len(sub_groups) >= 100:
#         raise Exception("Pagination is needed in get_gitlab_subgroups function as we have reached the max")
#     return sub_groups


def get_gitlab_projects(token: str, group_id: int) -> list:
    headers = {"PRIVATE-TOKEN": token}
    page = 0
    per_page = 100
    projects = []

    while True:
        logging.debug(f"Getting group '{group_id}' projects. Page '{page}'")
        if page >= 1000:
            raise Exception(f"Page too high? Maybe an infinite loop? page='{page}'")
        get_params = {
            "archived": 0,
            "include_subgroups": 1,
            "per_page": per_page,
            "page": page
        }
        url = f"https://gitlab.com/api/v4/groups/{group_id}/projects?{urlencode(get_params)}"
        result = requests.get(url, headers=headers)
        # total_pages = result.headers.get("X-Total-Pages")
        response = result.json()
        projects = projects + response
        if len(response) == 0:
            break
        page = page + 1
    return projects


if __name__ == "__main__":
    main()
