Date: Thu, 15 Jul 2010 20:28:53 -0700 (PDT)
Message-Id: <20100715.202853.233710023.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100715122144.0f2cf5cf@nehalam>
References: <1279219653-12791-1-git-send-email-segooon@gmail.com>
	<20100715122144.0f2cf5cf@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 7/8] net: bridge: fix sign bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: eric.dumazet@gmail.com, yoshfuji@linux-ipv6.org, segooon@gmail.com, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, herbert@gondor.hengli.com.au, netdev@vger.kernel.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Thu, 15 Jul 2010 12:21:44 -0700

> On Thu, 15 Jul 2010 22:47:33 +0400
> Kulikov Vasiliy <segooon@gmail.com> wrote:
> 
>> ipv6_skip_exthdr() can return error code that is below zero.
>> 'offset' is unsigned, so it makes no sense.
>> ipv6_skip_exthdr() returns 'int' so we can painlessly change type of
>> offset to int.
>> 
>> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
...
> Acked-by: Stephen Hemminger <shemminger@vyatta.com>

Applied.
