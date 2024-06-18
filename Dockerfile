FROM alpinelinux/ansible:latest
COPY testkey /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

COPY test-connection/* /tmp/
# Set the environment variable for Ansible private key if it s the same key for all servers
ENV ANSIBLE_PRIVATE_KEY_FILE=/root/.ssh/id_rsa
# Disable SSH host key checking globally
ENV ANSIBLE_HOST_KEY_CHECKING=False
# For  architecture  configuration of ansible-project
ENV ANSIBLE_CONFIG=/tmp/ansible.cfg
# Run the playbook
#CMD ansible-playbook -i /tmp/inventory /tmp/playbook.yml