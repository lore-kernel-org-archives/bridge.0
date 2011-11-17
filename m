Return-Path: <kenner@gnat.com>
Date: Wed, 16 Nov 2011 22:27:15 EST
Message-Id: <20111117032716.99E5533C7D@vlsi1.gnat.com>
From: kenner@gnat.com (Richard Kenner)
Subject: [Bridge] Problems with stateful firewall and bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I'm running into problems with a stateful firewall on a bridge device.
The Linux kernel is 2.6.37.

The problem appears to be that no connection tracking entries are
being made.  conntrack -L shows no entries.

But sysctl appears to be set correctly:

net.bridge.bridge-nf-call-arptables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-filter-vlan-tagged = 0
net.bridge.bridge-nf-filter-pppoe-tagged = 0

Does anybody have any suggestions as to what I should look at next?
