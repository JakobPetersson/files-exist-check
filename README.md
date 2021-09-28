# files-exist-check

- `TEST_A` directory with `1` matching file
- `TEST_B` directory with `10` matching files
- `TEST_C` directory with `100` matching files
- `TEST_D` directory with `1000` matching files
- `TEST_E` directory with `10000` matching files

Test it:

```shell
# Test once
./test.sh

#  Test until it fails
while ./test.sh; do true; done
```