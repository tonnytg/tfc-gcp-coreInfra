FROM ubuntu:latest

WORKDIR /app

# Copy the local content to the container at /app
COPY . /app

# Install necessary dependencies and add HashiCorp GPG key
RUN apt-get update && apt-get install -y \
    gnupg \
    software-properties-common \
    wget \
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Verify the HashiCorp GPG key fingerprint
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add HashiCorp repository to apt sources
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# Install Terraform
RUN apt-get update && apt-get install -y terraform

# Set the default command to run 'terraform fmt' when the container starts
CMD ["terraform", "fmt"]
