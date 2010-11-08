Date: Mon, 08 Nov 2010 09:33:12 +0800
From: Liew Kian Yang <kianyang@agroup.com.my>
In-reply-to: <20101106212640.6d88c5d3@nehalam>
Message-id: <035c01cb7ee4$e8b54c30$ba1fe490$@com.my>
MIME-version: 1.0
Content-type: text/plain; charset=gb2312
Content-language: zh-cn
Content-transfer-encoding: quoted-printable
References: <AANLkTinqo2AXeHMv-p261BJoTGT2Df=zm6uEu+7QYmaH@mail.gmail.com>
	<20101106212640.6d88c5d3@nehalam>
Subject: Re: [Bridge] DHCP problem on bridge
Reply-To: kianyang@agroup.com.my
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@linux-foundation.org>, 'Kian Yang Liew' <liewkianyang@gmail.com>
Cc: bridge@linux-foundation.org

Dear Stephen,=20


Thank you for your information. I will try and let you know the result =
:)


Regards,
Kian Yang, Liew

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org]=20
Sent: 2010=C4=EA11=D4=C27=C8=D5 12:27
To: Kian Yang Liew
Cc: bridge@linux-foundation.org; Liew Kian Yang
Subject: Re: [Bridge] DHCP problem on bridge

On Sun, 31 Oct 2010 00:31:11 +0800
Kian Yang Liew <liewkianyang@gmail.com> wrote:

> Dear All,
>=20
>=20
>=20
> I have a network with 500 vlan and I bind all these 500 vlan into 1 =
bridge
> interface. Then I have run a dhcp server on this bridge interface to
provide
> dhcp to all the computer in the vlan. It look find all the time, but
> sometime, some of the computer on vlan will not able to get the ip =
from
dhcp
> server but after I remove the vlan and add back to the bridge it will =
work
> again. The most serious case is sometime there will be a dhcp problem =
on
> vlan 1 as well, and I need to reboot the server only can make the =
service
> back to normal.
>=20
>=20
>=20
> The setting is as below
>=20
>=20
>=20
>=20
>=20
> Vconfig add eth1 2
>=20
> Vconfig add eth1 3
>=20
> .
>=20
> .
>=20
> .
>=20
> .
>=20
> .
>=20
> .vconfig add eth1 500
>=20
>=20
>=20
> Then ifconfig eth1.2 up =A1=AD. Ifconfig eth1.500 up
>=20
> Then brctl addbr br1, brctl addif br1 eth1.2 =A1=AD=A1=AD. Brctl addif =
br1
eth1.500
>=20
>=20
>=20
> Does anyone have face this problem before? Your reply is highly
appreciate.
>=20

brctl stp br0 off
brctl setfd br0 0

