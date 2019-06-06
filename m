Return-Path: <christian@brauner.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=+dI5swD1+omNHneKtJgThPzt3z+a6zgCfryKXerEk+I=;
	b=KpUcO0CnhBIu8G6mnGGrqCHe1Kkx45ZcW+oH2HZ2Kz7r+idRSFJWy0DVbMKv3k/uE/
	M/nUZ0pa9SZekl54rp6x3Vwe/QiB8ICNkwPBthR6RzgpCENAMQ0CMK5v9H1NIKzq+olP
	5EoyF3PiLb/LovgHPn8jgagX52/cJeJ6x4VhmFCbZD/1E1kCD/j6y9NP1SgkRn7jDKBX
	TK7bIdcWa3UO/PLu8KRVgxtvdv0xe6UzdcZAcp8XWK6uKNBvP5XB89OZC2ssq/cjozdJ
	MthlBYbsYBUoAD1Xr+9AYhFzp4WY04PuKZ3n1u8UdrzfLx0rRYn5pGDQVhNIHD2mHIES
	RqjA==
Date: Thu, 6 Jun 2019 17:19:39 +0200
From: Christian Brauner <christian@brauner.io>
Message-ID: <20190606151937.mdpalfk7urvv74ub@brauner.io>
References: <20190606114142.15972-1-christian@brauner.io>
	<20190606114142.15972-2-christian@brauner.io>
	<20190606081440.61ea1c62@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606081440.61ea1c62@hermes.lan>
Subject: Re: [Bridge] [PATCH RESEND net-next 1/2] br_netfilter: add struct
	netns_brnf
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: ueberall@themenzentrisch.de, vapier@chromium.org, richardrose@google.com, bhthompson@google.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, joelhockey@chromium.org, tyhicks@canonical.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, smbarber@chromium.org, davem@davemloft.net, pablo@netfilter.org

On Thu, Jun 06, 2019 at 08:14:40AM -0700, Stephen Hemminger wrote:
> On Thu,  6 Jun 2019 13:41:41 +0200
> Christian Brauner <christian@brauner.io> wrote:
> 
> > +struct netns_brnf {
> > +#ifdef CONFIG_SYSCTL
> > +	struct ctl_table_header *ctl_hdr;
> > +#endif
> > +
> > +	/* default value is 1 */
> > +	int call_iptables;
> > +	int call_ip6tables;
> > +	int call_arptables;
> > +
> > +	/* default value is 0 */
> > +	int filter_vlan_tagged;
> > +	int filter_pppoe_tagged;
> > +	int pass_vlan_indev;
> > +};
> 
> Do you really need to waste four bytes for each
> flag value. If you use a u8 that would work just as well.

I think we had discussed something like this but the problem why we
can't do this stems from how the sysctl-table stuff is implemented.
I distinctly remember that it couldn't be done with a flag due to that.

Christian
