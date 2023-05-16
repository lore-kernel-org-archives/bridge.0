Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60870405F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 522004018F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1684225630; bh=Tyjh52SJUtEZHmo/Wzy9QwV/tPNvfbDEEm6u+11MU2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LDkJ7udFpSJqnmgyawPTu++RK58Dl96gSGRBixHmhsVKfvnHypuCY49oKafaf9wBR
 0O7JcG68AGzGJRBtNNQJMp9ztVtukmHHInGGSqNszId8LOWAHNevaI+d7ma03tfuYt
 TDPTnk4Z8vP3CKhzMEhaqzsgJc/1V7twHeObB59k=
Date: Tue, 16 May 2023 10:27:10 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Message-ID: <ZGM-Xv8sRmeePiGL@u-jnixdorf.ads.avm.de>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <20230515085046.4457-2-jnixdorf-oss@avm.de>
 <20230515085627.5897dab1@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515085627.5897dab1@hermes.local>
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
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, May 15, 2023 at 08:56:27AM -0700, Stephen Hemminger wrote:
> On Mon, 15 May 2023 10:50:46 +0200
> Johannes Nixdorf <jnixdorf-oss@avm.de> wrote:
> 
> > +static struct ctl_table br_sysctl_table[] = {
> > +	{
> > +		.procname     = "bridge-fdb-max-entries-default",
> 
> 
> That name is too long.
> 
> Also, all the rest of bridge code does not use sysctl's.

The code in net/bridge/br_netfilter_hooks.c also uses sysctls, which is
where I took inspiration for the approach for setting them up, and also
the naming scheme.

> Why is this special and why should the property be global and not per bridge?

As explained in the commit message and [1] it is a global default
setting. It makes no sense to make it per bridge, as there is already
a per bridge netlink setting that overrides it. The only alternative
option is to not have it at all, which is what I will be going to do
with a v2.

> NAK

Fair enough. I took it out in my pending-v2-state of the series, but
would welcome some input on whether you see any value in the proposed
alternatives in [1], or are strictly against having a global default !=
0 here at all.

[1]: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/T/#ma4145398516bfd39dfa09976b7892f5fdb76f8c0
