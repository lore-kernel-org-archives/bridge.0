References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200911181047.07974.arnd@arndb.de> <m1pr7fdhkx.fsf@fess.ebiederm.org>
	<200911182332.56309.arnd@arndb.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 18 Nov 2009 15:55:38 -0800
In-Reply-To: <200911182332.56309.arnd@arndb.de> (Arnd Bergmann's message of
	"Wed\, 18 Nov 2009 23\:32\:56 +0000")
Message-ID: <m1bpiz8k1x.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] [PATCH 1/3] macvlan: Reflect macvlan packets meant for
	other macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 18 November 2009 14:37:50 Eric W. Biederman wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > On Wednesday 18 November 2009, Eric Dumazet wrote:
>> >> 
>> >> Why do you drop dst here ?
>> >> 
>> >> It seems strange, since this driver specifically masks out IFF_XMIT_DST_RELEASE
>> >> in its macvlan_setup() :
>> >> 
>> >> dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
>
> It seems that we should never drop dst then. We either forward the frame to
> netif_rx or to dev_queue_xmit, and from how I read it now, we want to keep
> the dst in both cases.

When we loop back on our selves we certainly need to have dst clear because
we don't know how to cache routes through multiple network namespaces.  It
might be handy if we had those but that is a problem for another day.

>> Please copy and ideally share code with the veth driver for recycling a skb.
>> There are bunch of little things you have to do to get it right.  As I recally
>> I was missing a few details in my original patch.
>
> Are you thinking of something like the patch below? I haven't had the chance
> to test this, but one thing it does is to handle the internal forwarding
> differently from the receive path.

Yes.  That is a bit more sharing than I had anticipated, but it looks like
it works.

Eric
