Message-ID: <432B3C8E.1070503@mvista.com>
Date: Fri, 16 Sep 2005 14:43:42 -0700
From: Tom McNeal <tmcneal@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] stresstest.sh
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi -

When running the stress tests, after a few hours, a panic occurs
due to a kernel page fault for address 0x0 while executing one
of the brctl commands.  We don't know which one, yet.  Has anyone
run across this?

do_cpu invoked from kernel context! in	traps.c:do_cpu, line 787:
...snip...
Process brctl (pid: 23999,  stackpage=813d8000)
...snip...
note: brctl[23999] exited with preempt_count 2
Unable to handle kernel paging request at virtual address 00000000,
epc ==
801131e8, ra == 8011c5d8
Oops in fault.c:do_page_fault, line 213:
...etc....

This is basically in the 2.4.17 kernel, with some of the security
fixes.

Tom

-- 
Tom McNeal
MontaVista Software
408-992-4459

