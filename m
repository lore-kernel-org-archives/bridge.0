Date: Thu, 17 Jun 2004 10:53:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge only works from certain ip addresses
Message-Id: <20040617105333.1d016ade@dell_ss3.pdx.osdl.net>
In-Reply-To: <40D193A7.2020805@phys.rug.nl>
References: <40D193A7.2020805@phys.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Maarten Hilgenga <M.L.Hilgenga@phys.rug.nl>
Cc: bridge@lists.osdl.org

On Thu, 17 Jun 2004 14:50:47 +0200
Maarten Hilgenga <M.L.Hilgenga@phys.rug.nl> wrote:

> Dear all,
> 
> after putting up a bridge to be used as a firewall with the following 
> configuration:
> 
> linux 2.6.4-52-smp kernel
> bridge-utils 0.9.6-121
> Bridge is setup standard with 2 NIC's and STP off.
> 
> I noticed  a strange behaviour; when connecting from an outside machine 
> with the same iprange as the inside machines (a.b.xxx.xxx) I could 
> connect. When trying the same from a non-local machine(c.d.xxx.xxx), 
> this didn't work. In both cases the first package arrives at the 
> firewallmachine at the INPUT chain, and the destination MAC-address is 
> correct in both cases. The package from a.b.xxx.xxx also enters the 
> FORWARD chain, but this doesn't work for c.d.xxx.xxx. I'd really 
> appreciate any help, if you need more info please tell me

What is the IP route table, perhaps you don't have routes that know
how to get outside your local lan.

The ebtables list you want is probably, ebtables-users@lists.sourceforge.net
