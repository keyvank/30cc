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
    )
    if out.returncode != 0:
        raise Exception(out.stderr + "\n" + out.stdout)
    else:
        return out.stdout


has_error = False
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
    except Exception as e:
        has_error = True
        print("Error compiling:", f, e)


objs = list(glob.glob("target/obj/**/*.o", recursive=True))

if not has_error:
    subprocess.run(
        [
            "ld",
            "-dynamic-linker",
            "/lib64/ld-linux-x86-64.so.2",
            "-lc",
            "-o",
            "target/30cc",
        ]
        + objs
    )
