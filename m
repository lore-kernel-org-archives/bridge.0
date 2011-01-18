Message-ID: <4D357962.5070008@free.fr>
Date: Tue, 18 Jan 2011 12:28:34 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4D356B14.6050501@atpss.net>
In-Reply-To: <4D356B14.6050501@atpss.net>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Linux Firewall with STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: claudio.prono@atpss.net
Cc: bridge@lists.linux-foundation.org

Le 18/01/2011 11:27, Claudio Prono a =E9crit :
> Hello all,
>
> I don't have a big experience with stp protocol, so i need some help on
> configuration.
>
> My scenario is the following:
>
> I have one (ore more) system behind two redundat switches. The system
> have 2 ethernet cards, so it is connected with the two switches, and the
> switches are connected each other. connected to the two switches there
> is a linux firewall, with 3 ethernet cards. Two are connected to the
> switches, the last one is connected to the internet router.
>
> There is my questions:
>
> - The system behind the two redundant switches must have 2 IP Address?
> One for each card?
> - The Firewall must have 2 "Internal" IP addresses? And if yes, how i
> can NAT this to an external address?
>
> Anyone have experence in scenarios like this and can help me for a
> correct configuration?
>
> Any type of help is well accepted.

Hi,

You should try to use the bonding module on the system behind the two redun=
dant switches and on the=20
firewall.

Bonding will aggregate two NIC into a single (virtual) one. This virtual NI=
C will hold the IP=20
address. In case of a failure, bonding will automatically use the other pat=
h.

HTH

	Nicolas.
