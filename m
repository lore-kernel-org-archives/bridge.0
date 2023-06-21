Return-Path: <dan.carpenter@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE7D541620
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD22541BA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687344600; x=1689936600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fSRkwHLFq+2I9Xiyi/hU6wMpRwozZdsPaoeIOTE25yg=;
 b=AIsj2vEdz+Fc9Jy19U2Q4+7jk5CdnnBRAq8EU0/qgIBKasDy/i9F7ZXwuxvu/FIk+V
 e/sUJHlgDgR4Qx2Oh1t5R17vdDFqF/9Ly0AVSK9zUVBFtxeRPEJfGRY1Ks9BJsa7NWkf
 GXQKQBgxImLcLHozIYWaaIqJ2GrVDZ8vDZMAG4ZNWlYOBv1zbniTnw6kcMxllyCdLRPM
 ZQ4LPyPa8TOuuqU/g5NEtzVey08OWckHaORybMu3dXpLsx3EAMUOJp98YetCTODsSvBK
 UGnxHZVFuD2xpLdXg7xgTBB0HXflRT1SIPGFL3SgcodXnvQYRGYsUcq+78aAj0lpxCAJ
 /6yw==
Date: Wed, 21 Jun 2023 13:49:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <f95b7489-8654-435c-bc74-da1eac479fba@kadam.mountain>
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
 <20230621091000.424843-7-j.granados@samsung.com>
 <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZFMDZBc9cnLbyP1u"
Content-Disposition: inline
In-Reply-To: <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
Subject: Re: [Bridge] [PATCH 06/11] sysctl: Add size to register_net_sysctl
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joel Granados <j.granados@samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Marc Dionne <marc.dionne@auristor.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, linux-afs@lists.infradead.org, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky <leon@kernel.org>, dccp@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Martin Schiller <ms@dev.tdt.de>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-sctp@vger.kernel.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, Remi Denis-Courmont <courmisch@gmail.com>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Karsten Graul <kgraul@linux.ibm.com>, Jon Maloy <jmaloy@redhat.com>, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>, Ying Xue <ying.xue@windriver.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


--ZFMDZBc9cnLbyP1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 12:47:30PM +0300, Dan Carpenter wrote:
> The patchset doesn't include the actual interesting changes, just a
> bunch of mechanical prep work.
> 

I was wrong here, the patchset just hadn't all hit the mailing lists.
I can't apply this patchset to anything.  I tried linux-next, net, and
net-next.  So it's hard to review.

It looks like ensure_safe_net_sysctl() never got update to use
table_size...

You could easily write a static checker test to print a warning any time
that ->procname is checked for NULL.  I have attached a Smatch check.
You would need to added to check_list.h and recompile.

net/sysctl_net.c:130 ensure_safe_net_sysctl() warn: checking ->procname 'ent->procname'

regards,
dan carpenter


--ZFMDZBc9cnLbyP1u
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_checking_procname.c"

#include "smatch.h"
#include "smatch_slist.h"

static int my_id;

static void match_condition(struct expression *expr)
{
	char *member_name;

	if (expr->type == EXPR_COMPARE)
		return;

	member_name = get_member_name(expr);
	if (!member_name)
		return;

	if (strcmp(member_name, "(struct ctl_table)->procname") == 0)
		sm_warning("checking ->procname '%s'", expr_to_str(expr));
}

void check_checking_procname(int id)
{
	my_id = id;

	add_hook(&match_condition, CONDITION_HOOK);
}

--ZFMDZBc9cnLbyP1u--
