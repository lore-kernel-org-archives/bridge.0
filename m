DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
	bh=9l9UHVUx8lQdo0e+cHuMu86NC0genO0IN2jds1NkVG4=;
	b=GUdZEE+OkCjuhyZUI6IXS2SxnbMyPOgUtSZg1imMWvK5HsSd7sliDAU07fH7I/GPx9ltdOHlixz+WhV7ZGH7UcVIJ1yB3oEG+igxVZz5MuWtlykzzK+uthaMIEAIA87YotDPOY0xO+1iZb2vzfvNJ8frpv7ykbiP5H4EXZcGnTk=
Message-ID: <5ff1e2470802122219n2a846fb0xd66ec3ded4178256@mail.gmail.com>
Date: Wed, 13 Feb 2008 11:49:42 +0530
From: "Sathyan M" <sathym@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Bridge and iptables
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I am using linux kernle-2.6.15, iptables-1.4 and bridge-utils-1.4.
Everything intslled without any issue and i am able to enable the
bridge and traffic is also flowing without any issue.

But i did not see any traffic on the iptables forward chain due to
which i am not able to control the traffic.

Do i requie enable anything more to make the traffic pass through
iptables forward chain.

Please look into the configuration
ip addr
1: lo: <LOOPBACK> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: tunl0: <NOARP> mtu 1480 qdisc noop
    link/ipip 0.0.0.0 brd 0.0.0.0
3: gre0: <NOARP> mtu 1476 qdisc noop
    link/gre 0.0.0.0 brd 0.0.0.0
10: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:07:d9:0d:67:5a brd ff:ff:ff:ff:ff:ff
11: eth1: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:07:d9:0d:67:03 brd ff:ff:ff:ff:ff:ff
12: br0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/ether 00:07:d9:0d:67:03 brd ff:ff:ff:ff:ff:ff
    inet 10.10.5.2/24 brd 10.10.5.255 scope global br0

iptables -L -nvx
Chain INPUT (policy ACCEPT 4484 packets, 330543 bytes)
    pkts      bytes target     prot opt in     out     source
     destination

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source
     destination

Chain OUTPUT (policy ACCEPT 4105 packets, 2046064 bytes)
    pkts      bytes target     prot opt in     out     source
     destination
