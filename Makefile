make: Tokenizer/tokenizer.cpp Tokenizer/util.cpp emelio.cpp
	g++ Tokenizer/tokenizer.cpp Tokenizer/util.cpp emelio.cpp -o emelio -g3

clang: Tokenizer/tokenizer.cpp Tokenizer/util.cpp emelio.cpp
	clang Tokenizer/tokenizer.cpp Tokenizer/util.cpp emelio.cpp -o emelio

run: emelio
	./emelio
