Return-Path: <davem@davemloft.net>
Date: Thu, 13 Nov 2014 15:23:53 -0500 (EST)
Message-Id: <20141113.152353.548265176661091467.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20141113194752.GQ3815@sirena.org.uk>
References: <20141113114357.GA7857@salvia>
	<20141113.143513.785778562781935404.davem@davemloft.net>
	<20141113194752.GQ3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] arm64 allmodconfig failures in nft_reject_bridge.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: broonie@kernel.org
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stephen@networkplumber.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, kadlec@blackhole.kfki.hu, kaber@trash.net, linux@roeck-us.net

From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Nov 2014 19:47:52 +0000

> On Thu, Nov 13, 2014 at 02:35:13PM -0500, David Miller wrote:
> 
>> I hold changes in my tree for a week or more, because I want them to
>> "cook" there before they go to Linus.
> 
> Hrm.  Guess there must've been some other change in -next that pulled
> the header in implicitly here :(

-next pulls in my 'net' tree, so got the fix.
