#!/usr/bin/env bash

set -eou >/dev/null

#
#
#

_test_once() {
  local _NAME_OF_COMMAND="${1}"
  local _TEST_DIR="${2}"
  local _PATTERN="${3}"
  local _EXPECTED_STATUS="${4}"

  printf "%10s %10s %40s %10s" "${_NAME_OF_COMMAND}" "${_TEST_DIR}" "${_PATTERN}" "${_EXPECTED_STATUS}"

  local _CMD="${_NAME_OF_COMMAND} ${_TEST_DIR} ${_PATTERN}"

  local _RESULT
  if eval "${_CMD}"; then
    _RESULT=$?
  else
    _RESULT=$?
  fi

  printf "%10s" "${_RESULT}"

  if [ "${_RESULT}" = "${_EXPECTED_STATUS}" ]; then
    printf " OK\n"
  else
    printf " FAIL\n"
  fi
}

_test_a_function() {
  local _NAME_OF_COMMAND="${1}"

  local _MATCH_PATTERN="example_[0-9][0-9][0-9][0-9][0-9].txt"
  local _NO_MATCH_PATTERN="no_matching_files.txt"

  _test_once "${_NAME_OF_COMMAND}" "TEST_A" "${_MATCH_PATTERN}" 0
  _test_once "${_NAME_OF_COMMAND}" "TEST_A" "${_NO_MATCH_PATTERN}" 1

  _test_once "${_NAME_OF_COMMAND}" "TEST_B" "${_MATCH_PATTERN}" 0
  _test_once "${_NAME_OF_COMMAND}" "TEST_B" "${_NO_MATCH_PATTERN}" 1

  _test_once "${_NAME_OF_COMMAND}" "TEST_C" "${_MATCH_PATTERN}" 0
  _test_once "${_NAME_OF_COMMAND}" "TEST_C" "${_NO_MATCH_PATTERN}" 1

  _test_once "${_NAME_OF_COMMAND}" "TEST_D" "${_MATCH_PATTERN}" 0
  _test_once "${_NAME_OF_COMMAND}" "TEST_D" "${_NO_MATCH_PATTERN}" 1
}


#
# Usage:
# function_name <DIR> <PATTERN>
#
# Expected return codes:
# 0: One or many files matching <PATTERN> exists in directory <DIR>
# 1: No files matching <PATTERN> exists in directory <DIR>
#

_alg_1() {
  find "${1}" -name "${2}" -type f -maxdepth 1 | read -r
}

#
# Test functions
#

_test_a_function "_alg_1"
