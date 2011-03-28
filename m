MIME-Version: 1.0
Date: Mon, 28 Mar 2011 09:29:25 -0500
Message-ID: <AANLkTimeU78f=befoHxz6-fMsm04WPHCMJzNzAXN0hvv@mail.gmail.com>
From: Scott Koranda <skoranda@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] promiscuous mode necessary for supporting KVM?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

My platform is Debian Squeeze amd64:

$ /etc/network# cat /etc/issue
Debian GNU/Linux 6.0 \n \l

$ /etc/network# uname -r
2.6.32-5-amd64

I followed what I believe to be the "canonical" instructions
for deploying KVM to support virtual machines on this host. My
specific need is for the virtual machines to have static IP
addresses and be visible to the LAN.

This deployment included configuring a bridge like this:


$ cat /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet manual

auto br0
iface br0 inet static
address xxx.yy.zz.195
netmask 255.255.255.0
network xxx.yy.zz.0
broadcast xxx.yy.zz.255
gateway xxx.yy.zz.1
bridge_ports eth0
bridge_stp off
bridge_fd 0
bridge_maxwait 0

The bridge reports the following:

$ /etc/network# brctl show
bridge name     bridge id               STP enabled interfaces
br0             8000.0019b946d44b       no              eth0
                                                        vnet0
                                                        vnet1
                                                        vnet2
                                                        vnet3

The four VMs are using the vnetx interfaces and work exactly
as I need them to work.

A colleague, however, has written to me "The concern I have is
that apparently you must run the physical NIC in promiscuous
mode, to get bridging working with the Linux KVM module."

I want to determine if that is true.

I see the following flags set for the interfaces:

$ cat /sys/class/net/br0/flags
0x1003
$ cat /sys/class/net/eth0/flags
0x1103
$ cat /sys/class/net/vnet0/flags
0x1103

My understanding is that if the 0x100 bit is set then the
interface is in promiscuous mode.

So br0 reports it is NOT in promiscuous mode but eth0 does.

How can I tell if the "physical NIC" is in promiscuous mode?

If it is in promiscuous mode, with this configuration is that
any more of a security risk?

Why are the vnetx interfaces and eth0 in (or at least
reporting) promiscuous mode? Is that so that they can "see"
each other's traffic without having to leave the host and
return?

Thank you for your input.
