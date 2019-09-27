include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	fstar.exe mailHeaderParse.fst --odir out --codegen OCaml --extract 'mailHeaderParse'  --debug 'MailHeaderParse' --detail_errors --debug_level Medium 
	$(OCAMLOPT) out/MailHeaderParse.ml
	./a.out
