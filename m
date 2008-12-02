From: Ivan Chernyavsky <camposer@yandex.ru>
MIME-Version: 1.0
Message-Id: <495641228242344@webmail54.yandex.ru>
Date: Tue, 02 Dec 2008 21:25:44 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Bridge] ethernet bridging and http header enrichment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Dear all,

I have following problem to solve:

1. Traffic should go thru my box transparently --- no changes
in IP or MAC addresses.

2. Part of that traffic, namely, some web traffic to particular
hosts, should be "enriched" by adding some headers to HTTP
requests. Size of original requests is guaranteed to be
small enough so that header insertion will not make them to grow
above max allowed ethernet frame size.

I know how to handle (1), and that's why I'm here. But I don't
have much ideas how to perform (2) in that context.

I was looking to write an 'ebtables' extension, but it seems
that it is impossible to alter the frame size using these (am
I wrong?). Using them together with some userland application
like Squid, from my opinion, would break my condition (1) (again,
am I so wrong??).

Could you please point me to some documentation or bring an idea
how that could be accomplished?

Thanks in advance,

-- 
   Ivan

