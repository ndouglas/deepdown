#!/usr/bin/env bash

ca65 src/deepdown.asm -o build/deepdown.o;
ca65 src/reset.asm -o build/reset.o;
ld65 build/deepdown.o build/reset.o -C nes.cfg -o build/deepdown.nes;
