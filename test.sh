#!/usr/bin/env bash

set -eu

#
#
#

_test_once() {
  local _NAME_OF_COMMAND="${1}"
  local _TEST_DIR="${2}"
  local _PATTERN="${3}"
  local _EXPECTED_STATUS="${4}"

  local _CMD="${_NAME_OF_COMMAND} ${_TEST_DIR} ${_PATTERN}"

  local _ACTUAL_STATUS
  if eval "${_CMD}"; then
    _ACTUAL_STATUS=$?
  else
    _ACTUAL_STATUS=$?
  fi

  local _RESULT
  if [ "${_ACTUAL_STATUS}" = "${_EXPECTED_STATUS}" ]; then
    _RESULT="OK"
  else
    _RESULT="FAIL"
  fi

  printf "Test: %10s | Dir: %10s | Pattern: %40s | Expected: %10s | Actual: %10s | %s\n" "${_NAME_OF_COMMAND}" "${_TEST_DIR}" "${_PATTERN}" "${_EXPECTED_STATUS}" "${_ACTUAL_STATUS}" "${_RESULT}"
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
