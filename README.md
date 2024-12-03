# 30 C Compiler!

`30cc` (Pronounced as *CCC*, because in the Persian language, the number 30 is pronounced as C) is a toy C compiler written in C, which is strong enough to compile itself 🤝 This was my first attempt in writing a self-hosting software! What is a self-hosting software?

- Imagine `30cc` gets strong enough to be able to compile itself.
- I will first compile `30cc` with `gcc` to get the `30cc` compiler's binary.
- I will then use the `gcc`-generated `30cc` binary file to compile the `30cc` again.
- I now have a `30cc`-compiled version of `30cc`, which I can use for further developing the compiler!
- I can forget about `gcc`, as if it never existed! Beautiful hah? `30cc` is now all alive by itself!

`30cc` emits x86-64 assembly as its output. The outputs are totally unoptimized, but that's fine, the project aims to be educational.

## Usage

- You'll first need to bootstrap the compiler by running `make`
- Then run `./build.py`. This will use the bootstrapped 30cc-compiler to compile 30cc itself. It then again uses the 30cc-compiled compiler to compile 30cc once again. The final compiler is then stored as `./30cc`.

Running independent source-files through `make`:

```
make run program=./examples/inp.c arguments=something
```

## Contribute

### Tests

To run tests use
```
python scripts/test.py update
```

Then check the output of the tests.

If you are on mac use `./scripts/test_mac.sh` to run the tests in docker.
