requestType=$1
url=$2
argc=$#
howToUse='ex: ./httpProtocolMock.sh "GET" "/"'
exexFile="./a.out"

if [ $argc != 2 ]; then
    echo $howToUse
    exit 1
fi

if [ ! -e $exexFile ]; then
    echo "Please generate exec-file before running this script."
    exit 1
fi

./a.out $requestType" "$url" HTTP/1.1\r\n" > /tmp/index.html;
ret=$?
if [ $ret = 0 ]; then
    echo [response]
    echo "------------------------------------------------"
    cat "/tmp/response.txt"
    echo -e "\n------------------------------------------------\n"
    echo [parsed response]
    echo "------------------------------------------------"
    cat /tmp/index.html
    echo "------------------------------------------------"
    echo "Open browser..."
    open "/tmp/index.html"
    echo "Done!"
    exit 0
else
    cat /tmp/index.html
    echo $howToUse
    exit 1
fi