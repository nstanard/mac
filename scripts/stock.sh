# TODO: get this working... seems cool
# https://robertharder.wordpress.com/2011/03/17/bash-profile-sharing-and-useful-scripts/
stock(){
    # if [ $# -lt 1 ]; then
        # echo 1>&2 Usage: stock symbol1 [symbol2] […]
    # else
        # while [ “$1″ ]; do
        #     STOCK=”$(echo $1 | tr ‘a-z’ ‘A-Z’)”
        #     curl –max-time 1 -s “http://download.finance.yahoo.com/d/quotes.csv?f=l1c1p2&s=${STOCK}” |
        #     awk -F, -v stock=”$STOCK” -v tBold=”$tBold” -v tReset=”$tReset” -v tColor=”$tGreen”
        #     ‘{ printf(“%s: %s%s$%s%s, %s∆ n”, stock,tBold,tColor,$1,tReset, $2) }’
        #     shift
        # done
    # fi
}
