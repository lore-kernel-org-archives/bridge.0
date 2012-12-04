Return-Path: <shemminger@vyatta.com>
Date: Tue, 4 Dec 2012 08:44:31 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20121204084431.72f9084c@nehalam.linuxnetplumber.net>
In-Reply-To: <1354615000-19660-1-git-send-email-amwang@redhat.com>
References: <1354615000-19660-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: implement multicast fast
	leave
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

On Tue,  4 Dec 2012 17:56:40 +0800
Cong Wang <amwang@redhat.com> wrote:

> V2: make the toggle per-port
> 
> Fast leave allows bridge to immediately stops the multicast
> traffic on the port receives IGMP Leave when IGMP snooping is enabled,
> no timeouts are observed.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Cong Wang <amwang@redhat.com>

Ok. as is.

A good followup change would be to migrate
these multicast flags into the existing flags bits (see hairpin etc),
and make them manageable via netlink.


