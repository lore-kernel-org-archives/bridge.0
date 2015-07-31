Return-Path: <saurav.barik@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=bODVfkBB2jd3hq1XDVoBhgentuj1mBGTLih3sCBZ4Cs=;
	b=WsMBE0bUt/Tc1E03W255G3+uf8PP3ndWNVl20ZstOAT6HQ8EK97/v85H1RSnU5hqwk
	+7QWRG4kPNMQFNi+GFAnd3rDxFu5wYvc9b3e7ucLFl7mUdGG4VUSCtutRSvpeIFzAK4k
	KnKAtPpLEhdBIQZHCIFI3sU8Dd9YABVv+7f7o67+IhI3cJzhogm1ngoeZsLZkRkQRJXS
	t+yOWe0qHfQuxTsy13pu0udnFFx6Qv+G5NtN6BoQ4t4Gjb/Xy+OtSiabAziLIHJ9Dya8
	he70mLH79i1GjUfB6Cugm0DbGS8faKtG1Fi5pq8Ku7WUNwWdOd0qLeM/yKmo+lz+NyFm
	e6Wg==
MIME-Version: 1.0
Date: Fri, 31 Jul 2015 15:50:35 +0530
Message-ID: <CAJkjprMLMZXqPuAEX3Hi46Wsu1QxUuPjK-mK_M9CHPsUFvv3nA@mail.gmail.com>
From: saurav barik <saurav.barik@gmail.com>
Content-Type: multipart/alternative; boundary=bcaec53f3985a799d3051c292b4f
Subject: [Bridge] Multicast packets are not bridged from ethernet to
	wireless interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--bcaec53f3985a799d3051c292b4f
Content-Type: text/plain; charset=UTF-8

Hello,

I am working on an Access Point device (AP1) running linux kernel 3.0.34 on
which my bridge configuration is as follows.

~ # brctl show
bridge name     bridge id               STP enabled     interfaces
mbr             8000.xxxxxxxx0271       no                eth1

wlan0

wlan0 is connected by a wlan link to another access point AP2. This mbr on
AP1 gets IP address via wlan0. I have a laptop connected to eth1 interface
and it too gets IP address via eth1-bridged-wlan0 (wlan0 is the only uplink
port). All the unicast packets (ping traffic) from the laptop via
eth1-bridged-wlan0 works fine. However when I start a multicast tx (iperf
multicast) from the laptop, the multicast packet reaches eth1 and then gets
dropped in the bridge module. I debugged and found the packets are dropped
at -

br_multicast_flood(struct net_bridge_mdb_entry *mdst, ....)
.... <code snippet>
        while (p || rp) {
....
        rp = rcu_dereference(hlist_first_rcu(&br->router_list));
        p = mdst ? rcu_dereference(mdst->ports) : NULL;
        }

        if (!prev)
        {
 /******* packets getting dropped here.  *********/
                goto out;
        }
........

The three pointers mdst, p and rp  are NULL. Prior to reaching here, the
packet traversed successfully via
br_handle_frame()->br_handle_frame_finish()->br_multicast_forward()->br_multicast_flood().
The source and multicast destination address in the skb look alright.

Additional Note: I have another ethernet interface on AP1 which is eth0. If
I remove wlan0 and add eth0, then multicast packets successfully pass from
eth1 to eth0 in the bridge module.

Could anybody share some pointer on this? Thank you.

With Regards,
Saurav

--bcaec53f3985a799d3051c292b4f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br><br></div>I am working on an Acce=
ss Point device (AP1) running linux kernel 3.0.34 on which my bridge config=
uration is as follows.<br><br>~ # brctl show<br>bridge name=C2=A0=C2=A0=C2=
=A0=C2=A0 bridge id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STP enabled=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
es<br>mbr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8000.xxxxxxxx0271=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 eth1<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 wlan0<br><br></div>wlan0 is connected by a wlan link to another access poi=
nt AP2. This mbr on AP1 gets IP address via wlan0. I have a laptop connecte=
d to eth1 interface and it too gets IP address via eth1-bridged-wlan0 (wlan=
0 is the only uplink port). All the unicast packets (ping traffic) from the=
 laptop via eth1-bridged-wlan0 works fine. However when I start a multicast=
 tx (iperf multicast) from the laptop, the multicast packet reaches eth1 an=
d then gets dropped in the bridge module. I debugged and found the packets =
are dropped at -<br><br>br_multicast_flood(struct net_bridge_mdb_entry *mds=
t, ....)<br></div><div>.... &lt;code snippet&gt;<br></div><div>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (p || rp) {<br>.... =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rp =3D rc=
u_dereference(hlist_first_rcu(&amp;br-&gt;router_list));<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D mdst ? rcu_dereference(mdst-&gt;ports) : =
NULL;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br><br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!prev)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 {<br></div>=C2=A0/******* packets getting dropped here.=C2=A0 =
*********/<br><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }<br>........<br><br></div><div>The three pointers mdst,=
 p and rp=C2=A0 are NULL. Prior to reaching here, the packet traversed succ=
essfully via br_handle_frame()-&gt;br_handle_frame_finish()-&gt;br_multicas=
t_forward()-&gt;br_multicast_flood(). The source and multicast destination =
address in the skb look alright. <br><br></div><div>Additional Note: I have=
 another ethernet interface on AP1 which is eth0. If I remove wlan0 and add=
 eth0, then multicast packets successfully pass from eth1 to eth0 in the br=
idge module.<br><br></div><div>Could anybody share some pointer on this? Th=
ank you.<br><br></div><div>With Regards,<br></div><div>Saurav<br></div></di=
v>

--bcaec53f3985a799d3051c292b4f--
