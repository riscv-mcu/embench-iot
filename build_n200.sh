if [[ "$TOOLCHAIN" == "terapines" ]]; then
ARCH_OPT="-march=rv32ima_zca_zcb_zcmp_zcmt_zba_zbb_zbc_zbs_zicond_xxlcz -mabi=ilp32 -mcmodel=medlow" ./build_riscv.sh
else
ARCH_OPT="-march=rv32ima_zca_zcb_zcmp_zcmt_zba_zbb_zbc_zbs_zicond_xxlcz -mabi=ilp32" ./build_riscv.sh
fi
