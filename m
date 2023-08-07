Return-Path: <mcgrof@infradead.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8273260AD8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C0C460AA7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=R7l6QScXv7U38OrlWS7Mcrb8Q93Tbo+TJ0PZi9bIVzI=; b=lvQhpYkugp8p+MnqK1ZwyEPyPV
 qQ13g/zVYcvPRrYd2noywzgnhct1y5FSUHLn9ld+CBTnhLURNvgr/bgoc4bC5EjlpBpGWWJSfX6T/
 Qmk68ZOOTeEEYcestzUADl5Dpi2gJuWSQGiqWBWdo7zHkuT9gtEQcp0EWL0J2TwWVfknB/pb1efBJ
 /qWuJAAvELKv3Gu45SonJbWc0VbDj+8+j0QZPdUmEmVKMoxo/rXWuGEKo/o2tIRBYi/rELO7VQcCa
 I8mjAfAkS2C8C5SdfIKOYZeY5S9V20FFyb9rMjgiCJ7HvitG7HyaaV+Ort6BR6cHisL1dXBl+Z9Mq
 S3J7uphA==;
Date: Mon, 7 Aug 2023 16:43:42 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
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
To: Chris Maness <christopher.maness@gmail.com>
Cc: Joel Granados <j.granados@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Paolo Abeni <pabeni@redhat.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Will Deacon <will@kernel.org>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Joerg Reuter <jreuter@yaina.de>, Sven Schnelle <svens@linux.ibm.com>, Joel Granados <joel.granados@gmail.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Christian Borntraeger <borntraeger@linux.ibm.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, linux-sctp@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>, Pablo Neira Ayuso <pablo@netfilter.org>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

On Mon, Aug 07, 2023 at 04:00:49PM -0700, Chris Maness wrote:
> When are these likely to hit the mainline release code?

linux-next tomorrow. The first 7 patches are scheduled for mainline
as they were merged + tested without any hiccups. These last few patches
I'll wait and see. If nothing blows up on linux-next perhaps I'll
include them to Linux for mainline during the next merge window.

  Luis
