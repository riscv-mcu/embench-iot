ARCH_OPT=${ARCH_OPT:-"-mcpu=cortex-m4"}
OLEVEL=${OLEVEL:-"-Os"}
CLIB=${CLIB:-0}

if [ "x$CLIB" = "x0" ] ; then
    LIBFLAGS=" -nostdlib"
    USERLIBS=""
    DUMMYLIBS="crt0 libgcc libm libc"
else
    LIBFLAGS="-specs=nosys.specs -specs=nano.specs"
    USERLIBS="-lm"
    DUMMYLIBS=""
fi

set -x

./build_all.py --clean --arch arm --chip cortex-m4 --board generic \
    --cc arm-none-eabi-gcc \
    --cflags="-c ${OLEVEL} ${ARCH_OPT} ${LIBFLAGS} -ffunction-sections" \
    --ldflags="${ARCH_OPT} ${LIBFLAGS} -Wl,-gc-sections" \
    --user-libs="$USERLIBS" \
    --dummy-libs="$DUMMYLIBS"

set +x

./benchmark_size.py
./benchmark_size.py --absolute
