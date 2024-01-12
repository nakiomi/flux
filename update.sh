RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${GREEN}Updating proxy...${ENDCOLOR}"

# Check if "flux" file exists
if [ -f "flux" ]; then
    echo -e "${RED}Deleting old proxy...${ENDCOLOR}"
    rm flux
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error deleting old proxy.${ENDCOLOR}"
        exit 1
    fi
    sleep 1
fi

# Check and download new proxy only if the version is different
current_version=$(./flux --version)  # Change this to get the version from the existing flux file
latest_version=$(wget -qO- https://github.com/Zweaf/flux/raw/main/flux --version)  # Change this to get the version from the online source

if [[ "$current_version" != "$latest_version" ]]; then
    echo -e "${GREEN}Getting new proxy...${ENDCOLOR}"
    wget -q https://github.com/Zweaf/flux/raw/main/flux
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Download successful.${ENDCOLOR}"
    else
        echo -e "${RED}Download failed.${ENDCOLOR}"
        exit 1
    fi
    sleep 1
else
    echo -e "${GREEN}Proxy is already up to date.${ENDCOLOR}"
fi

# Execute the updated proxy
echo -e "${GREEN}Executing proxy...${ENDCOLOR}"
chmod +x flux
./flux