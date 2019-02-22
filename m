Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=5gLp8zNrQenZmkQOHDe23IakIFO7pYZ3fcPW0z5/sqs=;
	b=cp4suVLVK722LaZ5k18RAqHnohgkrdPG698TH2yJ2zTuMnat3OdwZULefiEglX4ayK
	8G81BWMwwSmXD/3CrgiQBOmOupJsR1pWEn2EOrjqn5OjG1XskUwBaFwM+Buoor14Ij8R
	+ADu3qDBsxhCJNc2Wop7qzWnSQRP3UYGEmTSwBjDO5hF6u6F4s5bKW5TNXMGEM0OLdnl
	55aMl4hXE575daqClVRmWziCB6/9B7YUS7QfiJlEDOHkcJyjzkXoJZ6OZqukyqBAA281
	iVH+PY5u/dSJKhZMWkixdgxkqHs2KMzT7DzsIeIU11iX6+HQXm7vPiSaLzy4EQlfUhGD
	xeRw==
Date: Fri, 22 Feb 2019 20:49:04 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20190222124904.GO10051@dhcp-12-139.nay.redhat.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181029013316.GK24677@leo.usersys.redhat.com>
	<20181213161027.GC1713@otheros>
	<20190221080114.GL10051@dhcp-12-139.nay.redhat.com>
	<9db055dd-6486-1d6e-7dce-edc511650af9@cumulusnetworks.com>
	<20190222075705.GN10051@dhcp-12-139.nay.redhat.com>
	<2f60dc0a-f6ee-06ad-f60c-15e035574a75@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f60dc0a-f6ee-06ad-f60c-15e035574a75@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, Sebastian Gottschall <s.gottschall@newmedia-net.de>, davem@davemloft.net

On Fri, Feb 22, 2019 at 01:16:53PM +0200, Nikolay Aleksandrov wrote:
> > 
> > For consistency with other vendors and rfc, I would prefer to remove zero address election.
> > For compatibility with previous users, I'm also OK to revert it.
> > > Regards
> > Hangbin
> > 
> 
> Hi,
> In this case I'd suggest the following course of action:
>  - For -net/-stable revert the change since backporting new options is a
>    no-go and we need to restore the bridge state
>  - After -net is merged in net-next, for net-next if you'd like add it
>    as an option and also exclude it from elections when the option is
>    enabled (for example something like multicast_nonzero_src_querier).
>    Just please use the boolopt api and don't add new fields/attr ids.
>    Obviously by default this option will be off to be backwards
>    compatible and avoid surprise mcast flood.
> 
> Or just leave it reverted. :)

This makes sense to me. Thanks for your suggestions.

Regards
Hangbin
