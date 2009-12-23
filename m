MIME-Version: 1.0
Date: Wed, 23 Dec 2009 09:29:23 -0700
Message-ID: <c5b98f840912230829y56df31f9i7f03a8f1274f144e@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016e648f0ae43d015047b67d31b
Subject: [Bridge] Mac Address bouncing between ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e648f0ae43d015047b67d31b
Content-Type: text/plain; charset=ISO-8859-1

I've been using Linux Bridge for years on physical hardware to create a
transparent firewall. We are moving this set-up to virtual machines. I'm
running into a problem with MAC addresses bouncing between switch ports and
need help  diagnosing the problem. I've looked online all day yesterday and
I can't find a similar symptom.

The set-up:
We have two networks that we want to firewall and a network that we want to
NAT. We are using VMware ESX 4.0 server to host the virtual machine which is
Debian Squeeze with Linux kernel 2.6.30 and brctl 1.2. I've created two
bridges (br0 and br1) and I assign an IP address to br0 and none to br1 so
that it is transparent. We are using VGT (Virtual Guest Tagging) for our
VLANs for eth0 and eth1 is using VST (Virtual Switch Tagging) for it's VLAN.
br0 holds eth0.1 and eth0.11 and br1 holds eth0.2 and eth0.12. eth1 has an
IP address of 192.168.1.1 and does NAT though iptables. I've set the virtual
portgroup in ESX that is connected to eth0 to accept promiscuous mode.

For the most part things work fine, however, every once and a while the Mac
address of a machine on the firewalled side of the switch will show up on
the non-firewalled side and for about 1 minute all traffic to/from the
machine ceases. This happend much more frequently when I was using purley
VST for the bridges. I also get the error "eth0.1: received packet with own
address as source" in the logs, again much less frequently with VGT than
with VST.

I would like help tracking down the cause of these two problems, but I don't
know where to go from here. I've sniffed the traffic on the interface listed
in the error message, but all I've seen is a broadcast packet that matches
the description of the error.

Thank you,

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University

--0016e648f0ae43d015047b67d31b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;ve been using Linux Bridge for years on physical hardware to create a=
 transparent firewall. We are moving this set-up to virtual machines. I&#39=
;m running into a problem with MAC addresses bouncing between switch ports =
and need help=A0 diagnosing the problem. I&#39;ve looked online all day yes=
terday and I can&#39;t find a similar symptom.<br>
<br>The set-up:<br>We have two networks that we want to firewall and a netw=
ork that we want to NAT. We are using VMware ESX 4.0 server to host the vir=
tual machine which is Debian Squeeze with Linux kernel 2.6.30 and brctl 1.2=
. I&#39;ve created two bridges (br0 and br1) and I assign an IP address to =
br0 and none to br1 so that it is transparent. We are using VGT (Virtual Gu=
est Tagging) for our VLANs for eth0 and eth1 is using VST (Virtual Switch T=
agging) for it&#39;s VLAN. br0 holds eth0.1 and eth0.11 and br1 holds eth0.=
2 and eth0.12. eth1 has an IP address of 192.168.1.1 and does NAT though ip=
tables. I&#39;ve set the virtual portgroup in ESX that is connected to eth0=
 to accept promiscuous mode.<br>
<br>For the most part things work fine, however, every once and a while the=
 Mac address of a machine on the firewalled side of the switch will show up=
 on the non-firewalled side and for about 1 minute all traffic to/from the =
machine ceases. This happend much more frequently when I was using purley V=
ST for the bridges. I also get the error &quot;eth0.1: received packet with=
 own address as source&quot; in the logs, again much less frequently with V=
GT than with VST.<br>
<br>I would like help tracking down the cause of these two problems, but I =
don&#39;t know where to go from here. I&#39;ve sniffed the traffic on the i=
nterface listed in the error message, but all I&#39;ve seen is a broadcast =
packet that matches the description of the error.<br>
<br>Thank you,<br clear=3D"all"><br>Robert LeBlanc<br>Life Sciences &amp; U=
ndergraduate Education Computer Support<br>Brigham Young University<br>

--0016e648f0ae43d015047b67d31b--
