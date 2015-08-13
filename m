Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=rLAOq+n28EFGZwzKzfGT7Y/gNmH3OIkoP+er4Quv5N0=;
	b=RbYOXN+cxy3HXKmkzvbIXweRiiEWOO9t7DDOeDz96SiHrSaA8URj7IJNC68MwqG3NV
	MNW8Uu/d7RR3KZl5TmxThW7i0jYRe4mDwNyH1oORyzaqeUF3EqlzN9EXsL+MmzCLPMVX
	HfzQPDpapsYI40/dO2QbKQ3CbPgiW11NxY0iEU83V4GNv709lDwE3sFOYOQppq1TnoYp
	/zldp+mhtho6phMuw0sPtXlf1G06ZnPXOmGjNapvGUis3CYO6hO0CFW5r1O5BkzWwguH
	7K/pCK6xup/jTv1+hm1yLgNrxZQGZpHaJISe9hZi+ix6rlDarI3VDpGxyTr5s5AkX+zg
	gYww==
Date: Wed, 12 Aug 2015 21:55:50 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Message-ID: <20150813045549.GA60201@Alexeis-MBP.westell.com>
References: <1439438047-19441-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1439438047-19441-1-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH] net: fix wrong skb_get() usage / crash in
 IGMP/MLD parsing code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Brenden Blanco <bblanco@plumgrid.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Thu, Aug 13, 2015 at 05:54:07AM +0200, Linus L=FCssing wrote:
> The recent refactoring of the IGMP and MLD parsing code into
> ipv6_mc_check_mld() / ip_mc_check_igmp() introduced a potential crash /
> BUG() invocation for bridges:
>=20
> I wrongly assumed that skb_get() could be used as a simple reference
> counter for an skb which is not the case. skb_get() bears additional
> semantics, a user count. This leads to a BUG() invocation in
> pskb_expand_head() / kernel panic if pskb_may_pull() is called on an skb
> with a user count greater than one - unfortunately the refactoring did
> just that.
>=20
> Fixing this by removing the skb_get() call and changing the API: The
> caller of ipv6_mc_check_mld() / ip_mc_check_igmp() now needs to
> additionally check whether the returned skb_trimmed is a clone.
>=20
> Fixes: 9afd85c9e455 ("net: Export IGMP/MLD message validation code")
> Reported-by: Brenden Blanco <bblanco@plumgrid.com>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

I think the fix actually made the code easier to read.
Thank you. Looks good to me.
Acked-by: Alexei Starovoitov <ast@plumgrid.com>

