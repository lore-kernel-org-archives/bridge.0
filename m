Message-ID: <4A056646.5050909@gmail.com>
Date: Sat, 09 May 2009 13:17:26 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
	<4A00B327.6080705@free.fr> <4A01BF38.4080704@gmail.com>
	<4A01EDEA.8040106@free.fr>
In-Reply-To: <4A01EDEA.8040106@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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

Nicolas de Peslo=FCan schreef:
> bridge-hw and bridge_hw is exactly the same. (No difference between=20
> underscore and dash). Both will set a variable $IF_BRIDGE_HW, to be=20
> used by the scripts in /etc/network/if-*.d/*.
>
> From interfaces(5) : "Additionally, all options given in an interface=20
> definition stanza are exported to the environment in upper case with=20
> "IF_" prepended and with hyphens converted to underscores and=20
> non-alphanumeric characters discarded."
Ah, ok, thnx!
>
> This is unfortunately what I expected.
>
> Now, you can have a last try with your current bridge configuration,=20
> by upgrading the firmware of your router, ensuring WDS is enabled in=20
> the router, and hope that the driver of your wifi adapter support=20
> WDS... By the way, what is the type of your wifi adapter ?
I had a "chat" with somebody of the support site of Linksys. The WRT54GS=20
enables WDS. So we can say this is my problem. My wifi adapter is a WMP54G
>
> If that fail, I think we have two options :
>
> - Try to setup a very special bridge configuration, with some sort of=20
> masquerading of the MAC address. This would require at least to use=20
> ebtables to replace the source MAC address in the header (and in the=20
> payload for ARP) of packets sent on the wifi interface, to route=20
> packets in the server, to stop the server from sending ICMP redirect=20
> in the wifi interface and to setup a proxy_dhcp on the server. It=20
> would be hard to setup, hard to debug and impossible to maintain...=20
> Probably not a good idea... Funny to try, but not a good target.
This really sounds like Chinese in my ears :-D
>
> - Setup a simple router configuration on the server, using another=20
> private subnet on location B. Using a simple NAT/Masquerading=20
> configuration (with iptables), it could be possible to hide the subnet=20
> of location B from location A, but still allow access to the printer=20
> of location B from location A and access to location A and to Internet=20
> from location B. If you don't have a really good reason to stick to=20
> bridge (like using a non-IP protocol), I suggest you try this.
I was thinking on this situation too. But how will be somebody in subnet=20
A able to reach someone of subnet B? We are gonna have to change the=20
routing tables on the client side too?

Jochen
