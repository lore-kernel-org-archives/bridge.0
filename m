Date: Tue, 2 Sep 2003 11:17:29 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Bridge] Re: [more info] Re: [2.4.22] bad interaction between
 e100 and bridge: BUG at dev.c:991!
Message-Id: <20030902111729.1791f2ad.davem@redhat.com>
In-Reply-To: <200309022023.16397.bdschuym@pandora.be>
References: <p05111b01bb728bc8972e@[10.96.96.13]>
	<20030830190100.4eac4504.davem@redhat.com>
	<20030902104545.3c321c24.shemminger@osdl.org>
	<200309022023.16397.bdschuym@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: shemminger@osdl.org, schulz@schwaar.com, scott.feldman@intel.com, jgarzik@pobox.com, bridge@osdl.org

On Tue, 2 Sep 2003 20:23:16 +0200
Bart De Schuymer <bdschuym@pandora.be> wrote:

> A pristine 2.4.22 doesn't have bridge-netfilter.

This is true.

> I don't see how bridge-netfilter would be involved anyway, altering
> a packet doesn't automagically trigger checksum recalculation.

You don't understand the problem.

When a packet gets received, if the hardware checksums the packet
it sets skb->ip_summed.  If you take that SKB and want to transmit
it you have to reinitialize the skb->ip_summed field or else things
explode.
