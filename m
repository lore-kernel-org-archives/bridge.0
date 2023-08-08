Return-Path: <mcgrof@infradead.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 618F240447
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4C0F40350
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2sy570se2d1y/tNUc5KxUhtFZdHaIMpjXMloRWfAQC8=; b=LFTrjMpESf0K2WDYsgcYshMVZb
 XVav8xxO1YOSh/f7kB16OzY0uBkVxWCZvBuYbhPMnpSryFVcJMA4U85MD7ki5SJW+wKWHz7l/i5Ud
 asF14iLCZhDvbu3bBlUZpGHDWWZShHGraWmRr0zUN9avXuF4GiC3kbqxQlKmcOfQpYDAw17HvvUYa
 g7VEp36XJrjJHaC6TZnT+EHhXr0jTCtQtZf/X0ow7oIwBOlWCyLO9p3mX//iCo46M6JmQGR0Xskpr
 kQ5/2g384H8/rcW5PZkcI/7KwR40BJHcWTCqG1O79Ofbz7S65Cn4CzgMg7znP4sOgksRuXlcNy/uI
 O/5mNnZA==;
Date: Mon, 7 Aug 2023 19:34:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <ZNGpnSCkVYAnfSfa@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <20230807190914.4ff3eb36@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807190914.4ff3eb36@kernel.org>
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Alexander Aring <alex.aring@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Wen Gu <guwen@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, Joerg Reuter <jreuter@yaina.de>, Christian Borntraeger <borntraeger@linux.ibm.com>, Joel Granados <joel.granados@gmail.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Iurii Zaikin <yzaikin@google.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

On Mon, Aug 07, 2023 at 07:09:14PM -0700, Jakub Kicinski wrote:
> On Mon, 7 Aug 2023 14:44:11 -0700 Luis Chamberlain wrote:
> > > This is looking great thanks, I've taken the first 7 patches above
> > > to sysctl-next to get more exposure / testing and since we're already
> > > on rc4.  
> > 
> > Ok I havent't heard much more feedback from networking folks
> 
> What did you expect to hear from us?

Just a sanity review would be nice.

> My only comment is to merge the internal prep changes in and then send
> us the networking changes in the next release cycle.

OK we can do that, I can soak them on linux-next from now so to be sure
it gets wider testing. But review on those parts would be nice.

  Luis
