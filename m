Return-Path: <gustavoars@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594232706;
 bh=M9MY+fWX6+x29R7/l42mVKrvKcjn7f0nCowboASuXE8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bMhYtMoFpRSCBD1jPT24LCNWTQrQSw+82QgcYiQLI0gRA70YcJQT+Ju4VSHdQ0pLI
 FyLQwsk0fX///QKIxb5z1OCMSBawvXXEW2wcLBbF+Rw0LpmEDMbj/AH/vb0He6Q2Af
 LdZjwrsMDsGuqOniiyvSdo7GcDQayAzsr8JhGWn0=
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <20200708183033.GG11533@embeddedor>
References: <20200707194717.GA3596@embeddedor> <20200708160931.GA14715@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708160931.GA14715@salvia>
Subject: Re: [Bridge] [PATCH][next] netfilter: nf_tables: Use fallthrough
 pseudo-keyword
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 08 Jul 2020 18:25:08 -0000
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Wed, Jul 08, 2020 at 06:09:31PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Jul 07, 2020 at 02:47:17PM -0500, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> 
> I suggest:
> 
>         netfilter: Use fallthrough pseudo-keyword
> 
> instead, since this is also updating iptables and ipset codebase.
> 

Yep; I noticed that, but forgot to change the subject before submitting
the patch.

I will address the rest of the comments and send v2, shortly.

Thanks
--
Gustavo

