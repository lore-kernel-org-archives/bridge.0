Return-Path: <bdschuym@pandora.be>
Message-ID: <4FB4A705.6040906@pandora.be>
Date: Thu, 17 May 2012 09:21:41 +0200
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <1337023817-26132-1-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1337023817-26132-1-git-send-email-devendra.aaru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge/netfilter: Fix the randconfig
	warning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, Pablo Neira Ayuso <pablo@netfilter.org>

Op 14/05/2012 21:30, Devendra Naga schreef:
> when ran with make randconfig got
>
> warning: (BRIDGE_NF_EBTABLES) selects NETFILTER_XTABLES which has unmet direct dependencies (NET&&  INET&&  NETFILTER)
>
> added NET&&  INET&&  NETFILTER dependency to the BRIDGE_NF_EBTABLES

I really don't see why ebtables should depend on INET. To me the issue 
lies in the fact that xtables depends on INET.

Bart

-- 
Bart De Schuymer
www.artinalgorithms.be

