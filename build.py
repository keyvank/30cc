#!/usr/bin/python3

import subprocess
import glob
import os
import io
import pathlib


def compile(compiler, path):
    print("Compiling:", path)
    out = subprocess.run(
        [compiler, path, "--asm"],
        capture_output=True,
        text=True,
    )
    if out.returncode != 0:
        raise Exception(out.stderr + "\n" + out.stdout)
    else:
        return out.stdout


def compile_30cc(compiler, out):
    has_error = False
    for f in glob.glob("**/*.c", recursive=True):
        try:
            asm = compile(compiler, f)
            asm_filename = "target/asm/" + f.replace(".c", ".asm")
            obj_filename = "target/obj/" + f.replace(".c", ".o")
            os.makedirs(pathlib.Path(asm_filename).parent, exist_ok=True)
            os.makedirs(pathlib.Path(obj_filename).parent, exist_ok=True)
            with io.open(asm_filename, "w") as f:
                f.write(asm)
            subprocess.run(
                ["nasm", "-f", "elf64", asm_filename, "-o", obj_filename], check=True
            )
        except Exception as e:
            has_error = True
            print("Error compiling:", f, e)

    objs = list(
        [
            p
            for p in glob.glob("target/obj/**/*.o", recursive=True)
            if not p.startswith("target/obj/examples")
        ]
    )

    if not has_error:
        subprocess.run(
            [
                "ld",
                "-dynamic-linker",
                "/lib64/ld-linux-x86-64.so.2",
                "-lc",
                "-o",
                out,
            ]
            + objs
        )

print("Compiling 30cc with gcc-generated compiler")
compile_30cc('./a.out', '30cc_gcc')

print("Compiling 30cc with 30cc-generated compiler")
compile_30cc('./30cc', '30cc')