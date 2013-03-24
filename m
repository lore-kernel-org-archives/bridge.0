Return-Path: <davem@davemloft.net>
Date: Sun, 24 Mar 2013 17:18:07 -0400 (EDT)
Message-Id: <20130324.171807.1183155678794281928.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1364131607-11698-1-git-send-email-honkiko@gmail.com>
References: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
	<1364131607-11698-1-git-send-email-honkiko@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: avoid br_ifinfo_notify when
 nothing changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: honkiko@gmail.com
Cc: sergei.shtylyov@cogentembedded.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, zhiguo.hong@emc.com, stephen@networkplumber.org, herbert@gondor.hengli.com.au

From: Hong Zhiguo <honkiko@gmail.com>
Date: Sun, 24 Mar 2013 21:26:47 +0800

> When neither IFF_BRIDGE nor IFF_BRIDGE_PORT is set,
> and afspec == NULL but  protinfo != NULL, we run into
> "if (err == 0) br_ifinfo_notify(RTM_NEWLINK, p);" with
> random value in ret.
> 
> Thanks to Sergei for pointing out the error in commit comments.
> 
> Signed-off-by: Hong Zhiguo <honkiko@gmail.com>

Applied.
