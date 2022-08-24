FROM docker:20.10.17 as docker
FROM python:3.9.12-alpine3.15
ARG TF_VERSION=1.1.9
ARG TERRASCAN_VERSION=1.14.0
ARG KUBECTL_VERSION=v1.24.0
ARG HELM_VERSION=v3.9.0
COPY --from=docker /usr/local/bin/docker /usr/local/bin/
COPY utils/awssudo/awssudo /usr/local/bin/
RUN chmod +x /usr/local/bin/awssudo
RUN apk --no-cache update && \
    apk --no-cache add curl bash git make tar jq npm && \
    npm install --global snyk snyk-to-html && \
    pip --no-cache-dir install --upgrade pip && \
    pip --no-cache-dir install awscli && \
    pip --no-cache-dir install boto3 && \
    curl -sSLO --show-error https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    curl -sSLO --show-error https://github.com/accurics/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz && \
    tar -xvzf terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz && \
    mv terrascan /usr/bin && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \ 
    tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf *.* /tmp/* /var/cache/apk/*               
ENTRYPOINT ["/bin/bash", "-l", "-c"]
