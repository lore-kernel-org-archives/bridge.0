Return-Path: <davem@davemloft.net>
Date: Thu, 17 May 2012 15:50:22 -0400 (EDT)
Message-Id: <20120517.155022.919927868768770215.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1337270425-21873-1-git-send-email-eldad@fogrefinery.com>
References: <1337270425-21873-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] ipv6: correct the ipv6 option name - Pad0 to
	Pad1
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: eldad@fogrefinery.com
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, hadi@cyberus.ca, jmorris@namei.org, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, shemminger@vyatta.com

From: Eldad Zack <eldad@fogrefinery.com>
Date: Thu, 17 May 2012 18:00:25 +0200

> The padding destination or hop-by-hop option is called Pad1 and not Pad0.
> 
> See RFC2460 (4.2) or the IANA ipv6-parameters registry:
> http://www.iana.org/assignments/ipv6-parameters/ipv6-parameters.xml
> 
> Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

Applied to net-next.
