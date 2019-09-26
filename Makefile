test:
	pushd examples/fizzBuzz && make && popd && \
	pushd examples/httpProtocolMock && make && popd && \
	pushd examples/for && make && popd && \
	pushd examples/mailHeaderParse && make && popd