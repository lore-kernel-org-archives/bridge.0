Return-Path: <herbert@gondor.apana.org.au>
Date: Fri, 8 Mar 2013 10:31:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20130308023151.GA27155@gondor.apana.org.au>
References: <1362708423-23932-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362708423-23932-1-git-send-email-amwang@redhat.com>
Subject: Re: [Bridge] [Patch net] bridge: do not expire mdb entry when
 bridge still uses it
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Adam Baker <linux@baker-net.org.uk>

On Fri, Mar 08, 2013 at 10:07:03AM +0800, Cong Wang wrote:
> From: Cong Wang <amwang@redhat.com>
> 
> This is a long-standing bug and reported several times:
> https://bugzilla.redhat.com/show_bug.cgi?id=880035
> http://marc.info/?l=linux-netdev&m=136164389416341&w=2
> 
> This bug can be observed in virt environment, when a KVM guest
> communicates with the host via multicast. After some time (should
> be 260 sec, I didn't measure), the multicast traffic suddenly
> terminates.
> 
> This is due to the mdb entry for bridge itself expires automatically,
> it should not expire as long as the bridge still generates multicast
> traffic. It should expire when the bridge leaves the multicast group,
> OR when there is no multicast traffic on this bridge.
> 
> I fix this by adding another bool which is set when there is
> multicast traffic goes to the bridge, cleared in the expire timer and
> when IGMP leave is received. I ran omping for 15 minutes, everything
> looks good now.

I gather from the bugzilla entry that this happens where there is
no querier in the network.

So my question is why does this only affect the bridge port and
not other ports on the bridge?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
