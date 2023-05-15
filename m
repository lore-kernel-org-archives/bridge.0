Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 039ED83BF8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43AED8195C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1684150024; bh=bcONLAH6knXEHrJvGB7J70yRBg1clKW8Wz9ykyvwfy8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oK3ZKzYcmUluEMqNNca2Kz/Ij2k2eig4BbmFqsmj+13HW3/R97ahsKogkAmpLDz3n
 AcM4x4WRdHofipIAN/j2LwMEamGTDiMC24lOotXmEVChJ1fkJ4J9SgqgylFGYE6F6l
 LJlbkZLSDogGewrnt0mlQGufbLecprRxc1i8tK90=
Date: Mon, 15 May 2023 13:27:03 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Message-ID: <ZGIXB2DYA4sal9eW@u-jnixdorf.ads.avm.de>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <20230515085046.4457-2-jnixdorf-oss@avm.de>
 <dc8dfe0b-cf22-c4f9-8532-87643a6a9ceb@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8dfe0b-cf22-c4f9-8532-87643a6a9ceb@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 2/2] bridge: Add a sysctl to limit new
 brides FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, May 15, 2023 at 12:35:47PM +0300, Nikolay Aleksandrov wrote:
> On 15/05/2023 11:50, Johannes Nixdorf wrote:
> > This is a convenience setting, which allows the administrator to limit
> > the default limit of FDB entries for all created bridges, instead of
> > having to set it for each created bridge using the netlink property.
> > 
> > The setting is network namespace local, and defaults to 0, which means
> > unlimited, for backwards compatibility reasons.
> > 
> > Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> > ---
> >  net/bridge/br.c         | 83 +++++++++++++++++++++++++++++++++++++++++
> >  net/bridge/br_device.c  |  4 +-
> >  net/bridge/br_private.h |  9 +++++
> >  3 files changed, 95 insertions(+), 1 deletion(-)
> > 
> 
> The bridge doesn't need private sysctls. Netlink is enough.
> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

Fair enough.

I originally included the setting so there is a global setting an
administrator could toggle instead of having to hunt down each process
that might create a bridge, and teaching them to create them with an
FDB limit.

Does any of the following alternatives sound acceptable to you?:
 - Having the default limit (instead of the proposed default to unlimited)
   configurable in Kbuild. This would solve our problem, as we build
   our kernels ourselves, but I don't know whether putting a limit there
   would be acceptable for e.g. distributions.
 - Hardcoding a default limit != 0. I was afraid I'd break someones
   use-case with far too large bridged networks if I don't default to
   unlimited, but if you maintainers have a number in mind with which
   you don't see a problem, I'd be fine with it as well.

(Sorry for sending this mail twice, I accidentally dropped the list and
CC on the fist try)
