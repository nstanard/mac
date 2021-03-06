#!/bin/bash

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            shellfile)          shellfile=${VALUE} ;;
            token)              token=${VALUE} ;;
            utils)              utils=${VALUE} ;;
            *)
    esac    
done

echo ""
read -p "Would you like to configure your shell file? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]
  then
    touch ~/.bash-mac-profile
    echo "Updating shell file"
    cat > ~/.bash-mac-profile <<-EOF

export NPM_TOKEN="$token"
export SP_REPOS=$SP_REPOS
export UTILS=$UTILS
export CONFIGS=$CONFIGS
export SCRIPTS=$SCRIPTS
export MYSQL_USER=$MYSQL_USER
export MYSQL_PASS=$MYSQL_PASS
export FLYWAY_PATH="$flyway_dir"
export JETTY_HOME="$jetty_dir"

source $SCRIPTS/gradle.bash
source $SCRIPTS/pathmunge.bash
source $SCRIPTS/file-limit.bash

pathmunge "/usr/local/sbin"

pathmunge "$mysql_dir/bin"
pathmunge "$jetty_dir/bin"
pathmunge "$flyway_dir"
pathmunge "$redis_dir/src"
pathmunge "$java_dir/Contents/Home"
pathmunge "$java_dir/Contents/Home/bin"

export JAVA_HOME="$java_dir/Contents/Home"
export JAVA_BIN="$java_dir/Contents/Home/bin"

alias ls='exa -G'
alias ll='exa -lh --git --modified --icons'
alias reload="source $shellfile"
alias subl="open -a 'Sublime Text.app'"
alias atom="open -a 'Atom.app'"
alias code="open -a 'Visual Studio Code.app'"

# function gradle() {
#   if [ -e gradlew ]; then
#     ./gradlew "$@"
#   elif [ -e ../gradlew ]; then
#     ./../gradlew "$@"
#   else
#     ./../../gradlew "$@"
#   fi
# }

# function gradle() {
# 	echo "$path"
# 	path=$(pwd)
# 	cmdPath=`expr "$path" : '^\(.*source\/[a-z0-9-]*\)'`
# 	echo "$path"
# 	[[ "$cmdPath" == "" ]] && cmdPath=`expr "$path" : '^\(.*analyst-ng\/[a-z0-9-]*\)'`
# 	while [[ "$path" != "" && ! -e "$path/gradlew" ]]; do
# 		path=${path%/*}
# 	done
# 	[[ $cmdPath = "" ]] && cmdPath="$path"
# 	if [[ "$path" != "" && "$cmdPath" != "" ]]; then
# 		echo "Building from: $cmdPath"
# 		pushd "$cmdPath"
# 		eval "${path}/gradlew --max-workers=6 $@"
# 		popd
# 	fi
# }

# flyway commands
# evun
alias flyway-evun="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/evun?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8&useAffectedRows=true&zeroDateTimeBehavior=CONVERT_TO_NULL\" -locations=\"filesystem:$SP_REPOS/analyst-ng/source/ext-db/analyst-ng\""

# boxbe
alias flyway-boxbe="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/boxbe?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8\" -locations=\"filesystem:$SP_REPOS/analyst-ng/boxbe/database/main\""
alias flyway-boxbe-dev="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/boxbeFlywayDev?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8\" -locations=\"filesystem:$SP_REPOS/analyst-ng/boxbe/database/dev-load\""
alias flyway-boxbe-all="flyway-boxbe clean && flyway-boxbe migrate && flyway-boxbe-dev clean && flyway-boxbe-dev migrate"

alias flyway-analyst="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/analyst?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8\" -locations=\"filesystem:$SP_REPOS/analyst-ng/source/ext-db/analyst-ng\""
alias flyway-analyst-dev="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/analystFlywayDev?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8\" -locations=\"filesystem:$SP_REPOS/analyst-ng/source/ext-db/analyst-ng-dev-load\""

alias flyway-analyst-dev-personal="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/analystFlywayDevPersonal?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8\" -locations=\"filesystem:$EDS_PATH/sparkpost-ea-personal-flyway\""

alias flyway-analyst-all="flyway-evun clean && flyway-analyst clean && flyway-analyst migrate && flyway-analyst-dev clean && flyway-analyst-dev migrate"

alias flyway-boxbe-counts="$flyway_dir/flyway -user=$MYSQL_USER -password=$MYSQL_PASS -url=\"jdbc:mysql://127.0.0.1:3306/boxbe_counts?autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8\" -locations=\"filesystem:$SP_REPOS/analyst-ng/source/ext-db/boxbe-counts\""
alias flyway-boxbe-counts-all='flyway-boxbe-counts clean && flyway-boxbe-counts migrate'

alias sp="cd $SP_REPOS"
alias ng="cd $SP_REPOS/analyst-ng/"
alias cjs="cd $SP_REPOS/analyst-ng/common/common-js"

alias dev="cd $SP_REPOS"
alias match="cd $SP_REPOS/matchbox"

alias ngg="cd $SP_REPOS/analyst-ng/source/webapp-analyst-ng/src/main/web-src"
alias nge="cd $SP_REPOS/analyst-ng/source/webapp-analyst-ng/src/main/extension"

alias nga="cd $SP_REPOS/analyst-ng/source/webapp-admin-ng/src/main/web-src"

alias nggr="cd $SP_REPOS/analyst-ng/source/webapp-analyst-ng-react/src/main/web-src"
alias ngar="cd $SP_REPOS/analyst-ng/source/webapp-admin-ng-react/src/main/web-src"

alias bo="cd $SP_REPOS/analyst-ng/boxbe/webapp-boxbe/src/main/web-src"

alias di="cd $SP_REPOS/analyst-ng/source/webapp-delivery-index/src/main/web-src"

alias gq="gradle clean build -x test -x webappTest -x webappLint && ge"
alias gqq="gradle clean build -x test -x webappTest -x webappCompile -x webappLint && ge"
alias gf="gradle clean build && ge"
alias ge="gradle eclipse"

# n 10.17.0;
# npm i -g npm@6.9.0;

EOF

else 
  echo "Not updating shell file"
fi
