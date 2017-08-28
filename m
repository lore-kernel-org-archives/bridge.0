Return-Path: <davem@davemloft.net>
Date: Mon, 28 Aug 2017 11:30:21 -0700 (PDT)
Message-Id: <20170828.113021.1460779644530852597.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503670907-23221-5-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
	<1503670907-23221-5-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 4/7] ipv4: make net_protocol const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bhumirks@gmail.com
Cc: alex.aring@gmail.com, gustavo@padovan.org, trond.myklebust@primarydata.com, bfields@fieldses.org, jlayton@poochiereds.net, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, stefan@osg.samsung.com, bridge@lists.linux-foundation.org, coreteam@netfilter.org, kadlec@blackhole.kfki.hu, kuznet@ms2.inr.ac.ru, pablo@netfilter.org, johan.hedberg@gmail.com, marcel@holtmann.org, santosh.shilimkar@oracle.com, julia.lawall@lip6.fr, linux-nfs@vger.kernel.org, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, fw@strlen.de, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-wpan@vger.kernel.org, anna.schumaker@netapp.com

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Fri, 25 Aug 2017 19:51:44 +0530

> Make these const as they are only passed to a const argument of the
> function inet_add_protocol.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied.
