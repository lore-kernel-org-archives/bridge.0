Message-ID: <915136920701221056o2d38f7eew65b8027cb25b6b78@mail.gmail.com>
Date: Mon, 22 Jan 2007 19:56:46 +0100
From: "=?ISO-8859-1?Q?Abel_Mart=EDn?=" <abel.martin.ruiz@gmail.com>
In-Reply-To: <200701172009.22444.carla@bratgrrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701172009.22444.carla@bratgrrl.com>
Subject: Re: [Bridge] combination WAP/firewall/router - wired and wireless
	hosts do not connect
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On 1/18/07, Carla Schroder <carla@bratgrrl.com> wrote:
> hey all,
>
> I searched the archives and the site and didn't find an answer, so if I missed
> something I'll gladly take pointers to any good help pages.
>
> I want to build a combination wireless access point/iptables firewall/router
> for my home LAN, like this:
>
> dsl modem - router/WAP - switch - LAN
>
> I have Pyramid Linux on a PC Engines WRAP board. The board has an Atheros
> tri-mode wireless card, and two wired Ethernet ports in use. The configs are
> like this:
>
>  LAN IP = 192.168.1.25
>  br0 = ath0 bridged to eth0
>
>  WAN IP = 22.33.44.55
>  eth1
>
> When my iptables firewall is up, all hosts have Internet and can ping the
> router. But wired hosts cannot ping wireless hosts, or the reverse. With the
> firewall turned off, the bridge works perfectly and all LAN hosts see each
> other.
>
> I've tried running my iptables rules one at a time, and the showstopper is the
> forwarding chain. I like to use a default policy of FORWARD DROP, then write
> accept rules as needed. But nothing I have tried works here, and it's not
> like my iptables-fu is all that mighty anyway.
>
> Should I be looking at ebtables, or can I do this in iptables? Or what?
>
Did do check physdev iptables module?

Regards,
Abel
