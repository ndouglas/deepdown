#!/usr/bin/env bash

rm -f build/*.o build/*.nes;
for asm_file in src/*.asm; do
    asm_basename="$(basename "${asm_file}" '.asm')";
    ca65 "${asm_file}" -o "./build/${asm_basename}.o";
done;
for asm_file in src/proc/*.asm; do
    asm_basename="$(basename "${asm_file}" '.asm')";
    ca65 "${asm_file}" -o "./build/proc_${asm_basename}.o";
done;

ld65 build/*.o -C nes.cfg -o build/deepdown.nes;
