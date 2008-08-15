Date: Fri, 15 Aug 2008 11:46:45 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080815114645.5779ee91@extreme>
In-Reply-To: <BLU136-W369654C2EC452BACC340FBEF6D0@phx.gbl>
References: <BLU136-W369654C2EC452BACC340FBEF6D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Increase on context switches
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fabian Ischia <f_ischia@hotmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 15 Aug 2008 13:26:43 -0400
Fabian Ischia <f_ischia@hotmail.com> wrote:

> I've started using bridges at the office because I need to connect Virtual Machines (User-Mode-Linux). I've noticed that it causes a huge increase in context switches.
> The context switches seem to be limited somehow (I guess some kernel mechanism to prevent going wild). The context switches, even though they're cheap, also account for some 8-10% of CPU.
> I've checked with some more knowledgeable people than me and they said in a heavy loaded server I should expect something around 30K but I'm around 1M and that's with the machine just sitting idle.
> Does anyone know if there is an actual bug, and the appropriate patch to fix it; or whether it is considered OK this behavior? 
> 
> Fabian
> 
> Running vmstat I see:
> Without bridges:
>   1  0 187312  58088  32144 338636    0    0     0     0  189  997 83  1 17  0
>  1  0 187312  57948  32144 338636    0    0     0     0  140  576 25  1 74  0
>  1  0 187312  58088  32144 338636    0    0     0     0  168  777 83  1 17  0
>  1  0 187312  58016  32144 338636    0    0     0     0  154  655 26  1 73  0
>  1  0 187312  57960  32144 338636    0    0     0     0  137  500 82  1 17  0
>  1  0 187312  58088  32144 338636    0    0     0     0  154  611 25  1 74  0
>  1  0 187312  57960  32144 338636    0    0     0     0  135  525 83  1 17  0
> 
> With 4 bridges idle (no traffic on the interfaces)
>  1  0 187312  50864  32276 338632    0    0     0     0  139 134920 81  4 15  0
>  1  0 187312  51012  32276 338632    0    0     0     0  178 145827 24  3 72  0
>  1  0 187312  50880  32276 338632    0    0     0    36  180 152482 82  3 16  0
>  1  0 187312  50808  32276 338636    0    0     0     0  145 126225 25  2 72  0
>  1  0 187312  50888  32284 338628    0    0     0    56  162 136169 82  2 16  0
>  1  0 187312  50820  32284 338636    0    0     0     0  207 112448 26  3 71  0
>  1  0 187312  50740  32284 338636    0    0     0     0  148 163085 82  4 15  0
> 
> The precedent metrics are from my desktop machine, on the actual host where I have more bridges.
>  0  0      0 679748  34448 2404840    0    0     0     0   67 928669  3 10 86  0
>  0  0      0 679748  34448 2404840    0    0     0     0   89 884379  2  9 90  0
>  0  0      0 679748  34448 2404840    0    0     0     0   66 924828  2 10 88  0
>  0  0      0 679748  34456 2404840    0    0     0     4   67 906076  5  8 87  0
>  0  0      0 679748  34456 2404840    0    0     0     0   67 920194  1  9 91  0
>  0  0      0 679748  34456 2404840    0    0     0     0   89 905816  1  11 91  0
>  0  0      0 679748  34464 2404840    0    0     0     0   87 868858  3  10 91  0

Use oprofile to look at where the overhead is.
