Date: Fri, 22 Jul 2005 11:51:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050722115136.5c116977@dxpl.pdx.osdl.net>
In-Reply-To: <42DFB70E.7000200@inrets.fr>
References: <42DFB70E.7000200@inrets.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [Bridge-utils] some feedback with kernel 2.6.12 FC4
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Christophe GRANSART <christophe.gransart@inrets.fr>
Cc: bridge@osdl.org, Christophe GRANSART <christophe.gransart@inrets.fr>

On Thu, 21 Jul 2005 16:54:06 +0200
Christophe GRANSART <christophe.gransart@inrets.fr> wrote:

> Hello,
> 
> Some feedback about bridge-utils on FC4 :
> 
> i tried bridge-utils 1.0.4 and 1.0.6 on FC4 2.6.12-1.1398_FC4
> On a dell D800
> With eth0 : Broadcom NetXtreme BCM5705M Gigabit Ethernet
> and ath0 : DLink DWL-AG650 driver madwifi
> 
> On both 1.0.4 and 1.0.6, my system freezes after 30 - 60 sec after
> the bridge is up (even with promisc mode on both ath0 and eth0).
> 
> When eth0 and ath0 are up, they are both on irq 11.
> Is this a parameter to change?
> 
> Regards,
> Christophe

It is almost certainly not a utilities issue.  The command does almost
nothing but setup the bridge.  Most times when whole system freezes, it
is a panic. If you are running X windows the kernel is unable to display
output, so you either need to add a serial console (and another system
to capture the output) or the virtual terminal 0 console to avoid X
running (ALT-F1). 


