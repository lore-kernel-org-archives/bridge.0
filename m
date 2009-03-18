Message-ID: <2831.119.40.3.91.1237373805.squirrel@norman.zultron.com>
In-Reply-To: <1349.119.40.3.91.1236078245.squirrel@norman.zultron.com>
References: <1349.119.40.3.91.1236078245.squirrel@norman.zultron.com>
Date: Wed, 18 Mar 2009 18:56:45 +0800 (CST)
From: "John Morris" <jman@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bridge dropping packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Same problem again here, this time with phone from a different vendor. 
The dom0 had been running VLANs, but these are removed and the eth0 device
directly connected to the bridge for testing.

Here are some tcpdumps that help illustrate the problem.  In this output,
sipura1 is the phone, and pbx0 is the domU.  Pbx0 is connected through the
interface vif8.0.  Sergey is the dom0, with a bridge 'bo1br'.

[root@sergey ~]# jobs
[7]-  Running    tcpdump -i vif8.0 -l -A host sipura1 and not port 5061 \
    | sed 's/^/vif8.0-s:       /' &
[8]+  Running    tcpdump -i bo1br -l -e -A host sipura1 and not port 5061 \
    | sed 's/^/bo1br-s:      /' &

Here are some sample packets that are never forwarded from the bridge to
vif8.0:
[...]
bo1br-s:        18:30:37.948378 00:0e:08:ab:6a:78 (oui Unknown) \
    > 00:16:ee:68:03:13 (oui Unknown), ethertype IPv4 (0x0800), \
    length 543: sipura1.zultron.com.sip > pbx0.zultron.com.sip: \
    SIP, length: 501
bo1br-s:        [...]REGISTER sip:pbx0.zultron.com SIP/2.0
bo1br-s:        Via: SIP/2.0/UD
bo1br-s:        18:30:39.948675 00:0e:08:ab:6a:78 (oui Unknown) \
    > 00:16:ee:68:03:13 (oui Unknown), ethertype IPv4 (0x0800), \
    length 543: sipura1.zultron.com.sip > pbx0.zultron.com.sip: \
    SIP, length: 501
bo1br-s:        [...]REGISTER sip:pbx0.zultron.com SIP/2.0
bo1br-s:        Via: SIP/2.0/UD
[...]

A ping from pbx0 to sipura1 makes it through just fine, however:
[...]
vif8.0-s:       18:39:40.986555 IP pbx0.zultron.com > \
    sipura1.zultron.com: ICMP echo request, id 2318, seq 5, length 64
bo1br-s:        18:39:40.986555 00:16:ee:68:03:13 (oui Unknown) \
    > 00:0e:08:ab:6a:78 (oui Unknown), ethertype IPv4 (0x0800), \
    length 98: pbx0.ablesky.com > sipura1.ablesky.com: ICMP echo \
    request, id 2318, seq 5, length 64
bo1br-s:        18:39:40.987507 00:0e:08:ab:6a:78 (oui Unknown) \
    > 00:16:ee:68:03:13 (oui Unknown), ethertype IPv4 (0x0800), \
    length 98: sipura1.ablesky.com > pbx0.ablesky.com: ICMP echo \
    reply, id 2318, seq 5, length 64
vif8.0-s:       18:39:40.987516 IP sipura1.ablesky.com > \
    pbx0.ablesky.com: ICMP echo reply, id 2318, seq 5, length 64

The relevant entries in the MAC table:
[root@sergey ~]# brctl showmacs bo1br | grep -e 6a:78 -e 03:13
  1     00:0e:08:ab:6a:78       no                26.80
  9     00:16:ee:68:03:13       no                 3.38

Strangest of all, sipura1, an ATA, has two phone ports, and the software
registers them separately, one from port 5060, the other from port 5061. 
The registration from port 5061 works just fine.  What's more, immediately
after a reboot of sergey, the dom0, the phones register fine; it is after
some time that the traffic suddenly begins being dropped.

Should I be suspecting packet corruption?  Tcpdump seems to be able to
recognize the packets just fine.  Are the packets being forwarded out
another port?  The dest MACs aren't duplicated on the network, and I've
put a tcpdump on each switch port interface just to be sure.  Is it the
physical switch that sergey is connected to?  I've moved sergey to another
switch to test.  Is it the phone itself?  But different phones from
different vendors exhibit the same problem, and sipura1 has the problem on
one line, but not the other.  Obviously, I'm missing something here. 
Thanks for any and all wild suggestions.

    John


On Tue, March 3, 2009 7:04 pm, John Morris wrote:
> We have about 20 IP phones connecting to a Xen-based PBX, and in the past
> month or two, a problem has been popping up.
>
> About once a week, some, but not all, of the phones lose their
> registration with the PBX.  The PBX can ping the unregistered phones, and
> the phone ARP requests for the PBX IP are answered.  However, the UDP 5060
> registration traffic originating from those phones enters the dom0's
> bridge and is then dropped; it is never forwarded onto the vif associated
> with the pbx.
>
> Rebooting the dom0 is the only way I've found to fix it so far.  Reloading
> the bridge kernel module doesn't seem to solve the problem, though the set
> of phones that are unable to register changes (I haven't looked closely to
> see if there's a pattern to it).
>
> There's no packet filtering going on here, and this problem seems to pop
> up after random, infrequent intervals.  I've verified that there are no
> hosts with duplicate MAC addresses.  I can't for the life of me think of
> why some packets from some IPs would be forwarded correctly and others
> would not.  Another post in the archives described some similar-sounding
> symptoms, but the OP found it to be an MTU-related problem; these packets
> are all 356 bytes long, too short to be the problem.
>
> Thanks-
>
>         John
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

