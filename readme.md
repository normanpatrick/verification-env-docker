### Why

To simplify simulation and verification steps.

### What is it

A "magic-free" (i.e. not using another untraceble container as a base)
**minimalist** docker container for `verilator`, Icarus `iverilog`,
and a few more for formal verification env.

### Using with docker

* Build

```
docker build -t verification .
```

* Run

```
docker run \
  --rm \
  --interactive --tty \
  -v $PWD:/projects \
  verification bash
```
