ARCH_OPT=${ARCH_OPT:-"-mcpu=cortex-m4"}
OLEVEL=${OLEVEL:-"-Os"}
NOLIB=${NOLIB:-1}

LIBFLAGS=" -nostdlib"
USERLIBS=""
DUMMYLIBS="crt0 libgcc libm libc"
if [ "x$NOLIB" != "x1" ] ; then
    LIBFLAGS="-specs=nosys.specs -specs=nano.specs"
    USERLIBS="-lm"
    DUMMYLIBS=""
fi

set -x

./build_all.py --clean --arch arm --chip cortex-m4 --board generic \
    --cc arm-none-eabi-gcc \
    --cflags="-c ${OLEVEL} ${ARCH_OPT} -ffunction-sections" \
    --ldflags="${ARCH_OPT} ${LIBFLAGS} -Wl,-gc-sections" \
    --user-libs="$USERLIBS" \
    --dummy-libs="$DUMMYLIBS"

set +x

./benchmark_size.py
./benchmark_size.py --absolute
