Date: Tue, 16 Oct 2007 09:40:03 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] [PATCH 2.6.23.1] Kill STP hello timer if STP is not
	enabled
Message-ID: <20071016094003.45593fa6@freepuppy.rosehill>
In-Reply-To: <20071015214812.GA789@rere.qmqm.pl>
References: <20071015214812.GA789@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: bridge@lists.linux-foundation.org

On Mon, 15 Oct 2007 23:48:12 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Quick CPU eater kill. This might be not the best fix possible.
> 
> Without this patch, hello_timer is firing 250 times/sec and eating about
> 8% CPU time on my an otherwise idle system (dynticks enabled). 2.6.21.5 was
> even worse - 20% (HZ=1000). (br->hello_time was supposedly 0 when STP was
> disabled).
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Good idea, but patch needs work.

The default hello_time is 2 seconds, so if it is going up to 250/sec then
maybe other root bridge is updating it.  

I don't see where hello_time gets set to 0 if STP disabled?
My preference would be to have hello_time set to zero if not running STP
and not start timer if it is zero.

Also, the check for not sending config BPDU is separate. We do was time
deciding to send BPDU when STP is disabled, the existing test could
just be moved up the call chain.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>

