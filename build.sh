#!/usr/bin/env bash

ca65 code/deepdown.asm -o build/deepdown.o;
ld65 build/deepdown.o -t nes -o build/deepdown.nes;
