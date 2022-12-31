const separate_implementation = true; //switch to false to make it work

pub fn build1(b: *@import("std").build.Builder) !void {
	const exe = b.addExecutable("library-example", null);
	if(separate_implementation) {
		exe.addCSourceFile("main.c", &.{});
		exe.addCSourceFile("library.h", &.{"-DLIBRARY_PROVIDE_IMPLEMENTATION"}); //triggers the misleading error message
	}else{
		exe.addCSourceFile("main.c", &.{"-DLIBRARY_PROVIDE_IMPLEMENTATION"});
	}
	exe.linkLibC();
	 const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    b.step("run", "Run the program").dependOn(&run_cmd.step);
}
