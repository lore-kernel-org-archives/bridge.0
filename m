Date: Tue, 18 Jan 2005 13:57:35 -0800
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20050118135735.4b77d38d.davem@davemloft.net>
In-Reply-To: <1105133241.3375.16.camel@localhost.localdomain>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	<p73zn0ccaee.fsf@verdi.suse.de>
	<1105117559.11753.34.camel@baythorne.infradead.org>
	<20050107100017.454ddadc@dxpl.pdx.osdl.net>
	<1105133241.3375.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: do_IRQ: stack overflow: 872..
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netdev@oss.sgi.com, bridge@osdl.org, snort2004@mail.ru, rusty@rustcorp.com.au, dwmw2@infradead.org, ak@suse.de, shemminger@osdl.org

On Fri, 07 Jan 2005 22:27:21 +0100
Bart De Schuymer <bdschuym@pandora.be> wrote:

> How about something like the patch below (untested but compiles)?
> The current netfilter scheme adds one function call to the call chain
> for each NF_HOOK and NF_HOOK_THRESH. This can be prevented by executing
> the okfn in the calling function instead of in nf_hook_slow().
> I didn't check if there's any code that actually uses the return value
> from NF_HOOK. If so, this patch won't work well in its current form as -
> EPERM is now also returned for NF_QUEUE and NF_STOLEN.
> 
> Another 2 calls of okfn can be postponed in br_netfilter.c by adding
> NF_STOP, which would work like NF_STOLEN except that okfn is still
> called. But I'd first like to get the IPv4/IPv6 fix for br_netfilter.c
> accepted (see another thread on netdev).

I believe I put in your ipv4/ipv6 br_netfilter fix already.

This NF_HOOK() change looks interesting.  Could we also do something like
running the deeper ->hard_start_xmit() via a triggered tasklet or something
similar?
