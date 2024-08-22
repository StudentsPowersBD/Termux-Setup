#!/bin/bash

# Define colors and styles
GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
BOLD="\033[1m"
ITALIC="\033[3m"

# Function for animated text
animate_text() {
    text="$1"
    color="$2"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${color}${text:$i:1}${RESET}"
        sleep 0.03
    done
    echo
}

# Function for progress bar
show_progress() {
    local duration=$1
    local steps=$2
    local width=$3
    local message=$4
    
    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$steps; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($steps)*100/100 )); }
    clean_line() { printf "\r"; }

    for (( elapsed=1; elapsed<=$steps; elapsed++ )); do
        already_done; remaining; percentage
        sleep $(( $duration/$steps ))
        clean_line
    done
    clean_line
    echo -e "${GREEN}$message${RESET}"
}

# Fancy banner with animation
clear
figlet -f slant "Termux Pro Setup" | lolcat -a -d 1 -s 50
sleep 1

# Welcome message with animated typing effect
animate_text "${CYAN}${BOLD}Initializing your advanced Termux environment setup...${RESET}" "$CYAN"
sleep 2

# Update and upgrade packages with progress indicator
echo -e "${YELLOW}${BOLD}Updating and upgrading packages...${RESET}"
show_progress 5 20 50 "Packages updated and upgraded!"

# Install required packages with animations
PACKAGES=(python python2 git figlet cmatrix toilet nano php ruby openssh wget curl neofetch htop nmap vim tmux zsh)
for package in "${PACKAGES[@]}"; do
    echo -e "${YELLOW}Installing ${BOLD}$package${RESET}${YELLOW}...${RESET}"
    show_progress 2 10 30 "$package installed!"
done

# Install Python packages
echo -e "${YELLOW}${BOLD}Installing Python packages...${RESET}"
pip install --upgrade pip > /dev/null 2>&1
pip install requests future beautifulsoup4 colorama pytest black isort mypy > /dev/null 2>&1
show_progress 3 15 40 "Python packages installed!"

# Setup storage permissions
echo -e "${YELLOW}${BOLD}Setting up storage permissions...${RESET}"
termux-setup-storage
show_progress 1 5 20 "Storage setup complete!"

# Install and configure Oh My Zsh
echo -e "${YELLOW}${BOLD}Installing and configuring Oh My Zsh...${RESET}"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions > /dev/null 2>&1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > /dev/null 2>&1
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
show_progress 3 15 40 "Oh My Zsh installed and configured!"

# Configure Vim
echo -e "${YELLOW}${BOLD}Configuring Vim...${RESET}"
cat << EOF > ~/.vimrc
set number
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
syntax on
colorscheme desert
EOF
show_progress 1 5 20 "Vim configured!"

# Configure Tmux
echo -e "${YELLOW}${BOLD}Configuring Tmux...${RESET}"
cat << EOF > ~/.tmux.conf
set -g default-terminal "screen-256color"
set -g status-bg black
set -g status-fg white
set -g mouse on
bind | split-window -h
bind - split-window -v
EOF
show_progress 1 5 20 "Tmux configured!"

# Create a cool welcome script
echo -e "${YELLOW}${BOLD}Creating welcome script...${RESET}"
cat << 'EOF' > ~/.termux_welcome.sh
#!/bin/bash
echo "Welcome to your advanced Termux setup!" | lolcat
echo "=========================" | lolcat
echo "System Information:" | lolcat
neofetch
echo "=========================" | lolcat
echo "Happy coding!" | lolcat
EOF
chmod +x ~/.termux_welcome.sh
echo "~/.termux_welcome.sh" >> ~/.zshrc
show_progress 2 10 30 "Welcome script created!"

# Opening browser to Telegram channels
echo -e "${YELLOW}${BOLD}Opening browser for recommended Telegram channels...${RESET}"
termux-open-url "https://t.me/StudentsPowersBD"
termux-open-url "https://t.me/VorTexCyberBD"
termux-open-url "https://t.me/GenerationZoomersBD"
show_progress 1 5 20 "Channels opened in browser!"

# Adding some fun with CMatrix and Figlet
echo -e "${MAGENTA}${BOLD}Launching a fun CMatrix animation...${RESET}"
timeout 5s cmatrix -C cyan -s

# Success message with cool style
figlet -f slant "Setup Complete" | lolcat -a -d 1 -s 50
echo -e "${CYAN}${BOLD}Your Termux environment is now fully configured and ready for pro development! Enjoy!${RESET}"

# Final good-bye message with styling
echo -e "${BLUE}${ITALIC}Visit the channels for more updates and tools!${RESET}"
animate_text "${MAGENTA}${BOLD}Happy coding with your advanced Termux setup!${RESET}" "$MAGENTA"

# Switch to Zsh
zsh
