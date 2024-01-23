ARCH_OPT=${ARCH_OPT:-"-mcpu=cortex-m4"}
OLEVEL=${OLEVEL:-"-Os"}

./build_all.py --clean --arch arm --chip cortex-m4 --board generic \
    --cc arm-none-eabi-gcc \
    --cflags="-c ${OLEVEL} ${ARCH_OPT} -ffunction-sections" \
    --ldflags="${ARCH_OPT} -nostdlib -Wl,-gc-sections" \
    --user-libs="" \
    --dummy-libs="crt0 libgcc libm libc"


./benchmark_size.py
./benchmark_size.py --absolute
