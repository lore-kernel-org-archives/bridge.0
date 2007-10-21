Date: Sun, 21 Oct 2007 00:21:57 -0400
From: s24067@rmc.ca
Message-id: <f64cba9929b9.471a9ba5@rmc.ca>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_gGZLmaJeGlz2zd5O0Kvs5Q)"
Content-language: en
Subject: [Bridge] Bridging firewall issue - which interface are packets
	coming from?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format.

--Boundary_(ID_gGZLmaJeGlz2zd5O0Kvs5Q)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hello folks, I'm hoping someone can help me here. I'll try to describe the problem in detail.

I'm attempting to set up a bridging firewall using libipq. I'm running on Ubuntu Server 7.04, out of the box kernel (2.6.20)
My bridge is set up with the following commands:
--
brctl addbr br0 
brctl stp br0 off
brctl addif br0 eth1
brctl addif br0 eth2
ifconfig eth1 down
ifconfig eth2 down
ifconfig eth1 0.0.0.0 up
ifconfig eth2 0.0.0.0 up
ifconfig br0 0.0.0.0 up
--

IP queue is set up with the following:
--
iptables -A FORWARD -j QUEUE
modprobe ip_queue
--


The bridge works fine. Traffic is sent back and forth. My libipq app can see traffic and stop it. However, one thing I would like to be able to find out in user space is which interface a packet arrived on (ie/ which direction it's going). As far as IPQ is concerned, all packets are arriving and leaving on br0.
After reading a bit more about netfilter, iptables and the FIREWALL document distributed with brctl, I figured my best bet would be do something like this:
iptables -A INPUT -i eth1 -j MARK --set-mark 1
iptables -A INPUT -i eth2 -j MARK --set-mark 2

This way I could just check the mark value when the packet got sent to QUEUE (and up to user space) from the FORWARD chain. However, this doesn't work. From everything I can tell, packets traversing the bridge do not even go through the INPUT chain, as I can put in this rule:
iptables -A INPUT -j DROP

yet traffic still flows through fine (as long as my libipq app is running).


Does anyone here have any ideas? I would really appreciate any suggestions.

Cheers,
David Vessey



--Boundary_(ID_gGZLmaJeGlz2zd5O0Kvs5Q)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: quoted-printable
Content-disposition: inline

Hello folks=2C I=27m hoping someone can help me here=2E I=27ll try to de=
scribe the problem in detail=2E=3Cbr=3E=3Cbr=3EI=27m attempting to set u=
p a bridging firewall using libipq=2E I=27m running on Ubuntu Server 7=2E=
04=2C out of the box kernel (2=2E6=2E20)=3Cbr=3EMy bridge is set up with=
 the following commands=3A=3Cbr=3E--=3Cbr=3Ebrctl addbr br0 =3Cbr=3Ebrct=
l stp br0 off=3Cbr=3Ebrctl addif br0 eth1=3Cbr=3Ebrctl addif br0 eth2=3C=
br=3Eifconfig eth1 down=3Cbr=3Eifconfig eth2 down=3Cbr=3Eifconfig eth1 0=
=2E0=2E0=2E0 up=3Cbr=3Eifconfig eth2 0=2E0=2E0=2E0 up=3Cbr=3Eifconfig br=
0 0=2E0=2E0=2E0 up=3Cbr=3E--=3Cbr=3E=3Cbr=3EIP queue is set up with the =
following=3A=3Cbr=3E--=3Cbr=3Eiptables -A FORWARD -j QUEUE=3Cbr=3Emodpro=
be ip=5Fqueue=3Cbr=3E--=3Cbr=3E=3Cbr=3E=3Cbr=3EThe bridge works fine=2E =
Traffic is sent back and forth=2E My libipq app can see traffic and stop=
 it=2E However=2C one thing I would like to be able to find out in user =
space is which interface a packet arrived on (ie/ which direction it=27s=
 going)=2E As far as IPQ is concerned=2C all packets are arriving and le=
aving on br0=2E=3Cbr=3EAfter reading a bit more about netfilter=2C iptab=
les and the FIREWALL document distributed with brctl=2C I figured my bes=
t bet would be do something like this=3A=3Cbr=3Eiptables -A INPUT -i eth=
1 -j MARK --set-mark 1=3Cbr=3Eiptables -A INPUT -i eth2 -j MARK --set-ma=
rk 2=3Cbr=3E=3Cbr=3EThis way I could just check the mark value when the =
packet got sent to QUEUE (and up to user space) from the FORWARD chain=2E=
 However=2C this doesn=27t work=2E From everything I can tell=2C packets=
 traversing the bridge do not even go through the INPUT chain=2C as I ca=
n put in this rule=3A=3Cbr=3Eiptables -A INPUT -j DROP=3Cbr=3E=3Cbr=3Eye=
t traffic still flows through fine (as long as my libipq app is running)=
=2E=3Cbr=3E=3Cbr=3E=3Cbr=3EDoes anyone here have any ideas=3F I would re=
ally appreciate any suggestions=2E=3Cbr=3E=3Cbr=3ECheers=2C=3Cbr=3EDavid=
 Vessey=3Cbr=3E=3Cbr=3E

--Boundary_(ID_gGZLmaJeGlz2zd5O0Kvs5Q)--
