#!/bin/bash

SUDOERS_FILE=/etc/sudoers.d/01_ssh_agent
PUPPET_INSTALLED=$(dpkg -l | grep -E '^ii' | grep puppet)

# Keep the SSH_AUTH_SOCK environment variable
if [ ! -f $SUDOERS_FILE ]; then
    touch $SUDOERS_FILE && chmod 0440 $SUDOERS_FILE
    echo "Defaults  env_keep +=\"SSH_AUTH_SOCK\"" > $SUDOERS_FILE
fi

# We need the puppet >= 2.7.0 in order to use augeas. We'll cross our fingers very hard
# that the package on the main repository meets the requirement.
#
# http://projects.puppetlabs.com/issues/14822
if [ -z "${PUPPET_INSTALLED}" ]; then
    apt-get update && apt-get install puppet -y
fi
