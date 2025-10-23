if [[ "$TOOLCHAIN" == "terapines" ]]; then
ARCH_OPT="-march=rv32em_zca_zcb_zcmp_zcmt_zicond -mabi=ilp32e -mcmodel=medlow" ./build_riscv.sh
else
ARCH_OPT="-march=rv32em_zca_zcb_zcmp_zcmt_zicond -mabi=ilp32e" ./build_riscv.sh
fi
