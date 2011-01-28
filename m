MIME-Version: 1.0
In-Reply-To: <AANLkTimwB1pGHPQ6j6joQB0TSxpGW4P8kBSahpQ6amL1@mail.gmail.com>
References: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
	<AANLkTikQtHi15t9hSck8-p-fhf3QNXfY02PwxQ_4tSNW@mail.gmail.com>
	<AANLkTimwB1pGHPQ6j6joQB0TSxpGW4P8kBSahpQ6amL1@mail.gmail.com>
Date: Fri, 28 Jan 2011 16:38:15 +0530
Message-ID: <AANLkTincQgyEgYp-hejE9HWxUs_1bxshHMNqsrDx0sGo@mail.gmail.com>
From: Arun Khan <knura9@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Packet "leakage" between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linux Bridge <bridge@lists.linux-foundation.org>

On Fri, Jan 28, 2011 at 10:39 AM, Arun Khan <knura9@gmail.com> wrote:
> Ben and Jarrod thanks very much for sharing your thoughts. =A0 I will
> try Jarrod's suggestion first.
>
> On Fri, Jan 28, 2011 at 2:02 AM, J L <lists@rrod.net> wrote:
>
> Although the usage of VLAN is documented in the kvm man page, this did
> not strike me because my mind was set with the above assumption :)
> I will give it a shot and post my results here.
>

Success!

Here is part of the KVM script that does the trick (replace
nic_mac_addr?  with your own):

-net nic,vlan=3D1,model=3Drtl8139,macaddr=3D${nic_mac_addr0} \
-net tap,vlan=3D1,ifname=3Dtap0,script=3Dno,downscript=3Dno \
-net nic,vlan=3D2,model=3De1000,macaddr=3D${nic_mac_addr1} \
-net tap,vlan=3D2,ifname=3Dtap1,script=3Dno,downscript=3Dno \

I removed eth0 from br0 and no DHCP IP on eth0 of the Guest OS.
I added eth0 back to br0: Guest OS got IP address only on eth0, eth1
was unassigned; manually assigned 172.16.0.1 to eth1

Started another KVM Guest OS with one NIC on br1 (tap2).  I assigned
172.16.0.2 to the NIC with 172.16.0.1 as the gw.  I was able to ping
172.16.0.1 but nothing on the 192.168.1.0 network.  Then I enabled NAT
on the GW and I was able to ping any host beyond the GW.

From the "WAN" side I was able to ping only the IP on the WAN port.
Without any DNAT  rules, I could not ssh to the 172.16.0.2 box.  After
adding the relevant DNAT rule, I was able to ssh into the 172.16.0.2
Guest from my desktop (192.168.1.69).   So it turned out to be a KVM
config. issue; not with the bridge.

Jarrod thanks for pointing me in the right direction.  Your analogy
about the Linux KVM treating all the bridge and associated interfaces
as one big "switch" is excellent.  In other words the KVM becomes a
super bridge for all the net interfaces that are given to it's purview
through the various instances of VMs.

-- Arun Khan
