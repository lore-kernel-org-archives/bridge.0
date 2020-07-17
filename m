Return-Path: <mkl@pengutronix.de>
References: <20200717062331.691152-1-hch@lst.de>
 <20200717062331.691152-23-hch@lst.de>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <5f88e695-d787-2191-feef-883a067788ed@pengutronix.de>
Date: Fri, 17 Jul 2020 10:01:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200717062331.691152-23-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 22/22] net: make ->{get,
	set}sockopt in proto_ops optional
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, Alexei Starovoitov <ast@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, linux-bluetooth@vger.kernel.org, linux-sctp@vger.kernel.org, netfilter-devel@vger.kernel.org, mptcp@lists.01.org, Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, bpf@vger.kernel.org, linux-can@vger.kernel.org, linux-wpan@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>

On 7/17/20 8:23 AM, Christoph Hellwig wrote:
> Just check for a NULL method instead of wiring up
> sock_no_{get,set}sockopt.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  net/can/bcm.c               |  2 --
>  net/core/sock.c             | 14 --------------

For the CAN part:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
