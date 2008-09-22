Date: Mon, 22 Sep 2008 08:33:22 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080922083322.22fcc415@extreme>
In-Reply-To: <205854.34099.qm@web8807.mail.in.yahoo.com>
References: <205854.34099.qm@web8807.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridge is not forwarding the packet <Urgent,
 Please reply ASAP>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
Cc: bridge@lists.linux-foundation.org

On Mon, 22 Sep 2008 16:24:00 +0530 (IST)
rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in> wrote:

> Hello to all,
>=20
> I am stating my problem below in detail so that you all can understand it=
 properly.
>=20
> I am having setup of Linux box. In that box I am having one Ethernet inte=
rface eth0 and one wireless interface ath0. I have also configured one vlan=
 port as eth0.100 with the help of vconfig (vconfig add eth 100).=C2=A0 Now=
 I have created two bridges br1 and br100. I have added eth0 into br1 so br=
1 is having only one interface. I have added ath0 and eth0.100 into br100. =
Physically eth0 is connected to a switch which is configured to handle vlan=
 100. DHCP server is also running into that switch to provide IP address to=
 wireless stations. This is all about my setup.
>=20
> After this I am associating one wireless station with the ath0. After suc=
cessful association station issues a dhclient to get ip address, which reac=
hes to ath0 interface of my Linux box. ath0 bridges that request to eth0.10=
0. Now eth0.100 adds it's vlan tags and forward that request to the switch.=
 Because switch is configured to support vlan 100, so it process the dhcp r=
equest and send back the dhcp response with vlan tag 100.=20
>=20
> Now I don't know but this response is not reaching to ath0. I have putted=
 wireshark and figured out that those dhcp responses are reaching on eth0 a=
nd as eth0 is part of br1 so this packet is reaching to br1 which is just d=
iscarding them all. So the wireless station is not getting the ip address. =
According to me eth0 should give these packets to eth0.100 port instead of =
br1. Or what I mean to say first vlan handling should be done priror then=
=C2=A0 bridge handling. Do I need to change something into Linux kernel for=
 that or there is some other problem with my setup?
>=20
> Can anybody help me in this? If anybody want more detail I will provide. =
I am using Linux 2.6.15 kernel. Any kind of help will be much appreciated.=
=20
>=20
>=20
> With Regards=20
>=20
> Rahul Bhardwaj=20

Full bridging to wireless requires WDS which Linux wireless does not suppor=
t (yet).

http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wire=
less_card.21
