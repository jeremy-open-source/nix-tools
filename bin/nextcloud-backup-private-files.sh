#!/usr/bin/env bash

set -e

#DRY_RUN="--dry-run"
DATE="$(date +%s)"
USERNAME="$(id -u -n)"
DIR_FILES="${HOME}/Nextcloud/backup/${USERNAME}-files"
DIR_FILES_WIP="${DIR_FILES}/wip"
DIR_FILES_DATE="${DIR_FILES}/${DATE}"
declare -a BACKUP_DIRS=(
  "${HOME}/.ssh"
  "${HOME}/.config"
  "${HOME}/.docker"
  "${HOME}/.local"
  "${HOME}/.mc"
  "${HOME}/.mozilla"
  "${HOME}/.npm"
  "${HOME}/.openra"
  "${HOME}/.steam"
  "${HOME}/.var"
  # "${HOME}/.wine"
  "${HOME}/Desktop"
  "${HOME}/Documents"
  "${HOME}/bin"
  "${HOME}/.snap"
)
declare -a BACKUP_FILES=(
  "${HOME}/.bashrc"
  "${HOME}/.gitconfig"
  "${HOME}/.yarnrc"
)

if [[ -d "${DIR_FILES_WIP}" ]]; then
  echo "WARNING: Backup wip dir was not empty, removing old backup ${DIR_FILES_WIP}"
  rm -rf "${DIR_FILES_WIP}"
fi

if [[ ! -d "${DIR_FILES}" ]]; then
  echo "INFO: Creating backup main dir '${DIR_FILES}'"
  mkdir -p ${DIR_FILES}
fi

echo "INFO: Creating WIP backup '${DIR_FILES_WIP}'"
mkdir -p ${DIR_FILES_WIP}

echo "INFO: Backing up dirs into WIP dir"
for BACKUP_DIR in ${BACKUP_DIRS[@]}; do
  echo "INFO: Backing up dir '${BACKUP_DIR}' to '${DIR_FILES_WIP}${BACKUP_DIR}'"
  mkdir -p ${DIR_FILES_WIP}${BACKUP_DIR}
  rsync -aAXv \
    --exclude=/dev/* \
    --exclude=/proc/* \
    --exclude=/sys/* \
    --exclude=/tmp/* \
    --exclude=/run/* \
    --exclude=/mnt/* \
    --exclude=/media/* \
    --exclude="swapfile" \
    --exclude="lost+found" \
    --exclude=".cache" \
    "${BACKUP_DIR}" \
    "${DIR_FILES_WIP}${BACKUP_DIR}"
done

echo "INFO: Backing up files into WIP dir"
for BACKUP_FILE in ${BACKUP_FILES[@]}; do
  echo "INFO: Backing up file '${BACKUP_FILE}' to '${DIR_FILES_WIP}${BACKUP_FILE}'"
  cp -p "${BACKUP_FILE}" "${DIR_FILES_WIP}${BACKUP_FILE}"
done

echo "INFO: WIP backup complete. Locking it by date"
mv ${DIR_FILES_WIP} ${DIR_FILES_DATE}
