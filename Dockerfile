FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl default-jre git jq
RUN mkdir -p /root/.ssh/
RUN curl --silent https://api.github.com/meta  | jq --raw-output '"github.com "+.ssh_keys[]' >> /root/.ssh/known_hosts 
RUN chmod 600 /root/.ssh/known_hosts

RUN curl -O https://download.clojure.org/install/linux-install-1.10.3.1075.sh && chmod +x linux-install-1.10.3.1075.sh && bash linux-install-1.10.3.1075.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
