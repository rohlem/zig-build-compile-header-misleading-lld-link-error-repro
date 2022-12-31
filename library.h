//#include <stdio.h>

extern void hello();

#ifdef LIBRARY_PROVIDE_IMPLEMENTATION

	void hello(){
		puts("hello world");
	}

#endif
