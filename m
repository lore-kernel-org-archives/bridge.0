Date: Fri, 16 Sep 2005 15:18:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] stresstest.sh
Message-ID: <20050916151835.3bc8e5cc@dxpl.pdx.osdl.net>
In-Reply-To: <432B3C8E.1070503@mvista.com>
References: <432B3C8E.1070503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tom McNeal <tmcneal@mvista.com>
Cc: bridge@lists.osdl.org

On Fri, 16 Sep 2005 14:43:42 -0700
Tom McNeal <tmcneal@mvista.com> wrote:

> Hi -
> 
> When running the stress tests, after a few hours, a panic occurs
> due to a kernel page fault for address 0x0 while executing one
> of the brctl commands.  We don't know which one, yet.  Has anyone
> run across this?
> 
> do_cpu invoked from kernel context! in	traps.c:do_cpu, line 787:
> ...snip...
> Process brctl (pid: 23999,  stackpage=813d8000)
> ...snip...
> note: brctl[23999] exited with preempt_count 2
> Unable to handle kernel paging request at virtual address 00000000,
> epc ==
> 801131e8, ra == 8011c5d8
> Oops in fault.c:do_page_fault, line 213:
> ...etc....
> 
> This is basically in the 2.4.17 kernel, with some of the security
> fixes.
> 
> Tom
> 

Some basics:
	* 2.4.17 is pretty old, can you at least try 2.4.30 or later.
          Better yet, 2.6
	* Why are you doing bridge commands during the stress test?
	  it is pretty much a setup and forget it thing.
	* are you using SMP?  Locking in bridge code for 2.4 is pretty
	  weak and there are probably holes. I ended up reworking the whole
	  locking model of bridge code for 2.6 for speed and correctness.
