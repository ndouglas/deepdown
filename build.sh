#!/usr/bin/env bash

ca65 code/deepdown.asm 
ld65 deepdown.o -t nes -o build/deepdown.nes
