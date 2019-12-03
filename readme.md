### Why

To simplify simulation and verification steps.

### What is it

A "magic-free" (i.e. not using another untraceble container as a base) 
**minimalist** docker container for `verilator` and Icarus `iverilog`.

### Using with docker

* Build container

```
docker build -t verification .
```

* Run from container

```
docker run \
  --interactive --tty --rm \
  --env EV_VAR="$SOME_ENV_VAR" \
  executable_name -x <param_x>
```
