Return-Path: <christopher.maness@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AF9140350
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 624E440102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464055; x=1692068855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0G2Gm44L7ws5E/quoPqMuJmdghfzOor5wGEa6AaRIig=;
 b=MIB1dRWNV6Yb3HUd1qPb/bgwaoUzAlGVu8CxiiwIDYwN4TMseNzdPMVbuAfPyciWjI
 AZzeBtiA00C4EVQ8EGlp9e8Q3pbBFc8aCRl+HJu3YtRoio8lAQY1qu2UvIE5hChxs5Q1
 PKMC/y7tlRiDWg5YOtPXbZsaYs//GKuhiSEDo5WpI7edOLzGAaAJjqvFIOQWWQAuLo7Z
 JBsPnB5UvxOuJ1p76ZyxSuA7+KQWE3J2jS89kM5pl3PIv+dMsBBD/LquAyRZomdcC7zN
 v+sSG+iPprRQeQoEH+XZP/GEzjEboCjqHBhNwHzm7vxhsHdZplrvrz31A5i2G+xxBQ4/
 u+EA==
MIME-Version: 1.0
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
 <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
 <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
In-Reply-To: <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
From: Chris Maness <christopher.maness@gmail.com>
Date: Mon, 7 Aug 2023 20:07:24 -0700
Message-ID: <CANnsUMGHnurbph9F7mex=1s0mxhwpNgeQbKJ6j1r37Qmd6LAMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH v2 00/14] sysctl: Add a size argument to
 register functions in sysctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Paolo Abeni <pabeni@redhat.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Will Deacon <will@kernel.org>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Joerg Reuter <jreuter@yaina.de>, Sven Schnelle <svens@linux.ibm.com>, Joel Granados <joel.granados@gmail.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Christian Borntraeger <borntraeger@linux.ibm.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, linux-sctp@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>, Pablo Neira Ayuso <pablo@netfilter.org>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

>
> Are you reporting a separate regression that goes all the way back to v4 kernels?
>

I am not certain what you mean by regression.

> > v2 is fine there.
>
> What does this mean?

I have to go all the way back to kernel version 2 for the serial 6PACK
driver to work.  If I try to use it in Kernel version 4, 5, or 6 the
kernel panics as soon as I attempt to connect to another station.

>
>   Luis

Chris KQ6UP


-- 
Thanks,
Chris Maness
