Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pkAeuej3gdZFNiFWlqKwdOkIgpTFqwzSdrNs/9nMtvM=;
	b=Ip8+0gIrEZSN5YIq+9JgarDrUD2oKawKiGhquHBepSQj2xKVBC3UwMRdAoU+ITPRGZ
	bwSCeIILbFqNQNoWV3lZyRfv1Ba4rMpgnfajjqwYc6RgS9uRFK/v/1i32UHHuVM9LkET
	6lQUJw10Nwde0w/i7BLw4ms32C5w32HF8hEq2Q/31fAugzbbMow1lypDiaxj9N51UFXg
	6AL57Ad3dSfTdprqnHsTpEOVyu95rskRqOje/TI6a6YVIJs1QFsE3M+cbl3mnR4EC3wc
	2oRkjtMh3UiyVhvkxtzKmBtNReGQfFksRdLffw2JrcUUxszs4yMaxho1oLls1T3+tzjP
	YEoQ==
MIME-Version: 1.0
References: <000000000000862b160580765e94@google.com>
	<3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
	<CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
	<20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
In-Reply-To: <20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 21 Feb 2019 11:54:42 +0100
Message-ID: <CACT4Y+bUTWcvqEebNjoagw0JtM77NXwVu+i3cYmhgnntZRWyfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] KASAN: use-after-free Read in br_mdb_ip_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>, Thomas Graf <tgraf@suug.ch>, David Miller <davem@davemloft.net>

On Wed, Feb 20, 2019 at 11:23 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Jan 28, 2019 at 09:28:36AM +0100, Dmitry Vyukov wrote:
> >
> > > Weird, this is the kfree() on the error path of br_multicast_new_group()
> > > when rhashtable_lookup_insert_fast() fails, which means the entry should
> > > not be linked in the rhashtable or the hlist.
> > > All other frees are via kfree_rcu. I'll keep looking..
> >
> > Humm.... +rhashtable.c maintianers
> >
> > The code in br_multicast_new_group is effectively:
> >
> > mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
> > err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
> > br_mdb_rht_params);
> > if (err)
> >     kfree(mp);
> >
> > So it looks like rhashtable_lookup_insert_fast both returned an error
> > and left the new object linked in the table. Since it happened only
> > once, it may have something to do with concurrent resizing/shrinking.
>
> I've looked through the rhashtable code in question and everything
> looks OK.  So I suspect some earlier corruption has occured to cause
> this anomalous result.


Taking into account that this still happened only once, I tend to
write it off onto a previous silent memory corruption (we have dozens
of known bugs that corrupt memory). So if several people already
looked at it and don't see the root cause, it's probably time to stop
spending time on this until we have more info.

Although, there was also this one:
https://groups.google.com/d/msg/syzkaller-bugs/QfCCSxdB1aM/y2cn9IZJCwAJ
I have not checked if it can be the root cause of this report, but it
points suspiciously close to this stack and when I looked at it, it
the report looked legit.


> Is it possible to collect earlier alloc/free stack traces on the object in question?

You mean even before the alloc/free of the current incarnation this
object? This looks challenging from memory consumption point of view.
Also how many of them will we print in reports? Also the page can go
through page_alloc and then tracking will be even more challenging.
And in the end the object can be corrupted by an out-of-bounds write
or a like. Heap object reuse quarantine should take care of the common
case, and I don't see a reasonable way to handle all possible corner
cases...
