#!/bin/bash
cat << 'EOF'
__     _______ _  _____  _   _ _____ _____ 
\ \   / / ____| |/ / _ \| \ | | ____|_   _|
 \ \ / /|  _| | ' / | | |  \| |  _|   | |  
  \ V / | |___| . \ |_| | |\  | |___  | |  
   \_/  |_____|_|\_\___/|_| \_|_____| |_|  
                                           
EOF
install_netcat() {
	echo "Netcat not found! define the name distro for install"
	
	if command -v apt-get &> /dev/null; then
		echo "Detected Debian/Ubuntu (apt)..."
		sudo apt-get update && sudo apt-get install -y netcat-openbsd
	elif command -v dnf &> /dev/null; then
		echo "Detected RHEL/Fedora/CantOS (dnf)..."
		sudo dnf install -y nc
	elif command -v yum &> /dev/null; then
		echo "Detected old RHEL/CentOS (yum)..."
		sudo yum install -y nc
	elif command -v pacman &> /dev/null; then
		echo "DETECTED ARCH LINUX!!! REMOVE OS!!!!" 
		for i in {5..1}; do echo -n "$i... "; sleep 1; done; echo "START!"
		echo "(pacman i use arch btw :3)... chill, just joke! =]"
		sudo pacman -Syu --noconfirm gnu-netcat
	elif command -v zypper &> /dev/null; then
		echo "Detected openSUSE (zypper)..."
		sudo zypper install -y netcat-openbsd
	elif command -v apk &> /dev/null; then
		echo "Detected Alpine Linux (apk)..."
		sudo apk add netcat-openbsd
	else
		echo "ERROR!!!! I cant detected name your distro =[. BYE!"
		exit 1
	fi
}

if ! command -v nc &> /dev/null; then
	install_netcat
else
	echo "NetCat rady for work!!!"
fi
echo "Choose"
echo "1) Scan ports"
echo "2) Banner Grabbing"
echo "3) Exit"

read -p "Enter your choice [1-3]: " choice

case "$choice" in
    1)
        read -p "Enter target IP or hostname: " target
        echo "Scanning ports on $target..."
	for port in $(seq 1 65535); do
    		if nc -z -w 1 "$target" $port 2>/dev/null; then
        		echo "Port $port: OPEN"
        		echo "Port $port: OPEN" >> scan_$(date +"%Y-%m-%d").txt
    		fi
	done
        ;;
    2)	
	read -p "Enter target IP or name site: " target
	read -p "Enter port: " port
	echo "" | nc -w 2 "$target" "$port"
	;;
    3)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac
