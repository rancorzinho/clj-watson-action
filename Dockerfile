FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl default-jre git jq
#RUN mkdir -p /root/.ssh/
#RUN curl curl -L https://api.github.com/meta | jq -r '.ssh_keys | .[]' | sed -e 's/^/github.com /' >> /root/.ssh/known_hosts
#RUN chmod 600 /root/.ssh/known_hosts

COPY root-config /root/
RUN sed 's|/home/runner|/root|g' -i /root/.ssh/config

RUN curl -O https://download.clojure.org/install/linux-install-1.10.3.1075.sh && chmod +x linux-install-1.10.3.1075.sh && bash linux-install-1.10.3.1075.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
