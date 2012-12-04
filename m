Return-Path: <amwang@redhat.com>
Message-ID: <1354604692.15167.7.camel@cr0>
From: Cong Wang <amwang@redhat.com>
Date: Tue, 04 Dec 2012 15:04:52 +0800
In-Reply-To: <20121204013838.GA31329@gondor.apana.org.au>
References: <1354545363-11953-1-git-send-email-amwang@redhat.com>
	<20121203075316.0b1da39d@nehalam.linuxnetplumber.net>
	<20121204013838.GA31329@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] bridge: implement multicast fast leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Tue, 2012-12-04 at 09:38 +0800, Herbert Xu wrote:
> On Mon, Dec 03, 2012 at 07:53:16AM -0800, Stephen Hemminger wrote:
> > On Mon,  3 Dec 2012 22:36:03 +0800
> > Cong Wang <amwang@redhat.com> wrote:
> > 
> > > Fast leave allows bridge to immediately stops the multicast
> > > traffic on the port receives IGMP Leave when IGMP snooping is enabled,
> > > no timeouts are observed.
> > > 
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: Stephen Hemminger <shemminger@vyatta.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Signed-off-by: Cong Wang <amwang@redhat.com>
> > 
> > I like the feature, and it looks like an oversight in the initial design.
> > Why is this not the default, adding more options obscures it.
> 
> If the port has a bridge on it then you're toast.  I think this
> should be a per-port option.

Per-port sounds better than per-bridge. And I will make it enabled by
default.

Thanks!

