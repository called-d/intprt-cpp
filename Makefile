CXX = g++
CXXFLAGS += -g3

%.cpp.cc: %.cpp
	python pp.py $<
	astyle $@ -Y
	rm *.orig

%.a: %.o
	ar r $@ $<
	ranlib $@

tkutil.o: Tokenizer/util.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@
tk.o: Tokenizer/tokenizer.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@
util.o: util.cpp emelio.h util.h
	$(CXX) $(CXXFLAGS) -c $< -o $@
reduction.o: reduction.cpp.cc emelio.h util.h notation.h
	$(CXX) $(CXXFLAGS) -c $< -o $@
parse.o: parse.cpp.cc emelio.h util.h
	$(CXX) $(CXXFLAGS) -c $< -o $@
notation.o: notation.cpp emelio.h util.h notation.h
	$(CXX) $(CXXFLAGS) -c $< -o $@
transpile.o: transpile.cpp emelio.h util.h notation.h
	$(CXX) $(CXXFLAGS) -c $< -o $@
emelio.o: emelio.cpp emelio.h util.h
	$(CXX) $(CXXFLAGS) -c $< -o $@


OBJS = tkutil.o tk.o util.o parse.o notation.o reduction.o transpile.o emelio.o 
SML_OBJS = tkutil.o tk.o  util.o parse.o emelio.o

compile: emelio
	./emelio c test.em | gcc -lm -xc -Wall -o output -

clean: 
	rm *.cpp.cc

build: $(OBJS) emelio.h
	$(CXX) $(CXXFLAGS) -o emelio $(OBJS)

sml-build: $(SML_OBJS) emelio.h
	$(CXX) $(CXXFLAGS) -o emelio $(SML_OBJS)


clang: $(OBJS)
	clang -std=c++17 -o emelio $(OBJS)

test: emelio
	./utest.sh

run: emelio
	./emelio
