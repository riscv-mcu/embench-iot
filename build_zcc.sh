ARCH_OPT=${ARCH_OPT:-"-march=rv32ima_zca_zcb_zcmp_zcmt_zba_zbb_zbc_zbs -mabi=ilp32"}
OLEVEL=${OLEVEL:-"-Os"}
CLIB=${CLIB:-0}

if [ "x$CLIB" = "x0" ] ; then
    LIBFLAGS=" -nostdlib"
    USERLIBS=""
    DUMMYLIBS="crt0 libgcc libm libc"
else
    LIBFLAGS="-lc_nano -lclang_rt.builtins -lsemihost -lunwind"
    USERLIBS="-lm"
    DUMMYLIBS=""
fi

set -x
./build_all.py --clean --arch riscv32 --chip generic --board ri5cyverilator \
    --cc zcc --ld zcc \
    --cflags="-c ${OLEVEL} ${ARCH_OPT} ${LIBFLAGS} -ffunction-sections -flto -mllvm --riscv-machine-outliner=true" \
    --ldflags="${ARCH_OPT} ${LIBFLAGS} -flto -Wl,-mllvm,--riscv-machine-outliner=true -Wl,-gc-sections" \
    --user-libs="$USERLIBS" \
    --dummy-libs="$DUMMYLIBS"

set +x

./benchmark_size.py
./benchmark_size.py --absolute
