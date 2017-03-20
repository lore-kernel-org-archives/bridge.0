Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h9qnr/glqt4VA9w+UMBX9VDBryezCx707GbbMasY1DQ=;
	b=G1hE7I0ikr/i/VHy5se3rvX5/
	FKXqFObLzpL3tpztBLDe4wD0VpDa864baPRpwkqCCE8/sXvz9QXrp0sqk/vfBeILRzxRhZ3lQtMQW
	23j/51lZ0oulnsRayNkS4LkVsTLTOEC1l1oIr0gq4whLVxlJji1oUMkLGfpMatniQ2KlVPJBpJNFI
	Wa0Y8QKixBPfgwPPs2clJKriivzHkyHOZhX/V18anH6qWoPI++7PfpG4Icq8iDrs7xk3igAJPcbf7
	QBuHiDNr6uK9WE1HI0fFpbDfQjvL5wbDl7LIdUo4A4A9Qka1lGlEc7WD3aL0oFoeGQmLGIBWwDtSC
	OxG5DCB0Q==;
Date: Mon, 20 Mar 2017 11:39:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170318.182121.439615057765380575.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH 07/17] net: convert sock.sk_refcnt from
 atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, eric.dumazet@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmorris@namei.org, ishkamiel@gmail.com, kuznet@ms2.inr.ac.ru, akpm@linux-foundation.org, dwindsor@gmail.com, kaber@trash.net, elena.reshetova@intel.com, keescook@chromium.org

On Sat, Mar 18, 2017 at 06:21:21PM -0700, David Miller wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Sun, 19 Mar 2017 00:47:59 +0800
> 
> > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >> On Fri, 2017-03-17 at 07:42 +0000, Reshetova, Elena wrote:
> >> 
> >>> Should we then first measure the actual numbers to understand what we
> >>> are talking here about? 
> >>> I would be glad to do it if you suggest what is the correct way to do
> >>> measurements here to actually reflect the real life use cases. 
> >> 
> >> How have these patches been tested in real life exactly ?
> >> 
> >> Can you quantify number of added cycles per TCP packet, where I expect
> >> we have maybe 20 atomic operations in all layers ...
> > 
> > I completely agree.  I think this thing needs to default to the
> > existing atomic_t behaviour.
> 
> I totally agree as well, the refcount_t facility as-is is unacceptable
> for networking.

Can we at least give a benchmark and have someone run numbers? We should
be able to quantify these things.

