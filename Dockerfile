FROM terraform:0.12.24
WORKDIR /terraform
COPY . .
RUN terraform init