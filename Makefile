
targets: libtest.dl

libtest.dl: test.o
	ch dllink libtest.dl -lstdc++ test.o

test.o: test.cpp
	g++ -c test.cpp -I/usr/local/ch7.5/extern/include 
