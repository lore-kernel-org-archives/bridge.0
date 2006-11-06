Message-ID: <454F65AA.4040608@osdl.org>
Date: Mon, 06 Nov 2006 08:41:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
References: <20061106152538.20092.qmail@web27903.mail.ukl.yahoo.com>
In-Reply-To: <20061106152538.20092.qmail@web27903.mail.ukl.yahoo.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problems with Bridging 3 pc's network
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Filippo Graziola <graziolafilippo@yahoo.it>
Cc: bridge@osdl.org

Filippo Graziola wrote:
> Hi sir,
> I'm a student of Trento University and I'm working on
> a network
> project. I need to create a network like this:
>
> PC.1>--ethernet cable-->MAIN_PC(ubuntu
> linux)>------wireless----->PC.2
>
> PC.1 ip: 192.168.0.1
> MAIN_PC ip: 192.168.0.2
> PC.2 ip: 192.168.0.3
> netmask 255.255.255.0
>
> I followed the instruction of the HOWTO and I made a
> bridge on MAIN_PC.
> Previously I set the wireless interface (eth0 - intel
> 2200B/G) with
> ad-hoc mode and I gave it a essid and a channel.
> Without the bridge I can
> ping from MAIN_PC all the others but I noticed that
> when the bridge is
> up I can't ping from the PC.2 the PC.1 (problem nr=B01)
> and I can ping
> from PC.2 the MAIN_PC only for a short start time
> (problem nr=B02).
>
> When I give this command as root:
>
> echo "1" > /proc/sys/net/ipv4/ip_forward
>  =20
1. You are Bridging (layer 2) not Routing (layer 3).=20

2. Bridging ethernet to wireless doesn't work in most cases because wireless
    bridging requires NDS support which is not in the bridge code, and=20
would also
    require different wireless device drivers (using softmac).

See the FAQ on http://linux-net.osdl.org/index.php/Bridge

