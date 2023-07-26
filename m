Return-Path: <mcgrof@infradead.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E612D405CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 862EF405D8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mOs0FbEX7U/JftVf/7w+izAt0GEtfD+who6ul2jmL1A=; b=Iln/whwi3yb0OCDfnbyBjMdx+m
 juFI59CritCNSyW6F5D0XpHC0iscqFmdZ00//lCiuYir0a6u4x+Trb0fDiT1I8lWJsP6oU29GK/FQ
 HnfImdfWz3d/FFVFAVn2c5NvOhMlPOV/jQ9Gw7gF/R+QQhgAxkPBg30gZGpfWe9e6F1g3T860ToDU
 3b3igthrZTDls6/w68U1gJwMhAvJIATJevMX85S2LJO5gw+sF1p7LDa7daV4DC/GaXuMpeYo9ezaB
 YVbkS848bTHFzserKKNJffxnqBuL9rIXky9EaSjRDnBy0AFCo9mO69kFKWdY6Q9jqUcRgtsOlJyZn
 kzcXs81A==;
Date: Wed, 26 Jul 2023 11:01:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <ZMFfb4bJ6neACe5X@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3@eucas1p1.samsung.com>
 <20230726140635.2059334-11-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-11-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Subject: Re: [Bridge] [PATCH 10/14] netfilter: Update to
	register_net_sysctl_sz
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joel Granados <j.granados@samsung.com>
Cc: coreteam@netfilter.org, keescook@chromium.org, josh@joshtriplett.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, Julian Anastasov <ja@ssi.bg>, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@verge.net.au>, netfilter-devel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Wed, Jul 26, 2023 at 04:06:30PM +0200, Joel Granados wrote:
> This is part of the effort to remove the sentinel (last empty) element
> from the ctl_table arrays. We update to the new function and pass it the
> array size. Care is taken to mirror the NULL assignments with a size of
> zero (for the unprivileged users)

Same in this commit, the "why" is missing and size impact, if any.

  Luis
