FROM mcr.microsoft.com/devcontainers/universal:3.0.3

# Install SSH server and other dependencies
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create SSH directory
RUN mkdir -p /var/run/sshd

# Set up root user with password
RUN echo 'root:pass' | chpasswd

# Configure SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    echo 'Port 22' >> /etc/ssh/sshd_config

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root.cargo/bin:${PATH}"

# Install convco (conventional commits tool)
RUN /root/.cargo/bin/cargo install convco

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    rm -rf /var/lib/apt/lists/*

# Create workspace directory
RUN mkdir -p /workspace

# Create jetbrains directory
RUN mkdir -p /jetbrains

# Backup the original SSH server configuration and keys
RUN cp -r /etc/ssh /etc/ssh-defaults

# Create entrypoint script
RUN cat > /entrypoint.sh << 'EOF'
#!/bin/bash

# Function to populate SSH server config if directory is empty
populate_ssh_config() {
    if [ -d "/etc/ssh" ] && [ -z "$(ls -A /etc/ssh)" ]; then
        echo "SSH config directory is empty, populating with defaults..."
        cp -r /etc/ssh-defaults/* /etc/ssh/

        # Generate new host keys if they don't exist
        if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
            echo "Generating SSH host keys..."
            ssh-keygen -A
        fi

        # Ensure proper permissions
        chmod 600 /etc/ssh/ssh_host_*_key
        chmod 644 /etc/ssh/ssh_host_*_key.pub
        chmod 644 /etc/ssh/sshd_config
    fi
}

# Populate SSH config if needed
populate_ssh_config

# Start SSH service and keep container running
service ssh start && tail -f /dev/null
EOF

RUN chmod +x /entrypoint.sh

# Set up bash history to append on exit. On container restart, the history will be preserved if bind mounted.
RUN echo 'PROMPT_COMMAND="history -a;$PROMPT_COMMAND"' >> /root/.bashrc

# Expose SSH port
EXPOSE 22

# Expose common development ports
EXPOSE 3000 3001 4200 5000 5173 8000 8080 8081 9000

CMD ["/entrypoint.sh"]
