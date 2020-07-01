
##########################################
#                                        #
#             Cockpit install            #
#                                        #
########################################## 

yum install -y cockpit
systemctl start cockpit
systemctl enable cockpit
firewall-cmd --permanent --zone=public --add-port=9090/tcp
firewall-cmd --reload

