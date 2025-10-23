ARCH_OPT=${ARCH_OPT:-"-march=rv32ima_zca_zcb_zcmp_zcmt_zba_zbb_zbc_zbs -mabi=ilp32 -mcmodel=medlow"}
OLEVEL=${OLEVEL:-"-Os"}
CLIB=${CLIB:-0}
TMOUT=${TMOUT:-60}
COMPILER=${COMPILER:-zcc}
LINKER=${LINKER:-${COMPILER}}

if [ "x$CLIB" = "x0" ] ; then
    LIBFLAGS=" -nostdlib $NO_RELAX_GP -Wl,--undefined=__global_pointer$"
    USERLIBS=""
    DUMMYLIBS="crt0 libgcc libm libc"
else
    LIBFLAGS=" $NO_RELAX_GP"
    LIBFLAGS=" $NO_RELAX_GP"
    USERLIBS="-lc_nano -lm -lclang_rt.builtins_nano -lgloss"
    DUMMYLIBS="mculib"
fi

set -x
./build_all.py --clean --timeout ${TMOUT} --arch riscv32 --chip generic --board ri5cyverilator \
    --cc ${COMPILER} --ld ${LINKER} \
    --cflags="-c -flto ${OLEVEL} ${ARCH_OPT} ${LIBFLAGS} -ffunction-sections ${EXT_FLAGS} -mllvm --riscv-machine-outliner=false" \
    --ldflags="${OLEVEL} ${ARCH_OPT} ${LIBFLAGS} ${LD_EXT_FLAGS} -Wl,-mllvm,--riscv-machine-outliner=false -Wl,-gc-sections" \
    --user-libs="$USERLIBS" \
    --dummy-libs="$DUMMYLIBS"

set +x

./benchmark_size.py
./benchmark_size.py --absolute
