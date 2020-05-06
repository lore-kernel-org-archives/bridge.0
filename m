Return-Path: <davem@davemloft.net>
Date: Wed, 06 May 2020 13:57:51 -0700 (PDT)
Message-Id: <20200506.135751.1936111471360870743.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200506061616.18929-1-yanaijie@huawei.com>
References: <20200506061616.18929-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: return false in
	br_mrp_enabled()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yanaijie@huawei.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kuba@kernel.org

From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 6 May 2020 14:16:16 +0800

> Fix the following coccicheck warning:
> 
> net/bridge/br_private.h:1334:8-9: WARNING: return of 0/1 in function
> 'br_mrp_enabled' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.
