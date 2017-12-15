Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=DtkMuNjmRm9CPhBuIckRELbpmPBqHZxJ1fYOwRG9Vuk=;
	b=TmxUBzlQByOrQM8pV4FTJ+8KTqlZ7aVNVT54PMLKBuamKD+ZF/KDzSK1FjVH5B+rTj
	OwpkREniF+aw047RCqz6nDmfAnFhjguwxoJWcQNT5OVAlB4hJVQAsYXRXbNISMqh/Jhw
	bMBoofHBqegZMwfICgEe5zX1Z+mxd2Chmbs0g92vMlS6EAYyPuu2B7nBkSaIUZy5IEE4
	9j0oz0nKeqT8d44JZM825xqggcil3fnGjDB9p7d42GtBBLFfT2Nf7DUMbZ1g3m0ko155
	O+eq/zm73gWn57/WllqQGO54HZK6CXkNE/3qBDg57szxBOvneHuN6+PR72b8GTvHT+wc
	BCqg==
MIME-Version: 1.0
From: Adrian P <adrian27oradea@gmail.com>
Date: Fri, 15 Dec 2017 15:37:39 +0200
Message-ID: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] linux bridge does not forward arp reply back packets in a
	vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I have a strange issue with a linux bridge created by
openstack-neutron (pike release). This linux bridge is hosted in a
vmware VM running latest CentOS 7, with a single network interface in
promiscuous mode.

From openstack neutron perspective, the networking setup is simple: a
single flat external provider network, with a single cirros VM
instance connected to it.

Therefore, in the linux bridge running in the vmware host, I have 3 interfaces:

# brctl show
bridge name     bridge id               STP enabled     interfaces
brq025a9a94-58          8000.005056a6b378       no              ens160
                                                        tap2eb4cad6-cd
   <----- neutron DHCP agent tap interface
                                                        tap6d31a191-9f
   <----- cirros VM instance tap interface

The ens160 is the "physical" CentOS 7 host interface, that is in
promiscuous mode.

The  tap2eb4cad6-cd tap interface is the neutron DHCP agent interface,
and the tap6d31a191-9f tap interface is used by the cirros VM
instance.

The problem is the following:

With a tcpdump, I am able to see the arp request (ARP, Request who-has
10.20.21.1 tell 10.20.21.233) going out from the cirros VM instance on
tap interface tap6d31a191-9f, and well as on the bridge itself
(brq025a9a94-58). However, the reply back to the arp request (Reply
10.20.21.1 is-at 00:17:08:c4:52:80) does not reach the cirros VM
instance anymore. With tcpdump, I am able to see the arp reply back
packets in the bridge (brq025a9a94-58), however they do not show up
anymore on the cirros VM instance tap interface tap6d31a191-9f.

To me it seems that for whatever reason, the bridge does not forward
the arp reply back packets to the cirros VM tap interface, and I do
not understand why. The strange thing is that after a while, for
apparently no reason, a single arp reply back packet gets through the
bridge and the tap interface, and the arp table gets updated with
correct IP address in the cirros VM instance. However, if I clean up
the arp table in the cirros VM instance, it takes again 10 to 15
minutes of continuously sending arp requests, until a single arp reply
back packets gets through.

I was banging my head to the table for a few days with this issue, and
finally, for apparent no reason, I manually configured the bridge max
aging time to 0, to convert it in a hub, and from that moment
everything started to work without any issue. Still, I do no
understand why is this happening, and obviously I cannot manually set
up the bridge aging time to 0 all the time in all the bridges
openstack neutron creates automatically.

Any thoughts?

Many thanks in advance.

Best regards,
Adrian
