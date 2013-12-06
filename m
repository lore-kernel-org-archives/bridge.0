Return-Path: <davem@davemloft.net>
Date: Fri, 06 Dec 2013 16:16:27 -0500 (EST)
Message-Id: <20131206.161627.917770459585726728.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20131206131028.41b5b8b1@nehalam.linuxnetplumber.net>
References: <1386257257-25258-1-git-send-email-jiri@resnulli.us>
	<20131206.154321.1673089712073824539.davem@davemloft.net>
	<20131206131028.41b5b8b1@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net/stable v2] br: fix use of ->rx_handler_data
 in code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: jtluka@redhat.com, jiri@resnulli.us, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 6 Dec 2013 13:10:28 -0800

> How come you ignored my simpler fix, that used the existing logic.
> I don't like introducing this especially into the stable; much prefer
> to go back to testing the flag as was being done before.

I thought Jiri's response to your suggestion was adequate, that's
all.

I can revert and take your version if you want me to, just make
a formal submission and get agreement from Jiri.

Thanks.
