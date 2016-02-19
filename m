Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding;
	bh=yZlpe6aEN0DhZvWiq9gXmZQ7ZmIJVc42qUm08kwuQGM=;
	b=FHSOLicNl0igC+zb5sI54qUfsQkZo8Qanea75+5Un7nIE9ooIHQ1Dx8RRe7C4nkpbC
	YvjwCVIN/VqkZu0hNzu0GRwj2UjJO+l5rhw97THwPmi/V3J5rI+pg6zgkSmIPTMbvGks
	0wcLHLa9k1ZKTexeK1pDUqhHEWcgWamGqaJ/Ka3YQiyA21Q2otPgNOWHIhqf8IJQWfWN
	UPRez5uW2tk5oN/aGHWUkZKhQ54B4MPqc6mVL8Uv9lmsmDqD2G4CslERhJZTLzOKo3LQ
	YwNLLkfSwFCLAskJnIVVWgHIq+9f46zK9eqsqqGgO35XhNQ40h2gIATAGElet1PB4qqQ
	1YLw==
Date: Thu, 18 Feb 2016 17:38:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160218173825.3dca8d27@xeon-e3>
In-Reply-To: <20160218.153542.67284853154438064.davem@davemloft.net>
References: <1455502026-23144-1-git-send-email-linus.luessing@c0d3.blue>
	<20160218.153542.67284853154438064.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] net: fix bridge multicast packet checksum
	validation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sgunderson@bigfoot.com, tom@herbertland.com

On Thu, 18 Feb 2016 15:35:42 -0500 (EST)
David Miller <davem@davemloft.net> wrote:

> From: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Date: Mon, 15 Feb 2016 03:07:06 +0100
>=20
> > @@ -4084,10 +4089,22 @@ struct sk_buff *skb_checksum_trimmed(struct sk_=
buff *skb,
> >  	if (!pskb_may_pull(skb_chk, offset))
> >  		goto err;
> > =20
> > -	__skb_pull(skb_chk, offset);
> > +	ip_summed =3D skb->ip_summed;
> > +	csum_valid =3D skb->csum_valid;
> > +	csum_level =3D skb->csum_level;
> > +	csum_bad =3D skb->csum_bad;
> > +	csum =3D skb->csum;
> > +
> > +	skb_pull_rcsum(skb_chk, offset);
> >  	ret =3D skb_chkf(skb_chk);
> >  	__skb_push(skb_chk, offset);
> > =20
> > +	skb->ip_summed =3D ip_summed;
> > +	skb->csum_valid =3D csum_valid;
> > +	skb->csum_level =3D csum_level;
> > +	skb->csum_bad =3D csum_bad;
> > +	skb->csum =3D csum;
> > +
>=20
> There really has to be a better way to fix this :-/

Agreed, this is gross.
