Message-ID: <432EDE02.8090106@mvista.com>
Date: Mon, 19 Sep 2005 08:49:22 -0700
From: Tom McNeal <tmcneal@mvista.com>
MIME-Version: 1.0
Subject: Re: [Bridge] stresstest.sh
References: <432B3C8E.1070503@mvista.com>
	<20050916151835.3bc8e5cc@dxpl.pdx.osdl.net>
In-Reply-To: <20050916151835.3bc8e5cc@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Stephen Hemminger wrote:
> On Fri, 16 Sep 2005 14:43:42 -0700
> Tom McNeal <tmcneal@mvista.com> wrote:
> 
>>Hi -
>>
>>When running the stress tests, after a few hours, a panic occurs
>>due to a kernel page fault for address 0x0 while executing one
>>of the brctl commands.  We don't know which one, yet.  Has anyone
>>run across this?
>>
>>This is basically in the 2.4.17 kernel, with some of the security
>>fixes.
>>
>>Tom
> 
> 
> Some basics:
> 	* 2.4.17 is pretty old, can you at least try 2.4.30 or later.
>           Better yet, 2.6
> 	* Why are you doing bridge commands during the stress test?
> 	  it is pretty much a setup and forget it thing.
> 	* are you using SMP?  Locking in bridge code for 2.4 is pretty
> 	  weak and there are probably holes. I ended up reworking the whole
> 	  locking model of bridge code for 2.6 for speed and correctness.
> 

By 'bridge commands' I meant the brctl command, used by the stress
tests posted in the bridge-utils-1.0.6 test directory.  The tests
add and delete bridges while independently adding and deleting
interfaces to the supposedly existing bridge, in independent loops.
How real world is that?

I'm pretty sure it is SMP; are there fixes, like the ones you added
in 2.4.22 and 2.4.27, which are relevant?  I'm looking at trying to
patch 2.4.17 right now (I can't upgrade, but I can patch).  I do
seem some locking stuff that I'm going to look at now....

Thanks -

Tom
-- 
Tom McNeal
MontaVista Software
408-992-4459

