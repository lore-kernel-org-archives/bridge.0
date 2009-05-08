From: Butorina Lilya <lilybox@yandex.ru>
MIME-Version: 1.0
Message-Id: <33821241768475@webmail63.yandex.ru>
Date: Fri, 08 May 2009 11:41:15 +0400
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Bridge] sigsegv from rstpd on ppc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hi,

I want to run RSTP on ppc_8xx target, kernel 2.6.19.
Is there some recommendation or restriction from RSTP implementation for this condition?

I have a problem:
I ran rstpd-daemon on ppc and it dies in one minute after start with SIGSEGV exception. Debuging shows that the reason in 
epoll_list.c file , epoll_main_loop() function, one of element(ev) of epoll_event[] array:

ev[i].data.ptr->ref_ev = &ev[i];

This code kills rstpd.

Is this known problem? Where should I find solution?

Thanks.
Liliya.
