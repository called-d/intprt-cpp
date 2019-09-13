
#include "emelio.h"
#include "util.h"

int main(int argc, char **argv) {
    Tokenizer tkn;
    tkn.preset("cpp");

    if (argc == 2) {
        tkn.tokenize(argv[1]);
        ParserFlow pf = {tkn.tokenvals, 0};
        shared_ptr<Code> root = code(pf);
        reduction(root, true);

        cout << root->lit.val << endl;

        return stoi(root->lit.val);
    } else if (argc > 2) {
        std::cin >> std::noskipws;
        std::istream_iterator<char> it(std::cin);
        std::istream_iterator<char> end;
        string input(it, end);

        tkn.tokenize(input);
        ParserFlow pf = {tkn.tokenvals, 0};
        shared_ptr<Code> root = code(pf);
        reduction(root, true);

        cout << root->lit.val << endl;

        return stoi(root->lit.val);
    } else {
    
        tkn.tokenize_file("test.em");

        showv(tkn.tokenvals);

        ParserFlow pf = {tkn.tokenvals, 0};

        shared_ptr<Code> root = code(pf);
        cout << *root << endl;
        
        extract_all_notations(root);

//        reduction(root);
        
        cout << *root << endl;

        

        return 0;
    }
}

/*
  ((|f g| (|x| f (g x))) negate negate) 3
  
 */
