Date: Wed, 3 Dec 2008 11:30:42 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20081203113042.392f078d@extreme>
In-Reply-To: <495641228242344@webmail54.yandex.ru>
References: <495641228242344@webmail54.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] ethernet bridging and http header enrichment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Chernyavsky <camposer@yandex.ru>
Cc: bridge@lists.linux-foundation.org

On Tue, 02 Dec 2008 21:25:44 +0300
Ivan Chernyavsky <camposer@yandex.ru> wrote:

> Dear all,
> 
> I have following problem to solve:
> 
> 1. Traffic should go thru my box transparently --- no changes
> in IP or MAC addresses.
> 
> 2. Part of that traffic, namely, some web traffic to particular
> hosts, should be "enriched" by adding some headers to HTTP
> requests. Size of original requests is guaranteed to be
> small enough so that header insertion will not make them to grow
> above max allowed ethernet frame size.
> 
> I know how to handle (1), and that's why I'm here. But I don't
> have much ideas how to perform (2) in that context.
> 
> I was looking to write an 'ebtables' extension, but it seems
> that it is impossible to alter the frame size using these (am
> I wrong?). Using them together with some userland application
> like Squid, from my opinion, would break my condition (1) (again,
> am I so wrong??).
> 
> Could you please point me to some documentation or bring an idea
> how that could be accomplished?
> 
> Thanks in advance,
> 

Use iptables, and queue?
