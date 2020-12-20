# stl-security

Add oddjobd.rb recipe to enable and start oddjobd.service due to bug issue:

https://github.com/clustervision/trinityX/issues/289

This was necessary regarding the fact that our home directories werent creating.

This was affecting the variable log2rsyslog responsible to send the bash history for the users to our CLS.
