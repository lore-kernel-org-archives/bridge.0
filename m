Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 14 Aug 2019 20:26:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1565807167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	in-reply-to:in-reply-to:references:references;
	bh=7nyPcyqyP1juKKcIR2Q9YuG+lYaGhTARXGVglzh/Y5Q=;
	b=PGbW1DmxbCzsmxwfYv6xF/QbmNKC7wyjcAH6jiVLh2j6fajxyxXV/bvn0hzrWP9ibZw/ug
	wnbIVjh6kO4a6wtaC1BZpgGnuBKchM08EKHpo1geUzSGWGsYYhGVAo+CZNQwFhvjXs87cb
	BBeNi+rBDahfxeHSnw2UiOuU3sRWBlnnEu+GQcAgCWg/0/XuKqCRLX8PgwGx2zsGko6UoO
	XC80W34IlpfE2usj1CMTIf6VgCPZBBqcybDV4slqLXK8DNBTbipBoScC4QFdc85XsjIiLy
	mMv+NTydzt6jcl+ioTuTADysxJb/dnCONEvS5y45M+9+ibeHvX5Qwz4Fg7g+Wg==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190814182604.GD2431@otheros>
References: <dc0d0b1bc3c67e2a1346b0dd1f68428eb956fbb7.1565649789.git.sbrivio@redhat.com>
	<20190814.125858.37782529545578263.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814.125858.37782529545578263.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH net] ipv6: Fix return value of
 ipv6_mc_may_pull() for malformed packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: bridge@lists.linux-foundation.org, haliu@redhat.com, netdev@vger.kernel.org, gnault@redhat.com, sbrivio@redhat.com, edumazet@google.com

On Wed, Aug 14, 2019 at 12:58:58PM -0400, David Miller wrote:
> From: Stefano Brivio <sbrivio@redhat.com>
> Date: Tue, 13 Aug 2019 00:46:01 +0200
> 
> > Commit ba5ea614622d ("bridge: simplify ip_mc_check_igmp() and
> > ipv6_mc_check_mld() calls") replaces direct calls to pskb_may_pull()
> > in br_ipv6_multicast_mld2_report() with calls to ipv6_mc_may_pull(),
> > that returns -EINVAL on buffers too short to be valid IPv6 packets,
> > while maintaining the previous handling of the return code.
> > 
> > This leads to the direct opposite of the intended effect: if the
> > packet is malformed, -EINVAL evaluates as true, and we'll happily
> > proceed with the processing.
> > 
> > Return 0 if the packet is too short, in the same way as this was
> > fixed for IPv4 by commit 083b78a9ed64 ("ip: fix ip_mc_may_pull()
> > return value").
> > 
> > I don't have a reproducer for this, unlike the one referred to by
> > the IPv4 commit, but this is clearly broken.
> > 
> > Fixes: ba5ea614622d ("bridge: simplify ip_mc_check_igmp() and ipv6_mc_check_mld() calls")
> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> 
> Applied and queued up for -stable.

Urgh, sorry... and thanks for the fix(es), absolutely right...
