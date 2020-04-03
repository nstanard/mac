#!/bin/bash

export JETTY_FOLDER_NAME="jetty"

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            # link)              link=${VALUE} ;;
            jettypath)              jettypath=${VALUE} ;;
            repo)              repo=${VALUE} ;;
            *)
    esac    
done

echo ""
read -p "Would you like to configure jetty for analyst-ng? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
    # rm -f "$link/$JETTY_FOLDER_NAME"
    # LINKING WAS FOR HOMEBREW FORMULA, SO TURN IT OFF IF WE ARE USING THE MANUAL INSTALL
    # ln -sf "$jetty_dir" "$link/$JETTY_FOLDER_NAME"
    # mkdir -p "$link/$JETTY_FOLDER_NAME/webapps"
    # mkdir -p "$link/$JETTY_FOLDER_NAME/disabled-webapps"
    # echo $jettypath
    mkdir -p "$jettypath/webapps" && sudo chown $USER "$jettypath/webapps"
    mkdir -p "$jettypath/disabled-webapps" && sudo chown $USER "$jettypath/disabled-webapps"

    # Create webapp .xml file for Analyst
    # touch "$link/$JETTY_FOLDER_NAME/webapps/analyst-ng.xml"
    # cat > "$link/$JETTY_FOLDER_NAME/disabled-webapps/analyst-ng.xml" <<-EOF
    touch "$jettypath/webapps/analyst-ng.xml"
    cat > "$jettypath/webapps/analyst-ng.xml" <<-EOF
<Configure class="org.eclipse.jetty.webapp.WebAppContext">
    <Set name="contextPath">/analyst-ng</Set>
        <Set name="war">$repo/analyst-ng/source/webapp-analyst-ng/target/libs/eds-webapp-analyst-ng-SNAPSHOT.war</Set>
    <Set name="extractWAR">true</Set>
    <Set name="copyWebDir">false</Set>
    <Set name="defaultsDescriptor">
        <SystemProperty name="jetty.home" default="."/>/etc/webdefault.xml
    </Set>
    <Call name="setAttribute">
       <Arg>org.eclipse.jetty.server.webapp.WebInfIncludeJarPattern</Arg>
       <Arg>(?!module-info\.class)</Arg>
    </Call>
</Configure>
EOF

    # Create webapp .xml file for Admin
    # touch "$link/$JETTY_FOLDER_NAME/disabled-webapps/admin-ng.xml"
    # cat > "$link/$JETTY_FOLDER_NAME/disabled-webapps/admin-ng.xml" <<-EOF
    touch "$jettypath/disabled-webapps/admin-ng.xml"
    cat > "$jettypath/disabled-webapps/admin-ng.xml" <<-EOF
<Configure class="org.eclipse.jetty.webapp.WebAppContext">
    <Set name="contextPath">/admin-ng</Set>
        <Set name="war">$repo/analyst-ng/source/webapp-admin-ng/target/libs/eds-webapp-admin-ng-SNAPSHOT.war</Set>
    <Set name="extractWAR">true</Set>
    <Set name="copyWebDir">false</Set>
    <Set name="defaultsDescriptor">
        <SystemProperty name="jetty.home" default="."/>/etc/webdefault.xml
    </Set>
    <Call name="setAttribute">
       <Arg>org.eclipse.jetty.server.webapp.WebInfIncludeJarPattern</Arg>
       <Arg>.*/eds[^/]*\.jar$|.*/classes/.*</Arg>
    </Call>
</Configure>
EOF

    # Create webapp .xml file for Boxbe
    # touch "$link/$JETTY_FOLDER_NAME/disabled-webapps/boxbe.xml"
    # cat > "$link/$JETTY_FOLDER_NAME/disabled-webapps/boxbe.xml" <<-EOF
    touch "$jettypath/disabled-webapps/boxbe.xml"
    cat > "$jettypath/disabled-webapps/boxbe.xml" <<-EOF
<?xml version="1.0" encoding="ISO-8859-1"?>
	<!DOCTYPE Configure PUBLIC "-//Jetty//Configure//EN" "http://www.eclipse.org/jetty/configure_9_0.dtd">
	<Configure class="org.eclipse.jetty.webapp.WebAppContext">
	<Set name="contextPath">/boxbe</Set>
	<Set name='war'>$repo/analyst-ng/boxbe/webapp-boxbe/target/libs/boxbe-webapp-boxbe-SNAPSHOT.war</Set>
	<Set name="extractWAR">true</Set>
	<Set name="copyWebDir">false</Set>
	<Set name="defaultsDescriptor">
		<SystemProperty name="jetty.home" default="."/>/etc/webdefault.xml
	</Set>
   	<Call name="setAttribute">
       	<Arg>org.eclipse.jetty.server.webapp.WebInfIncludeJarPattern</Arg>
       	<Arg>(?!module-info\.class)</Arg>
    </Call>
</Configure>
EOF

    # Create webapp .xml file for DI
    # touch "$link/$JETTY_FOLDER_NAME/disabled-webapps/delivery-index.xml"
    # cat > "$link/$JETTY_FOLDER_NAME/disabled-webapps/delivery-index.xml" <<-EOF
    touch "$jettypath/disabled-webapps/delivery-index.xml"
    cat > "$jettypath/disabled-webapps/delivery-index.xml" <<-EOF
<?xml version="1.0"  encoding="ISO-8859-1"?>
<!DOCTYPE Configure PUBLIC "-//Jetty//Configure//EN" "http://www.eclipse.org/jetty/configure_9_0.dtd">
<Configure class="org.eclipse.jetty.webapp.WebAppContext">
        <Set name="contextPath">/delivery-index</Set>
        <Set name='war'>$repo/analyst-ng/source/webapp-delivery-index/target/libs/eds-webapp-delivery-index-SNAPSHOT.war</Set>
        <Set name="extractWAR">true</Set>
        <Set name="copyWebDir">false</Set>
        <Set name="defaultsDescriptor">
                <SystemProperty name="jetty.home" default="."/>/etc/webdefault.xml
        </Set>
   		<Call name="setAttribute">
       		<Arg>org.eclipse.jetty.server.webapp.WebInfIncludeJarPattern</Arg>
       		<Arg>(?!module-info\.class)</Arg>
    	</Call>
</Configure>

EOF

fi
