MIME-Version: 1.0
Date: Tue, 2 Nov 2010 08:39:58 +0100
Message-ID: <AANLkTi=gvvotqSqr68_o6gKa3RmK_sgez99p+auCn4ig@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] STP timer active even when STP is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

I am facing some latency issues, mainly due to timer issues.
I have looked at the timer stats and I can see several timers coming
from the bridge.

In fact, I do not understand this piece of code :
In net/bridge/br_if.c in function new_bridge_dev there is an
unconditionnal call to br_stp_timer_init().

In my use case, I do not have STP enabled. Why do we have these timers
activated ? Is this a normal behaviour ?

Thanks in advance for your answer.

Best Regards,
JM
