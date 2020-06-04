#!/usr/bin/env bash

# Add to .bashrc like this
# source "${HOME}/.notes.sh"

NFILE="$( readlink -f ~/notes.txt )"

addDate()
{
	local day="=== $( date -I ) ==="

	if [ ! -f "${NFILE}" ]; then
		echo "${day}" > "${NFILE}"
		return
	fi

	grep "${day}" "${NFILE}" 1>/dev/null 2>&1
	if [ "${?}" != '0' ]; then
		echo '' >> "${NFILE}"
		echo "${day}" >> "${NFILE}"
	fi
}

note()
{
	local n="$*"

	if [ "${#}" -eq '0' ]; then
		echo 'No arguments provided'
		return
	fi

	addDate
	echo "- [ ] $( date +%H:%I:%S ) ${n}" >> "${NFILE}"
}

listTodos()
{
	grep '#todo' "${NFILE}" | grep -vi '[x]'
}

todo()
{
	local n="$*"

	if [ "${#}" -gt '0' ]; then
		note "${n} #todo"
	else
		listTodos
	fi
}
