Return-Path: <herbert@gondor.apana.org.au>
Date: Wed, 20 Feb 2019 18:23:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
References: <000000000000862b160580765e94@google.com>
	<3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
	<CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
Subject: Re: [Bridge] KASAN: use-after-free Read in br_mdb_ip_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>, Thomas Graf <tgraf@suug.ch>, David Miller <davem@davemloft.net>

On Mon, Jan 28, 2019 at 09:28:36AM +0100, Dmitry Vyukov wrote:
>
> > Weird, this is the kfree() on the error path of br_multicast_new_group()
> > when rhashtable_lookup_insert_fast() fails, which means the entry should
> > not be linked in the rhashtable or the hlist.
> > All other frees are via kfree_rcu. I'll keep looking..
> 
> Humm.... +rhashtable.c maintianers
> 
> The code in br_multicast_new_group is effectively:
> 
> mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
> err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
> br_mdb_rht_params);
> if (err)
>     kfree(mp);
> 
> So it looks like rhashtable_lookup_insert_fast both returned an error
> and left the new object linked in the table. Since it happened only
> once, it may have something to do with concurrent resizing/shrinking.

I've looked through the rhashtable code in question and everything
looks OK.  So I suspect some earlier corruption has occured to cause
this anomalous result.  Is it possible to collect earlier alloc/free
stack traces on the object in question?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
