Return-Path: <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1503670907-23221-4-git-send-email-bhumirks@gmail.com>
Date: Fri, 25 Aug 2017 18:17:21 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <34C7927D-4D0A-4EB4-AB3E-7DEB9FA7E8B0@holtmann.org>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
	<1503670907-23221-4-git-send-email-bhumirks@gmail.com>
Subject: Re: [Bridge] [PATCH 3/7] ieee802154: 6lowpan: make header_ops const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, trond.myklebust@primarydata.com, bfields@fieldses.org, jlayton@poochiereds.net, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>, bridge@lists.linux-foundation.org, coreteam@netfilter.org, kadlec@blackhole.kfki.hu, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pablo Neira Ayuso <pablo@netfilter.org>, Johan Hedberg <johan.hedberg@gmail.com>, santosh.shilimkar@oracle.com, julia.lawall@lip6.fr, linux-nfs@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Network Development <netdev@vger.kernel.org>, Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, netfilter-devel@vger.kernel.org, linux-wpan@vger.kernel.org, anna.schumaker@netapp.com

Hi Bhumika,

> Make this const as it is only stored as a reference in a const field of
> a net_device structure.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> net/ieee802154/6lowpan/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

