#Author kpulkit29
#Github https://github.com/kpulkit29

# Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
WHITE='\033[1;37'         # White


filename="desktop/data.txt"

if [[ ! -e $filename ]]
then
    echo "File data.txt does not exit on you desktop. Creating one for you."
    touch $filename
fi


makeCall() {
    echo "$1"
    price=0
    #Get the current price of stock
    price=`curl --silent "$API_ENDPOINT&symbols=$1.NS" | python -m json.tool \
    | grep '\"regularMarketPrice\"' \
    | cut -d ':' -f 2`

    #Remove the last character in in price i.e ,
    length=${#price} 
    length=`expr $length - 1`
    
    if [[ $length -le 0 ]]; then
    echo "Wrong stock symbol $1"
    elif [[ $length -gt 0 ]]; then
    echo "${price:0:$length}"
    fi

    # | python -c "import sys, json;price = (json.load(sys.stdin)['quoteResponse']['result'][0]['regularMarketPrice']);changePercent = (json.load(sys.stdin)['quoteResponse']['result'][0]['regularChangePercent']);print(price, 🔼) if changePercent>0 else print(price,🔽);"
}


API_ENDPOINT="https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com"
while read line
do 
    makeCall $line
    echo "\n"
done < $filename
