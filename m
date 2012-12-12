Return-Path: <davem@davemloft.net>
Date: Wed, 12 Dec 2012 13:03:29 -0500 (EST)
Message-Id: <20121212.130329.1972887047089057344.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1355300590-2390-2-git-send-email-amwang@redhat.com>
References: <1355300590-2390-1-git-send-email-amwang@redhat.com>
	<1355300590-2390-2-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] bridge: add support of adding and
 deleting mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: amwang@redhat.com
Cc: tgraf@suug.ch, netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, herbert@gondor.hengli.com.au

From: Cong Wang <amwang@redhat.com>
Date: Wed, 12 Dec 2012 16:23:08 +0800

> From: Cong Wang <amwang@redhat.com>
> 
> This patch implents adding/deleting mdb entries via netlink.
> Currently all entries are temp, we probably need a flag to distinguish
> permanent entries too.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Graf <tgraf@suug.ch>
> Signed-off-by: Cong Wang <amwang@redhat.com>

Applied.
