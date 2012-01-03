Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Date: Tue,  3 Jan 2012 14:26:03 +0100
Message-Id: <1325597164-13459-1-git-send-email-richard@nod.at>
In-Reply-To: <4F025A07.2000304@nod.at>
References: <4F025A07.2000304@nod.at>
Subject: Re: [Bridge] xt_physdev has no effect if
	net.bridge.bridge-nf-call-iptables=0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org


Hi!

Here is a fix for the problem I've reported yesterday.
http://marc.info/?l=netfilter-devel&m=132555432331663&w=2

Please review the patch carefully, I'm not a br_netfilter ninja. 8-)

Thanks,
//richard

