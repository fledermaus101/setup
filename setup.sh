#!/bin/bash
###########################
# Auto elevate privileges #
###########################
if [ "$EUID" -ne 0 ]; then sudo "$0" "$@"; exit $?; fi

#################################
# Set home directory if not set #
#################################
if ![ "$HOME" = '/home' ]; then usermod -d /home root; fi
# Also navigate into it
cd /home

#################
# Install tools #
#################
apt-get install htop screen vim zip unzip git -y

##########################################
# Install the Ultimate Vim configuration #
#     https://github.com/amix/vimrc      #
##########################################
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

######################
# Copy default files #
######################
cp /etc/skel/.* ~

#################
# Copy ssh keys #
#################
# Create ~/.ssh directory if not exists
if [ ! -d "~/.ssh" ]; then mkdir ~/.ssh; fi
# Paste keys into ~/.ssh/authorized_keys
cat >> ~/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPNnDZo3ELvRwY96Gn8CRTscHmm6KY3cVoozPJhy3ZsYFV0TMGSW0VafUOn8CF5DFYTN1fLmvJoTS70ztpum8+sD5UKdlsLR+qZSUf9gxURuj2mnkti6a0e2Lk4X39wVD3ch23qVKpy3BrUYgfWbEI9/ly+HRPg6dbn/UE+JQyn4Kf+11PiXPibWeMSi/+EahaEDFHQJ0x8OxNQrixLcWMJXwc5S7HeE/Fzm6Ji4qDZx8I1rwznnRX1qvlyvwjPCm0wEluc40WbAjhGR2nWuhl1u6l5zwfBW7K5+OW8bfd/naTXMZV8ohGgSQpYRdIs1aKRKSHoYYNn3zUnrlP0mfd susan@DESKTOP-B68BGFQ
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEQkstdK+Nk9NgRvBGYyqZwTTxygdP41DApCv/FoR65ZwlMJkRi3prRaSrnab7VQaTed/MLyv9UrYwRzc6nasKF2530yO/GSjAEol012Sb3CgzwMKdh00ZTiMCzNHK35didAbQZ4rXccNvbtQ4aiyc1GdATD2/vFpf/4GLZr0xeKKUgtHmGrlbpDh71q/TfjYjmu4xZ0zC0mh8ZhaByf5y32FMQIQ0YvBzOjEdyJjufSDX5qs94GHV/qyXjdlO+1HVeCtfXB2fTJsrFSxe8awarnF7zlYUoYAjs4KuwyqNID9AbwCUsQ9sKA1RlxrqP7OljsDJ4LzQ2KfO6aPNY7cr flori@rtx
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDarwoMbMolscSDOof97iIrdBesXWA5A0dLSsYA9hX9yYxK2QKvQvgoOtO5go8qMJkPTO3FtO40qBFMJVKX6+BpSdnJ92Lrp4mVBtFacehBWAH42SraNTwVUiamZXRprWd2U72PhsmdGvYEmq7M0woJO2o5IHQyAP8IsAc5+Lc2shb5D68S/T6RhsttAzUz8xiE3ETKIqICrYh2059vZbeBzdHVzrzfFlwwHdBZAgdoPnwG5LkrkTiLCq8RU+fncdOv+GSwpEPABQeRwsp5kyG0vToC7ViMi7X0LVJ7ynsD+WOMqrCXJMBNob3tzSerF6ruLSodXr5teYUml0SsHn5Z susan@DESKTOP-B68BGFQ
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+yK6ZIAJ4CkUPrihFpRgsZqPUD5DMuXEqPjtNNaLQO8BsyG9bcdX3+CcajhZk95oz7nKIpsDMqA71RD7scInqJPQh8ZheH4KzTZCvW9MoNz2Sd+i2Kj3IZ32df8+S2F38abEledVOQKAR92IQjZ/6SPQoDuFxbjpT0Yqm6W0TiCT7uiewOhnmXFkd9+ym3WHks8AHWlPYy//8tL0NTRGPsuzTnPEZsdyg1xdL4FjSxbtaTiemEiNABxw8BF2dttpt71KS8LNoLEj7781OoWpRleBLUKb4kfVTvKtigUvOthLFL5KuKl/5fBeTRvDd6lIqwz3lwbyvqG/9a75GSco/ florian@rtx
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH7CSLx2XGPnKrHRFDD8XFmxJWzmmWSsn7a75Bn4S/ZhPu3+10cVbgEmUhnuuTsZuyVky1fLrDNA7oEZlqKi2yf3r/j7jYxwuL+VS/AR7bjQ3RW1d98Vmpw8rfGbv6bX/EJ99ehI928q3poEEgpw8ViJhAjd4ys7rLgcWJcrotKVO0eQJIfBSrUAlA59w6J6M1tqstNFo+M+pOFOKQie2UGE+NV1m31pntoCpo5x87bJIHQbastfbsGLDUocuoB4NRlOcHsCP6VyyWHMsQBtrQZy/RVwMWWKdoMQ25T/Iz0knFZsuymHujSOrJfYnJsjamtD/mL7CocSlXZvBIfPD1 susan@DESKTOP-L04JQKH
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPNnDZo3ELvRwY96Gn8CRTscHmm6KY3cVoozPJhy3ZsYFV0TMGSW0VafUOn8CF5DFYTN1fLmvJoTS70ztpum8+sD5UKdlsLR+qZSUf9gxURuj2mnkti6a0e2Lk4X39wVD3ch23qVKpy3BrUYgfWbEI9/ly+HRPg6dbn/UE+JQyn4Kf+11PiXPibWeMSi/+EahaEDFHQJ0x8OxNQrixLcWMJXwc5S7HeE/Fzm6Ji4qDZx8I1rwznnRX1qvlyvwjPCm0wEluc40WbAjhGR2nWuhl1u6l5zwfBW7K5+OW8bfd/naTXMZV8ohGgSQpYRdIs1aKRKSHoYYNn3zUnrlP0mfd susan@DESKTOP-B68BGFQ
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEQkstdK+Nk9NgRvBGYyqZwTTxygdP41DApCv/FoR65ZwlMJkRi3prRaSrnab7VQaTed/MLyv9UrYwRzc6nasKF2530yO/GSjAEol012Sb3CgzwMKdh00ZTiMCzNHK35didAbQZ4rXccNvbtQ4aiyc1GdATD2/vFpf/4GLZr0xeKKUgtHmGrlbpDh71q/TfjYjmu4xZ0zC0mh8ZhaByf5y32FMQIQ0YvBzOjEdyJjufSDX5qs94GHV/qyXjdlO+1HVeCtfXB2fTJsrFSxe8awarnF7zlYUoYAjs4KuwyqNID9AbwCUsQ9sKA1RlxrqP7OljsDJ4LzQ2KfO6aPNY7cr flori@rtx
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDarwoMbMolscSDOof97iIrdBesXWA5A0dLSsYA9hX9yYxK2QKvQvgoOtO5go8qMJkPTO3FtO40qBFMJVKX6+BpSdnJ92Lrp4mVBtFacehBWAH42SraNTwVUiamZXRprWd2U72PhsmdGvYEmq7M0woJO2o5IHQyAP8IsAc5+Lc2shb5D68S/T6RhsttAzUz8xiE3ETKIqICrYh2059vZbeBzdHVzrzfFlwwHdBZAgdoPnwG5LkrkTiLCq8RU+fncdOv+GSwpEPABQeRwsp5kyG0vToC7ViMi7X0LVJ7ynsD+WOMqrCXJMBNob3tzSerF6ruLSodXr5teYUml0SsHn5Z susan@DESKTOP-B68BGFQ
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+yK6ZIAJ4CkUPrihFpRgsZqPUD5DMuXEqPjtNNaLQO8BsyG9bcdX3+CcajhZk95oz7nKIpsDMqA71RD7scInqJPQh8ZheH4KzTZCvW9MoNz2Sd+i2Kj3IZ32df8+S2F38abEledVOQKAR92IQjZ/6SPQoDuFxbjpT0Yqm6W0TiCT7uiewOhnmXFkd9+ym3WHks8AHWlPYy//8tL0NTRGPsuzTnPEZsdyg1xdL4FjSxbtaTiemEiNABxw8BF2dttpt71KS8LNoLEj7781OoWpRleBLUKb4kfVTvKtigUvOthLFL5KuKl/5fBeTRvDd6lIqwz3lwbyvqG/9a75GSco/ florian@rtx
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDK7N0EUp1GX3rM0LEXip500ZEOcwXVUFK5TfNI/LGGSvO4dzjfnmvAaaHYeWAWjmMOeRNfHJOt/ZsA9L/FblYlbSW2/7aXj4/3cruwxvAaSCI4TjuH7jLbRvkMVAOJPe4fp823kot8guozEgSWt8FRyfR4eVX4rROb5ya1sDMBV98uBHbg+dN6PJ11fe0TqftbMMTaqJU9O/AiIGtt2iVd6hCqc4BxVLRuZ8V70k1ItIf8Riq57y5gBqjYi08+V89XAZUT6syoFFaHuJcYd7uzBQfiv3JV8onDO+snJr7giNFO9xorC1vZm6dMoQKeo5iZC0+Loe2IoKMfXGUido36t+kDuqBV0B+Iyy4MCwlj1ncmA74xyU+KUHS+3ljo2jC81MMrSw9KVIsNsveyrrc2/Fagcpv4kacQPSKIa5Klqy8jqE/iP62et6C+rVTcM9FVk07yYLyzG+E9d8PXGoxt8iLRFEQJZJnLtOViud/b/ekO8vy5OIbiFjk7QowVgnM= sandkasten@sandkasten-desktop
EOF

##################
# Insert aliases #
##################
# Bash aliases
cat >> ~/.bashrc <<EOF
alias c='screen -x'
alias ls='ls --color=auto'
alias l='ls --color=auto -lAh'
alias la='ls --color=auto -lisAh'
EOF
# Sckill alias
cat > /usr/local/sbin/sckill <<EOF
#!/bin/bash
if [ -n "$1" ]; then
   screen -S "$1" -X quit
else
   echo "Please specify a screen"
fi
EOF

##############################
# Unpack ever .tgz file in ~ #
##############################
for filename in /home/*.tgz; do
   tar -xvpzf "$filename"
done

##########################
# Add execute permission #
##########################
chmod +x /usr/local/sbin/sckill
chmod +x /home/*
