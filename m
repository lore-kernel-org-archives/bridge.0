MIME-Version: 1.0
In-Reply-To: <4A00B327.6080705@free.fr>
References: <20090428124009.GA26387@kallisti.us> <49FA1E28.5020604@free.fr>
	<49FC4764.3030707@gmail.com> <49FDD890.1090302@free.fr>
	<49FF41C4.4090404@gmail.com> <49FF4AF8.1050801@free.fr>
	<49FF58EC.2090902@gmail.com> <49FFDABF.4030500@free.fr>
	<4A007103.4010501@gmail.com> <4A00B327.6080705@free.fr>
Date: Wed, 6 May 2009 08:57:26 +0200
Message-ID: <db99f77d0905052357s6b35a626x9f93b07c374f35ee@mail.gmail.com>
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

2009/5/5 Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr>:
> When you setup the bridge at the beginning, the br0 interface takes the M=
AC
> address of eth1. Then you add eth0 and the bridge takes the MAC address o=
f
> eth0, because it is lower.
>
> Can you try to use the bridge-hw option of /etc/network/interfaces, to fo=
rce
> the bridge MAC address to the MAC address of the wireless interface ? Thi=
s
> might solve the communication problem for UBUNTU SERVER... but unfortunat=
ely
> probably not for the bridging function.

I think you mean bridge_hw (with an underscore instead of a dash?). I
can't find any information about bridge-hw in the man pages.

So, I need to specify it in the bridge stanza like this:
bridge_hw ##HERE_COMES_THE_MAC_ADDRESS_OF_THE_EHT1_INTERFACE##

Right?

>
> That beeing said, Jonathan might be right about the need for WDS... Can y=
ou
> have a look at the AP configuration, searching for a WDS setup ? Because =
if
> it works on Windows, without WDS (if disabled or unavailable on the AP),
> then we can assume that WDS is not required, even on Linux (the wifi
> interface is able to receive traffic for another MAC).
>
> If the AP is WDS enabled, then... WDS might be necessary... and nothing c=
an
> be done if the driver for you wifi interface does not support it...

Just to be sure: with AP you mean: Access Point? So in my case, the router?
I will check it tonight (I'm not at home right now!)

Thanks for your tips, I'll keep you updated!
