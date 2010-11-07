Date: Sat, 6 Nov 2010 21:26:40 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101106212640.6d88c5d3@nehalam>
In-Reply-To: <AANLkTinqo2AXeHMv-p261BJoTGT2Df=zm6uEu+7QYmaH@mail.gmail.com>
References: <AANLkTinqo2AXeHMv-p261BJoTGT2Df=zm6uEu+7QYmaH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] DHCP problem on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kian Yang Liew <liewkianyang@gmail.com>
Cc: Liew Kian Yang <kianyang@agroup.com.my>, bridge@linux-foundation.org

On Sun, 31 Oct 2010 00:31:11 +0800
Kian Yang Liew <liewkianyang@gmail.com> wrote:

> Dear All,
>=20
>=20
>=20
> I have a network with 500 vlan and I bind all these 500 vlan into 1 bridge
> interface. Then I have run a dhcp server on this bridge interface to prov=
ide
> dhcp to all the computer in the vlan. It look find all the time, but
> sometime, some of the computer on vlan will not able to get the ip from d=
hcp
> server but after I remove the vlan and add back to the bridge it will work
> again. The most serious case is sometime there will be a dhcp problem on
> vlan 1 as well, and I need to reboot the server only can make the service
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
> Then ifconfig eth1.2 up =85. Ifconfig eth1.500 up
>=20
> Then brctl addbr br1, brctl addif br1 eth1.2 =85=85. Brctl addif br1 eth1=
.500
>=20
>=20
>=20
> Does anyone have face this problem before? Your reply is highly appreciat=
e.
>=20

brctl stp br0 off
brctl setfd br0 0

