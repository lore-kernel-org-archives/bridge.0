Date: Mon, 24 Nov 2003 11:09:39 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20031124110939.1cb3f87c.shemminger@osdl.org>
In-Reply-To: <200311221527.UAA29684@eis.iisc.ernet.in>
References: <200311221527.UAA29684@eis.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: 2.6.0-test9 : bridge freezes
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: SVR Anand <anand@eis.iisc.ernet.in>
Cc: linux-net@vger.kernel.org, bridge@osdl.org, linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003 20:57:44 +0530 (GMT+05:30)
anand@eis.iisc.ernet.in (SVR Anand) wrote:

> Hi,
> 
> I am one of the system administrators who manage a campus network of 5000 users
> that is connected to Internet. We have placed a Linux bridge to isolate the 
> Internet from the campus. To nullify network flooding effect, we have used 
> iptables. The kernel is 2.6.0-test9, the ethernet cards that are used are 
> RTL8139.
> 
> The problem is : After 3 to 4 hours of functioning, the bridge stops working 
> and the machine becomes unusable where it doesn't respond to keyboard, and 
> there is no video display. In simple terms it freezes. Before going in for 
> 2.6.0-test9 I have tried 2.4.20 with bridge patches for iptables support. It
> worked reliably except that I cannot even login from the console because 
> I don't get the shell prompt after a while. 
> 
> Presently I have gone back to 2.4.20 for the sake of robustness. Can someone
> let me know what I can do to use 2.6.x kernel with a good amount of confidence
> so that I can keep the campus users happy ? I am making guess work as
> to whether the problem is with the network drivers, or some power management 
> issues, and so on.
> 
> Any inputs from you will be really useful. I am eager to try out any amount
> of debugging, the thing is I don't know what to look for.
> 
> 
> Anand

Linus is right, this is probably a memory leak issue.  There are several areas
that could be the problem:
	- core networking 
	- iptables
		- iptables filter
	- ethernet bridging
	- ethernet driver (rtl8169)

To find/fix the problem, we need to narrow down the scope.  
Things that would help are, what are the iptables rules you are using?
Are there any errors showing up on the ethernet devices?
Also what does the bridge forwarding table look like? are there lots of entries, are
you running spanning tree?



