TOOLCHAIN=${TOOLCHAIN:-nuclei}
if [[ "$TOOLCHAIN" == "terapines" ]]; then
  TOOLCHAIN=zcc
fi
echo "INFO: Build using toolchain $TOOLCHAIN"
./build_${TOOLCHAIN}.sh
