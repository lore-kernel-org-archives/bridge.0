Return-Path: <davem@davemloft.net>
Date: Sat, 15 Dec 2012 17:16:56 -0800 (PST)
Message-Id: <20121215.171656.1197452765852503859.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1355558992-32285-2-git-send-email-amwang@redhat.com>
References: <1355558992-32285-1-git-send-email-amwang@redhat.com>
	<1355558992-32285-2-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] bridge: add flags to distinguish permanent
 mdb entires
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: amwang@redhat.com
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, herbert@gondor.hengli.com.au

From: Cong Wang <amwang@redhat.com>
Date: Sat, 15 Dec 2012 16:09:51 +0800

> This patch adds a flag to each mdb entry, so that we can distinguish
> permanent entries with temporary entries.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Cong Wang <amwang@redhat.com>

Applied, but you _really_ need to lock down the interface and
stop making changes to the user visible side of this _now_.

Thanks.
