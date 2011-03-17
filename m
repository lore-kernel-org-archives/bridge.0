From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <4D81CDF6020000780003700B@vpn.id2.novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<20110316082441.45db3018@nehalam>
	<4D81CDF6020000780003700B@vpn.id2.novell.com>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 17 Mar 2011 09:23:02 +0100
Message-ID: <1300350182.10164.678.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing
 ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Beulich <JBeulich@novell.com>
Cc: linus.luessing@web.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

Le jeudi 17 mars 2011 à 08:01 +0000, Jan Beulich a écrit :
> >>> On 16.03.11 at 16:24, Stephen Hemminger <shemminger@linux-foundation.org>
> wrote:
> > On Wed, 16 Mar 2011 12:34:19 +0000
> > "Jan Beulich" <JBeulich@novell.com> wrote:
> > 
> >> With BRIDGE=y and IPV6=m commit
> >> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
> >> link-local address for multicast listener queries") causes the build to
> >> break.
> > 
> > Rather than continue with the config games, lets just make the necessary
> > ipv6 pieces accessible.
> 
> The below (however ugly it may look) seems to do the trick for me,
> for this particular symbol. Possibly other symbols need doing the
> same (didn't check which ones e.g. infiniband depends on), so
> some sort of abstraction might be desirable to make the whole
> thing look less ugly.

You should check how things are properly done with RCU, because you must
make sure the module unload wont delete text another cpu is using.

net code usually use synchronize_{rcu|net}() calls.


example :

net/ipv4/netfilter/nf_nat_sip.c

static void __exit nf_nat_sip_fini(void)
{
        rcu_assign_pointer(nf_nat_sip_hook, NULL);
        rcu_assign_pointer(nf_nat_sip_seq_adjust_hook, NULL);
        rcu_assign_pointer(nf_nat_sip_expect_hook, NULL);
        rcu_assign_pointer(nf_nat_sdp_addr_hook, NULL);
        rcu_assign_pointer(nf_nat_sdp_port_hook, NULL);
        rcu_assign_pointer(nf_nat_sdp_session_hook, NULL);
        rcu_assign_pointer(nf_nat_sdp_media_hook, NULL);
        synchronize_rcu();
}



