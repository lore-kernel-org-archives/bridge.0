Return-Path: <shemminger@vyatta.com>
Date: Mon, 3 Dec 2012 07:53:16 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20121203075316.0b1da39d@nehalam.linuxnetplumber.net>
In-Reply-To: <1354545363-11953-1-git-send-email-amwang@redhat.com>
References: <1354545363-11953-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: implement multicast fast leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.hengli.com.au>

On Mon,  3 Dec 2012 22:36:03 +0800
Cong Wang <amwang@redhat.com> wrote:

> Fast leave allows bridge to immediately stops the multicast
> traffic on the port receives IGMP Leave when IGMP snooping is enabled,
> no timeouts are observed.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Cong Wang <amwang@redhat.com>

I like the feature, and it looks like an oversight in the initial design.
Why is this not the default, adding more options obscures it.
