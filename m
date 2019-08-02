Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ddWKWrMPlRNzwUi7tu7acZVyIb6Fxbj7c6u3GdNlWxE=;
	b=OLiggddbzvXTeseZwRY2+R6otVkSDJAL05kqzZgTh5b+cj2XJaGCR3aV4A5CQIoKjR
	vp2otVeNe1jU8hkv96zPFFRMgHDsQj89q2rRlNeO21kJq8qP0MRRtxe0x3WICji3qRor
	wiR9zjhlTM65YAkyGWWWHhqVa20I1SjLW+PRI=
References: <319fda43-195d-2b92-7f62-7e273c084a29@cumulusnetworks.com>
	<20190731224955.10908-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <0a015a21-c1ae-e275-e675-431f08bece86@cumulusnetworks.com>
Date: Fri, 2 Aug 2019 03:38:43 +0300
MIME-Version: 1.0
In-Reply-To: <20190731224955.10908-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: move vlan init/deinit to
 NETDEV_REGISTER/UNREGISTER
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, michael-dev <michael-dev@fami-braun.de>

On 8/1/19 1:49 AM, Nikolay Aleksandrov wrote:
[snip]
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=204389
> 
> Reported-by: michael-dev <michael-dev@fami-braun.de>
> Fixes: 5be5a2df40f0 ("bridge: Add filtering support for default_pvid")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> I tried a few different approaches to resolve this but they were all
> unsuitable for some kernels, this approach can go to stables easily
> and IMO is the way this had to be done from the start. Alternatively
> we could move only the br_vlan_add and pair it with a br_vlan_del of
> default_pvid on the same events, but I don't think it hurts to move
> the whole init/deinit there as it'd help older stable releases as well.
> 
> I also tested the br_vlan_init error handling after the move by always
> returning errors from all over it. Since errors at NETDEV_REGISTER cause
> NETDEV_UNREGISTER we can deinit vlans properly for all cases regardless
> why it happened (e.g. device destruction or init error).
> 
>  net/bridge/br.c         |  5 ++++-
>  net/bridge/br_device.c  | 10 ----------
>  net/bridge/br_private.h | 20 +++++---------------
>  net/bridge/br_vlan.c    | 25 ++++++++++++++++++-------
>  4 files changed, 27 insertions(+), 33 deletions(-)
> 

Self-NAK, after thinking more about how to best handle this and running more
tests I believe it'll be better to go with the alternative I suggested above -
to move out only the default pvid add out of br_vlan_init to NETDEV_REGSITER
and pair it with br_vlan_delete in NETDEV_UNREGISTER. That way we'll split
the init/deinit in 2 steps, but we'll keep the current order and will reduce
the churn for this fix, functionally it should be equivalent as that is the
problematic part of the init which has to be done after the netdev has been
registered.

I'll spin v4 tomorrow after running more tests with it.

