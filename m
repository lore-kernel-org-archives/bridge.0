Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 5 Jul 2020 21:08:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
 t=1593976134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dlf83gnJimOcGLge0RE4YQ95UNZUa/xyinaF6hcyXc=;
 b=ScLBZ4iErn0Ka4U7KqaaDg1VueVrFtp84H2/aG3f0uGS28X0BYcFs15LJj7RPuLZaanzu0
 NdXnXkh+VwdYK3b8AMcCnswepuR+sCmZnuQ8F4RMio3BBUsaBTYDqmxzqSu9lqry/rohjL
 08AOQ10u1m45BPMcYdksNeTDAsBoEJjaY1czMLt+ybLjZp69Ux11tlhrJqsFvvlC3eqSiK
 WXed3+Xo69XCNYJrlZNFWc+1ciwJJUmLRmcm/dfW+UgLdo0T/Js1ByFx/irHtd9h31Oy+E
 Gt3ncm95HdhnC6w6HF5Up+nQANTiVneEN5G5FX+wVE/advm6FZqpJaNv4knCfw==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20200705190851.GC2648@otheros>
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
 <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net] bridge: mcast: Fix MLD2 Report IPv6
 payload length check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Martin Weinelt <martin@linuxlounge.net>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

On Sun, Jul 05, 2020 at 09:33:13PM +0300, Nikolay Aleksandrov wrote:
> On 05/07/2020 21:22, Linus Lüssing wrote:
> > Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
> > igmp3/mld2 report handling") introduced a small bug which would potentially
> > lead to accepting an MLD2 Report with a broken IPv6 header payload length
> > field.
> > 
> > The check needs to take into account the 2 bytes for the "Number of
> > Sources" field in the "Multicast Address Record" before reading it.
> > And not the size of a pointer to this field.
> > 
> > Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
> > Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> > ---
> >  net/bridge/br_multicast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> I'd rather be more concerned with it rejecting a valid report due to wrong size. The ptr
> size would always be bigger. :)
> 
> Thanks!
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Aiy, you're right, it's the other way round. I'll update the
commit message and send a v2 in a minute, with your Acked-by
included.
