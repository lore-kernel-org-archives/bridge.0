Date: Mon, 16 Apr 2007 15:02:50 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070416150250.12420151@dxpl.pdx.osdl.net>
In-Reply-To: <2eceaddb0704161410i3a4b7d5al430a4165063f0684@mail.gmail.com>
References: <2eceaddb0704161410i3a4b7d5al430a4165063f0684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging over a bonded interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ravi Ramamirtham <rrshanks@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 16 Apr 2007 17:10:37 -0400
"Ravi Ramamirtham" <rrshanks@gmail.com> wrote:

> Hi,
>   This may sound crazy but I will go ahead anyway. Here's my scenario:
> 
> ifconfig bond0 10.10.10.1 netmask 255.0.0.0
> ifenslave bond0 eth0
> ifenslave bond0 eth1
> 
> brctl addbr stp0
> brctl addif stp0 bond0
> brctl stp stp0 on
> 
> Is this a valid scenario? I am trying to bond two interfaces and run STP
> over the bonded interface..The problem I am trying to solve is to run STP
> over aggregated links between two nodes. Any suggestions/pointers would be
> much appreciated.
> 
> Thanks

The Linux code won't mind, but if you are bonding into another vendor's
switch, it is probably going to get horribly confused.
