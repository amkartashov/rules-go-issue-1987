The issue is described here: https://github.com/bazelbuild/rules_go/issues/1987

To reproduce:

##### on a box with docker and git

$ git clone https://github.com/gorilych/rules-go-issue-1987.git
$ cd rules-go-issue-1987
$ sudo docker run --entrypoint bash --rm -ti -v `pwd`:/mnt l.gcr.io/google/bazel:0.27.0

##### inside container run

# cp -a /mnt /p
# cd /p
# bazel build //...

Result will be:

<<<<<<<<<<<<<<<<<
Extracting Bazel installation...
Starting local Bazel server and connecting to it...
INFO: Analyzed 3 targets (25 packages loaded, 6493 targets configured).
INFO: Found 3 targets...
ERROR: /root/.cache/bazel/_bazel_root/b86493d2ae255a02bb7ea61e7fb77c10/external/io_bazel_rules_go/BUILD.bazel:8:1: GoStdlib external/io_bazel_rules_go/linux_amd64_pure_stripped/stdlib%/pkg failed (Exit 1)
missing $GOPATH
stdlib: error running subcommand: exit status 1
INFO: Elapsed time: 61.367s, Critical Path: 2.62s
INFO: 4 processes: 4 local.
FAILED: Build did NOT complete successfully
<<<<<<<<<<<<<<<<<

If to remove line `build --spawn_strategy=standalone` from .bazelrc, the build will work fine.


