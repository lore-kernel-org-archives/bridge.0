Return-Path: <pabeni@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 182D0600B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3362060ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671548364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loRMWcnY9Zc3gsu659uSvWGLXQHgBLYyUdhTzCHdJL4=;
 b=AG4SyWL1LYL50s1w2LAPdx5YYqiZDvwdgENNggbb5PKzs+vKDq1IIGlL6nnknsuSYlo9KB
 iGP9E8FCh/ituQVH5w9tyvOU7/IiNwA3eoPfhuMtSyng4cYcnCVBFAMh9QyRA+Cetl+vlU
 /INDxGEvHKdTURpnB49hJlJ8k7pskXc=
Message-ID: <367438a5296d6b43d92287289f44f0e1dfe01d1a.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Dec 2022 15:59:15 +0100
In-Reply-To: <05d630bf-7fa8-4495-6345-207f133ef746@blackwall.org>
References: <20221220024807.36502-1-jgu@purestorage.com>
 <05d630bf-7fa8-4495-6345-207f133ef746@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] net: bridge: mcast: read ngrec once in
	igmp3/mld2 report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Joy Gu <jgu@purestorage.com>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, joern@purestorage.com

On Tue, 2022-12-20 at 12:13 +0200, Nikolay Aleksandrov wrote:
> On 20/12/2022 04:48, Joy Gu wrote:
> > In br_ip4_multicast_igmp3_report() and br_ip6_multicast_mld2_report(),
> > "ih" or "mld2r" is a pointer into the skb header. It's dereferenced to
> > get "num", which is used in the for-loop condition that follows.
> > 
> > Compilers are free to not spend a register on "num" and dereference that
> > pointer every time "num" would be used, i.e. every loop iteration. Which
> > would be a bug if pskb_may_pull() (called by ip_mc_may_pull() or
> > ipv6_mc_may_pull() in the loop body) were to change pointers pointing
> > into the skb header, e.g. by freeing "skb->head".
> > 
> > We can avoid this by using READ_ONCE().
> > 
> > Suggested-by: Joern Engel <joern@purestorage.com>
> > Signed-off-by: Joy Gu <jgu@purestorage.com>
> > ---
> >  net/bridge/br_multicast.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> I doubt any compiler would do that (partly due to the ntohs()). 

I would say that any compiler behaving as described above is buggy, as
'skb' is modified inside the loop, and the header pointer is fetched
from the skb, it can't be considered invariant.

> If you have hit a bug or
> seen this with some compiler please provide more details, disassembly of the resulting
> code would be best.

Exactly. A more detailed description of the issue you see is necessary.
And very likely the proposed solution is not the correct one.

Cheers,

Paolo

