Date: Tue, 13 Nov 2007 10:12:03 +0100
From: Marek Kierdelewicz <marek@piasta.pl>
Subject: Re: [Bridge] Rx Buffer sizes on e1000
Message-ID: <20071113101203.1e0235c3@catlap>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32D4A@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32D4A@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

>Hi All,

Hi,

> I have a box with 24 e1000 cards in it. They are configured as 12
>bridges, each with 2 ports.

24 ports of e1000 nics means 24 interrupts used (or shared). Maybe
thats the source of the problem. Did you notice anything unusual in your
logs concerning e1000 nics?

>...
>CPU utilisation is hovering around 50%, and load average is
>consistently
>under 0.1, so I don't beleive I'm looking at a CPU bottleneck.

Is your box is multi-core (or HT-enabled)? Is your kernel SMP? If thats
the case then check per core CPU utilisation (press "1" when watching
top). You may be hitting roof only on one of the cores while avg.
utilisation is around 50%. If you're not familiar with "smp_affinity",
then you should read the following:
http://bcr2.uwaterloo.ca/~brecht/servers/apic/SMP-affinity.txt

cheers,
Marek Kierdelewicz
KoBa ISP
