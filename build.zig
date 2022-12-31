const separate_implementation = true; //switch to false to make it work
const workaround_using_stub_c_file = false; //alternatively enable the workaround

pub fn build(b: *@import("std").build.Builder) !void {
    const exe = b.addExecutable("library-example", null);
    if (separate_implementation) {
        exe.addCSourceFile("main.c", &.{});
        if (workaround_using_stub_c_file) {
            exe.addCSourceFile("include_stub.c", &.{ "-DLIBRARY_PROVIDE_IMPLEMENTATION", "-DINCLUDE_FILE_PATH=\"library.h\"" }); //works
        } else {
            exe.addCSourceFile("library.h", &.{"-DLIBRARY_PROVIDE_IMPLEMENTATION"}); //triggers the misleading error message
        }
    } else {
        exe.addCSourceFile("main.c", &.{"-DLIBRARY_PROVIDE_IMPLEMENTATION"});
    }
    exe.linkLibC();
    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    b.step("run", "Run the program").dependOn(&run_cmd.step);
}
