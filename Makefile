include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	fstar main.fst --odir out --codegen OCaml --extract 'Main'  --debug 'Main' --detail_errors --debug_level Extreme --detail_hint_replay --warn_error -272
	$(OCAMLOPT) out/Main.ml -o out/main.exe
	./out/main.exe

debug: 
	fstar main.fst --debug 'Main' --detail_errors --debug_level Extreme --detail_hint_replay --warn_error -272

play:
	krml  -verbose -verify -drop WasmSupport -tmpdir ./out -no-prefix Playground playground.fst && ./a.out

forString:
	krml  -verbose -verify -drop WasmSupport -tmpdir ./out -no-prefix ForString forString.fst && ./a.out

forUint32:
	krml  -verbose -verify -drop WasmSupport -tmpdir ./out -no-prefix ForUint32 forUint32.fst && ./a.out

fizzBuzz:
	krml -verify -wasm -d force-c -tmpdir ./out -no-prefix FizzBuzz fizzBuzz.fst && ./a.out
