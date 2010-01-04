Message-ID: <4B41FEE9.9020900@gmail.com>
Date: Mon, 04 Jan 2010 14:44:57 +0000
From: Saikiran Madugula <hummerbliss@gmail.com>
MIME-Version: 1.0
References: <8cad0aa1001040627l48c22f11id1c48c6cfaac3585@mail.gmail.com>
In-Reply-To: <8cad0aa1001040627l48c22f11id1c48c6cfaac3585@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ulog : recvfrom no space available => how do I
 calculate a good value ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

Jean-Michel Hautbois wrote:
> Hi there !
> 
> I keep trying to use the ulog/netlink system to receive only the
> packets I'm interested by and bridging everything else...
> I have a problem using this, because of a too small buffer ?
> 
> I am using the recvfrom as the example given on the website, and I am
> getting a "no space buffer available" when I have packets  about
> 2Mbits/sec...
Probably the netlink receive buffer is being overrun, try increasing the netlink
receive buffer size (see ipulog_create_handle() being called in
libipulog/ulog_test.c for example).
