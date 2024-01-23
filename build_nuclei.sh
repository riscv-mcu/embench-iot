ARCH_OPT=${ARCH_OPT:-"-march=rv32imafd_zca_zcb_zcf_zcmp_zcmt_zba_zbb_zbc_zbs_zicond_xxlcz -mabi=ilp32d"}
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
./build_all.py --clean --arch riscv32 --chip generic --board ri5cyverilator \
    --cc riscv64-unknown-elf-gcc \
    --cflags="-c ${OLEVEL} ${ARCH_OPT} -ffunction-sections" \
    --ldflags="${ARCH_OPT} ${LIBFLAGS} -Wl,-gc-sections" \
    --user-libs="$USERLIBS" \
    --dummy-libs="$DUMMYLIBS"

set +x

./benchmark_size.py
./benchmark_size.py --absolute
