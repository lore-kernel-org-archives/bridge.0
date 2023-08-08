Return-Path: <christopher.maness@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0653409A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F47D409A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691463055; x=1692067855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=To5RXdgTZuuS1AHvSrlZPoAVtMBfYbQuZKe1V5PCHGU=;
 b=hk+jDZrl3g+o4sMGmZCabtN/5AnLtuwYSMj/gPgSP5jEYRltMDEp8gR1KR3PAoQdbl
 1mPD04e7QwuBYp8dQtUhan7IrsHCz9nRfLpKT2kV9/mlU+mh7iLzNzoUSrFPVWwipOD6
 q1TBPuDV4nRSRSBp4V/lOBEhKgMReru3RolSHSEN0f12SXGiqxPgWA4lemQjUrXgfP0b
 9eSMaS0Lrlh3Hp5R6eNkjFGOMxplIuqi6pgCBrEZ/rsfKVThX0JpHq6AykEIQJrm9ZkH
 +wvjvoi0OZeiAqnoiw+ZytKa3+4s6OOqLNTXelwoIk85Wm8mUEBMLgOG45iVyn8pij86
 aDKg==
MIME-Version: 1.0
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
In-Reply-To: <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
From: Chris Maness <christopher.maness@gmail.com>
Date: Mon, 7 Aug 2023 19:50:44 -0700
Message-ID: <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

I tried running the current mainline kernel (current Arch Linux) with
simple single MUX socket (ax0) using LinFBB.  I was a happy camper as
it seemed to work fine at first, then the system just slowed to a
crawl.  I am wondering if any of these patches are addressing this
behavior.  No kernel panic like before, but not what I was hoping for.
I have also tried sixpack, and that explodes instantly the last time I
have checked.   That goes all the way back to the v4 kernels.  v2 is
fine there.

73 de Chris KQ6UP

On Mon, Aug 7, 2023 at 4:43=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Mon, Aug 07, 2023 at 04:00:49PM -0700, Chris Maness wrote:
> > When are these likely to hit the mainline release code?
>
> linux-next tomorrow. The first 7 patches are scheduled for mainline
> as they were merged + tested without any hiccups. These last few patches
> I'll wait and see. If nothing blows up on linux-next perhaps I'll
> include them to Linux for mainline during the next merge window.
>
>   Luis



--=20
Thanks,
Chris Maness
