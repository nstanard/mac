# GET WORKING!
lsnet(){
    # lsof -i | awk ‘{printf(“%-14s%-20s%sn”, $10, $1, $9)}’ | sort
}
