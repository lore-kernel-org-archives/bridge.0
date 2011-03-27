Message-ID: <4D8F5393.8080709@free.fr>
Date: Sun, 27 Mar 2011 17:11:15 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4D8F3A6A.2080103@mclink.it>
In-Reply-To: <4D8F3A6A.2080103@mclink.it>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridging problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Mauro Condarelli <mc5686@mclink.it>
Cc: bridge@lists.linux-foundation.org

Le 27/03/2011 15:23, Mauro Condarelli a =E9crit :
> Hi,
> I have a small home-office network built like this:
>
>
> Internet
>   |
> Firewall(192.169.1.254) GREEN ---+-----------+----------+-----
> (192.168.56.254)                 |           |          |
> DMZ                        (192.168.1.5)    PC1        PC2
>   |                            Server
> WebServer                  (192.168.2.254)
>                                 WLAN
>                                   |
>                                   +-----------+----------+-----
>                                   |           |          |
>                                  PCa         PCb        PCc
>
> Firewall is DHCP and DNS server for everyone else.
> Firewall is default gateway for everybody.
> This arrangement works but requires a static route on firewall and, for
> machines on WLAN to talk with wired ones (and vice versa) requires going
> to firewall and back.
>
> Is there some way to bridge together the two LANs (GREEN and WLAN) so
> they can act as a single subnet (192.168.1.0/24)?
>
> I tried some configurations, but they simply didn't work and I know too
> little about bridging to troubleshot them.

Hi Mauro,

The ability to bridge between LAN and WLAN depends on the particular WLAN N=
IC you use.

See=20
http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#It_=
doesn.27t_work_with_my_Wireless_card.21=20
for the details.

I suggest you first build a working bridge configuration with normal (wired=
) NICs. Then, add a WLAN=20
interface to the bridge and see what happens.

Also, if you want us to help, consider adding your bridge configuration and=
 wifi configuration to=20
your message, after removing any "secrets" from the wifi configuration, if =
appropriate.

	Nicolas.





