import difflib
import os
import shutil
import subprocess
import sys

# map of file names to their input(s)
TEST_FILES = {
    "./examples/inp.c": [],
    "./examples/inp3.c": [],
    "./examples/inp4.c": [],
    "./examples/inp5.c": ["", "a b c"],
    "./examples/inp6.c": [],
    "./examples/inp_bin_op.c": [],
    "./examples/inp_linked_list.c": [],
    "./examples/inp_unary_op.c": [],
    "./examples/lib_usage.c": [],
    "./examples/inp_include.c": [],
    "./examples/inp_func_ptrs.c": [],
    "./examples/inp_goto.c": [],
    "./examples/inp_break.c": [],
    "./examples/inp_preprocess.c": [],
    "./examples/inp_pointer.c": [],
    "./examples/switch.c": [],
    "./examples/inp_loop.c": [],
    "./examples/lots_of_variables.c": [],
    "./examples/inp_arg_macro.c": [],
    "./examples/inp_extern.c": [],
}
C_PROGRAM_NAME = "./30cc"
OUTPUT_FOLDER = "tests/output"
TEMP_FOLDER = "temp_snapshots"


def run(input_file, mode):
    try:
        result = subprocess.run(
            [C_PROGRAM_NAME, input_file, "--" + mode],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(
            f"Error: Failed to run {C_PROGRAM_NAME} with input `{input_file} --{mode}`"
        )
        print(f"Error message: {e.stderr}")
        return None


def compare_outputs(file_path, new_output):
    with open(file_path, "r") as f:
        old_output = f.read()

    if old_output != new_output:
        diff = difflib.unified_diff(
            old_output.splitlines(), new_output.splitlines(), lineterm=""
        )
        print(f"Difference detected in {file_path}:")
        print("\n".join(diff))
        return False
    return True


def update_output(file_path, new_output, save_old=False):
    if save_old and os.path.exists(file_path):
        old_snapshot_path = os.path.join(TEMP_FOLDER, os.path.basename(file_path))
        shutil.copy2(file_path, old_snapshot_path)

    with open(file_path, "w") as f:
        f.write(new_output)
    print(f"Updated {file_path}")


def revert_snapshot(file_path):
    old_snapshot_path = os.path.join(TEMP_FOLDER, os.path.basename(file_path))
    if os.path.exists(old_snapshot_path):
        shutil.copy2(old_snapshot_path, file_path)
        os.remove(old_snapshot_path)
        print(f"Reverted {file_path} to previous snapshot")
    else:
        print(f"No previous snapshot found for {file_path}")


def git_add_and_diff(file_path):
    try:
        subprocess.run(["git", "add", file_path], check=True)
        subprocess.run(["git", "diff", "--staged", file_path])
    except subprocess.CalledProcessError:
        print(f"Error: Failed to perform git operations on {file_path}")


def main():
    mode = None
    if len(sys.argv) > 2:
        mode = sys.argv[1]
        if mode not in ["update", "revert", "run"]:
            print("Invalid mode. Use 'update' or 'revert' or 'run'.")
            sys.exit(1)

    try:
        subprocess.run(["make", C_PROGRAM_NAME], check=True)
        print(f"Successfully built {C_PROGRAM_NAME}")
    except subprocess.CalledProcessError:
        print(f"Error: Failed to build {C_PROGRAM_NAME}")
        sys.exit(1)

    if not os.path.exists(OUTPUT_FOLDER):
        os.makedirs(OUTPUT_FOLDER)

    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)

    if mode == "update":
        shutil.rmtree(TEMP_FOLDER)
        print("Removed old snapshots")
        return

    diff_count = 0
    failed = False
    for test_file in TEST_FILES.keys():
        for mode in ['lex', 'prep', 'tree', 'asm']:
            extension = "txt"
            if mode == "asm":
                extension = "asm"
            output_file = os.path.join(
                OUTPUT_FOLDER,
                f"{os.path.basename(test_file)}_{mode}_output.{extension}",
            )
            print(test_file, mode)
            output = run(test_file, mode)
            if output is None:
                failed = True

            if mode == "revert":
                revert_snapshot(output_file)
                continue

            if output is None:
                continue

            if os.path.exists(output_file):
                if not compare_outputs(output_file, output):
                    diff_count += 1
                    print(f"Alert: New output differs from {output_file}")
                    update_output(output_file, output, True)
            else:
                update_output(output_file, output)

    if mode == "run":
        for test_file, inputs in TEST_FILES.items():
            if len(inputs) == 0:
                inputs = [""]

            for i, inp in enumerate(inputs):
                try:
                    command = subprocess.run(
                        ["make", "run", f"program={test_file}", f"arguments={inp}"],
                        capture_output=True,
                        text=True,
                        check=True,
                    )
                    output = command.stdout
                except subprocess.CalledProcessError as e:
                    print(f"Error: Failed to run {test_file} with input `{inp}`")
                    print(f"Error message: {e.stderr}")
                    continue
                if i == 0 and len(inputs) == 1:
                    output_file = os.path.join(
                        OUTPUT_FOLDER, f"{os.path.basename(test_file)}_run_output.txt"
                    )
                else:
                    output_file = os.path.join(
                        OUTPUT_FOLDER,
                        f"{os.path.basename(test_file)}_run_output_{i}.txt",
                    )

                if mode == "revert":
                    revert_snapshot(output_file)
                    continue

                if os.path.exists(output_file):
                    if not compare_outputs(output_file, output):
                        diff_count += 1
                        print(f"Alert: New output differs from {output_file}")
                        update_output(output_file, output, True)
                else:
                    update_output(output_file, output)

    print(f"found {diff_count} differences in run snapshots")

    if diff_count > 0:
        exit(1)
    if failed is True:
        exit(1)


if __name__ == "__main__":
    main()
