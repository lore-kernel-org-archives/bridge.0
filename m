Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Ddmd3YISJoA0BX7m7eJMuOkWqTmqMO01kALqMg4bWI4=;
	b=nNzls8gcv6GnLECI5oKe29DlPIqL06uKuMu1Jdt5TPB+/k1/mRbpw6foHUxAQH340H
	Y1c9vb+dQCQoQ/XMaxxcXo5299HNDV5owg3tEHR+qDmMdV9mmaHVj52zubETWrDOOQoL
	BYeJy8tE8YIAGSTcN0UWQqPCwHJIcMU7FfbYtT8KIUrMJzJ68izEZnMr7reRTvg0MFqd
	u3paGjrt07Qq7720/y62EsOwHNmPh/x2nSI/GJPueCiafotY6dcpx+KNKo/DhUV08HSg
	PCPOSLcGs72SkD9ePIYVsd5Ar9/6aKt3qN6Bc06Bhr7qWc/BU/C5K0G/FYi1eza+zui0
	tk5A==
MIME-Version: 1.0
In-Reply-To: <20171215174709.4cea5b98@xeon-e3>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
	<20171215075512.6138a258@xeon-e3>
	<CA+k9h3OQen=ySLH_JyrqTNyHKOkgK+eFtB8JKKLpokiZN+OuPg@mail.gmail.com>
	<20171215174709.4cea5b98@xeon-e3>
From: Adrian P <adrian27oradea@gmail.com>
Date: Sat, 16 Dec 2017 09:12:13 +0200
Message-ID: <CA+k9h3PrJK4u+wzQZWBxQxL-EN8gFx0wVCX6GZ_MkvU91VGieA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] linux bridge does not forward arp reply back packets
 in a vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

On Sat, Dec 16, 2017 at 3:47 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Fri, 15 Dec 2017 18:29:58 +0200
> Adrian P <adrian27oradea@gmail.com> wrote:
>
>> On Fri, Dec 15, 2017 at 5:55 PM, Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>> > On Fri, 15 Dec 2017 15:37:39 +0200
>> > Adrian P <adrian27oradea@gmail.com> wrote:
>> >
>> >> Hello,
>> >>
>> >> I have a strange issue with a linux bridge created by
>> >> openstack-neutron (pike release). This linux bridge is hosted in a
>> >> vmware VM running latest CentOS 7, with a single network interface in
>> >> promiscuous mode.
>> >>
>> >> From openstack neutron perspective, the networking setup is simple: a
>> >> single flat external provider network, with a single cirros VM
>> >> instance connected to it.
>> >>
>> >> Therefore, in the linux bridge running in the vmware host, I have 3 interfaces:
>> >>
>> >> # brctl show
>> >> bridge name     bridge id               STP enabled     interfaces
>> >> brq025a9a94-58          8000.005056a6b378       no              ens160
>> >>                                                         tap2eb4cad6-cd
>> >>    <----- neutron DHCP agent tap interface
>> >>                                                         tap6d31a191-9f
>> >>    <----- cirros VM instance tap interface
>> >>
>> >> The ens160 is the "physical" CentOS 7 host interface, that is in
>> >> promiscuous mode.
>> >>
>> >> The  tap2eb4cad6-cd tap interface is the neutron DHCP agent interface,
>> >> and the tap6d31a191-9f tap interface is used by the cirros VM
>> >> instance.
>> >>
>> >> The problem is the following:
>> >>
>> >> With a tcpdump, I am able to see the arp request (ARP, Request who-has
>> >> 10.20.21.1 tell 10.20.21.233) going out from the cirros VM instance on
>> >> tap interface tap6d31a191-9f, and well as on the bridge itself
>> >> (brq025a9a94-58). However, the reply back to the arp request (Reply
>> >> 10.20.21.1 is-at 00:17:08:c4:52:80) does not reach the cirros VM
>> >> instance anymore. With tcpdump, I am able to see the arp reply back
>> >> packets in the bridge (brq025a9a94-58), however they do not show up
>> >> anymore on the cirros VM instance tap interface tap6d31a191-9f.
>> >>
>> >> To me it seems that for whatever reason, the bridge does not forward
>> >> the arp reply back packets to the cirros VM tap interface, and I do
>> >> not understand why. The strange thing is that after a while, for
>> >> apparently no reason, a single arp reply back packet gets through the
>> >> bridge and the tap interface, and the arp table gets updated with
>> >> correct IP address in the cirros VM instance. However, if I clean up
>> >> the arp table in the cirros VM instance, it takes again 10 to 15
>> >> minutes of continuously sending arp requests, until a single arp reply
>> >> back packets gets through.
>> >>
>> >> I was banging my head to the table for a few days with this issue, and
>> >> finally, for apparent no reason, I manually configured the bridge max
>> >> aging time to 0, to convert it in a hub, and from that moment
>> >> everything started to work without any issue. Still, I do no
>> >> understand why is this happening, and obviously I cannot manually set
>> >> up the bridge aging time to 0 all the time in all the bridges
>> >> openstack neutron creates automatically.
>> >>
>> >> Any thoughts?
>> >>
>> >> Many thanks in advance.
>> >>
>> >> Best regards,
>> >> Adrian
>> >
>> > Does each tap instance and the ens160 have a different and valid Ethernet
>> > address?  Also make sure the these are in the bridge forwarding table.
>>
>> Yes, they have valid Ethernet addresses, and they do show up in the
>> forwarding table twice, see below:
>>
>> # ip addr
>> <...>
>> 2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master
>> brq025a9a94-58 state UP qlen 1000
>>     link/ether 00:50:56:a6:b3:78 brd ff:ff:ff:ff:ff:ff
>>     inet6 fe80::250:56ff:fea6:b378/64 scope link
>>        valid_lft forever preferred_lft forever
>> 4: tap2eb4cad6-cd@if2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
>> qdisc noqueue master brq025a9a94-58 state UP qlen 1000
>>     link/ether 8a:b2:15:4c:96:55 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>> 5: brq025a9a94-58: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
>> noqueue state UP qlen 1000
>>     link/ether 00:50:56:a6:b3:78 brd ff:ff:ff:ff:ff:ff
>>     inet 10.20.21.249/24 brd 10.20.21.255 scope global brq025a9a94-58
>>        valid_lft forever preferred_lft forever
>>     inet6 fe80::803d:d0ff:fe2e:3ae4/64 scope link
>>        valid_lft forever preferred_lft forever
>> 6: tap6d31a191-9f: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
>> pfifo_fast master brq025a9a94-58 state UNKNOWN qlen 1000
>>     link/ether fe:16:3e:9a:04:95 brd ff:ff:ff:ff:ff:ff
>>     inet6 fe80::fc16:3eff:fe9a:495/64 scope link
>>        valid_lft forever preferred_lft forever
>>
>> # brctl showmacs brq025a9a94-58
>> port no mac addr                is local?       ageing timer
>>   1     00:50:56:a6:b3:78       yes                0.00
>>   1     00:50:56:a6:b3:78       yes                0.00
>>   2     8a:b2:15:4c:96:55       yes                0.00
>>   2     8a:b2:15:4c:96:55       yes                0.00
>>   3     fe:16:3e:9a:04:95       yes                0.00
>>   3     fe:16:3e:9a:04:95       yes                0.00
>
>
> Since there are multiple entries per port maybe you are also using VLANs?

So I have checked one more time: the host is a vmware centos7 VM, with
a single interface (ens160 that can be seen above) connected to a
vmware virtual switch port group configured in promiscuous mode, that
removes the VLAN tagging (similar with access mode port in a physical
switch).

I have another environment that behaves the same, where the host is a
physical server, and the interface is a bonded interface, with two
slaves, and I also have two entries for each local interface in the
forwarding table:

# ip addr
<...>
6: eno5: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq
master bond2 portid 01000000000000000000004c4930394833 state UP qlen
1000
    link/ether fc:15:b4:13:e6:a3 brd ff:ff:ff:ff:ff:ff
7: eno6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq
master bond2 portid 02000000000000000000004c4930394833 state UP qlen
1000
    link/ether fc:15:b4:13:e6:a3 brd ff:ff:ff:ff:ff:ff
<...>
10: bond2: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc
noqueue master brq75a55ef7-4a state UP qlen 1000
    link/ether fc:15:b4:13:e6:a3 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::fe15:b4ff:fe13:e6a3/64 scope link
       valid_lft forever preferred_lft forever
<...>
14: brq75a55ef7-4a: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP qlen 1000
    link/ether fc:15:b4:13:e6:a3 brd ff:ff:ff:ff:ff:ff
    inet 10.20.21.55/24 brd 10.20.21.255 scope global brq75a55ef7-4a
       valid_lft forever preferred_lft forever
15: tap44bc34bb-e2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
pfifo_fast master brq75a55ef7-4a state UNKNOWN qlen 1000
    link/ether fe:16:3e:cc:dc:ec brd ff:ff:ff:ff:ff:ff
    inet6 fe80::fc16:3eff:fecc:dcec/64 scope link
       valid_lft forever preferred_lft forever

# brctl show
bridge name     bridge id               STP enabled     interfaces
brq75a55ef7-4a          8000.fc15b413e6a3       no              bond2
                                                        tap44bc34bb-e2

# brctl showmacs brq75a55ef7-4a | grep yes
  2     fc:15:b4:13:e6:a3       yes                0.00
  2     fc:15:b4:13:e6:a3       yes                0.00
  1     fe:16:3e:cc:dc:ec       yes                0.00
  1     fe:16:3e:cc:dc:ec       yes                0.00
