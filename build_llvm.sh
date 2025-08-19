ARCH_OPT=${ARCH_OPT:-"-march=rv32ima_zca_zcb_zcmp_zcmt_zba_zbb_zbc_zbs -mabi=ilp32"}
OLEVEL=${OLEVEL:-"-Os"}
CLIB=${CLIB:-0}
TMOUT=${TMOUT:-60}
COMPILER=${COMPILER:-riscv64-unknown-elf-clang}
LINKER=${LINKER:-${COMPILER}}

if [[ "$CLIB" == "libncrt_"* ]] ; then
    LIBFLAGS="-lncrt${CLIB/libncrt/} -lheapops_basic -lfileops_uart -lgcc -lnosys"
    USERLIBS=""
    DUMMYLIBS="libncrt"
elif [ "x$CLIB" = "x0" ] ; then
    LIBFLAGS=" -nostdlib"
    USERLIBS=""
    DUMMYLIBS="crt0 libgcc libm libc"
else
    LIBFLAGS="-lc_nano -lgcc -lnosys"
    USERLIBS="-lm"
    DUMMYLIBS=""
fi

set -x
./build_all.py --clean --timeout ${TMOUT} --arch riscv32 --chip generic --board ri5cyverilator \
    --cc ${COMPILER} --ld ${LINKER} \
    --cflags="-c ${OLEVEL} ${ARCH_OPT} ${LIBFLAGS} -ffunction-sections" \
    --ldflags="${OLEVEL} ${ARCH_OPT} ${LIBFLAGS} -fuse-ld=lld -Wl,-gc-sections" \
    --user-libs="$USERLIBS" \
    --dummy-libs="$DUMMYLIBS"

set +x

./benchmark_size.py
./benchmark_size.py --absolute
