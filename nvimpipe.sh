#!/bin/sh

# if outputting to the tty continue as normal
[ -t 1 ] && nvim "${@}" || {
	# Create tmp file to hold and write data
	NVIMPIPE_TMPFILE="${TMPDIR:-/tmp}/nvimpipe.${$}$(date '+%e%H%M%S')"
	trap "rm -f '${NVIMPIPE_TMPFILE}' || true" EXIT INT HUP TERM

	# Will output the entirety of input if unedited
	nvim "+file ${NVIMPIPE_TMPFILE}" '+w!' '+set autowriteall' "${@}" >/dev/tty;
	cat "${NVIMPIPE_TMPFILE}"
}
