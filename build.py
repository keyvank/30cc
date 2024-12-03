#!/usr/bin/python3

import subprocess
import glob
import os
import io
import pathlib


def compile(path):
    out = subprocess.run(
        ["./a.out", path, "--asm"],
        capture_output=True,
        text=True,
        check=True,
    )
    if out.returncode != 0:
        raise Exception()
    else:
        return out.stdout


for f in glob.glob("**/*.c", recursive=True):
    try:
        asm = compile(f)
        asm_filename = "target/asm/" + f.replace(".c", ".asm")
        obj_filename = "target/obj/" + f.replace(".c", ".o")
        os.makedirs(pathlib.Path(asm_filename).parent, exist_ok=True)
        os.makedirs(pathlib.Path(obj_filename).parent, exist_ok=True)
        with io.open(asm_filename, "w") as f:
            f.write(asm)
        subprocess.run(["nasm", "-f", "elf64", asm_filename, "-o", obj_filename])
    except:
        print("Error compiling:", f)
