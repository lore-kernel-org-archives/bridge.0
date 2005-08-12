From: "sameer" <sameer.neugui@tatainfotech.com>
Subject: RE: [Bridge] STP with only 2 switches
Date: Fri, 12 Aug 2005 20:15:22 +0530
Message-ID: <006601c59f4c$783b72e0$7f2c7aa3@SameerDnD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050811102622.5d934330@dxpl.pdx.osdl.net>
Reply-To: sameer.neugui@tatainfotech.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Thanks for your time. Please find the info below.
- Sameer

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org]
Sent: Thursday, August 11, 2005 10:56 PM
To: sameer.neugui@tatainfotech.com
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] STP with only 2 switches


On Thu, 11 Aug 2005 16:33:01 +0530
"sameer" <sameer.neugui@tatainfotech.com> wrote:

> Hi all,
>
> We are facing a problem with STP implementation. We have only 2
> switches. Thats the constraint, but we feel STP should work.
>
> Background:
>
> We have developed a layer 2 switch. This uses Cirrus logic's ep9301
> processor, embedded Linux 2.4.21 kernel as the OS and zarlink's switch
> controller.
>
> The observation:
>
> 1)we have 2 switches, switch A and switch B
>
> 2)port 1 and port 2 of switch A are connected to port 1 and port 2 of
> switch B
>
> 3)1 PC is connected to port 0 of switch A and another to COM port of
> switch A to observe STP


	PC-A  ---0 switch A 1 ---- 1 switch B
			    2 ---- 2


> 4)We restart the 2 switches and observe that one of the links is
> blocked and the other in forwarding state. STP is always enabled on
> reboot

That is good.

> 6)We start to ping switch A and the switches and the two PC hang.

How are you setting up switch A? what are the equivalent bridge
commands and ip configuration?  Are you assigning IP to eth device
or br device?

We are setting ip to the bridge interface br1 and not to eth0.
We are not using eth0 at all. We have our own interfaces for each of the 10
switch ports including 1 management port (CPU) and 1 uplink port which is
unused.

Define hang? is network not responsive? system not responsive?
Did one of the switches produce a OOPS on console?

All the systems involved in this network become irresponsive

> 7)the LEDs on the switch device that signify the activity are seen
> continuously glowing.

You may have created a packet loop because of STP problem.
Simple test is to just unplug the port 2 connection.

We tried this. Merely unplugging the PC connection to the switch does not
get the system back to normal. either of the port cables that form the loop
should be unplugged to ensure that the system restores. But if the PC is
kept unplugged the system bogs down again.

> 8)switch A and B, PC 1 and 2 cannot be accessed at all.
>
> 9) We remove one of the links and the STP reconfigures and the switch
> A can be pinged.
>
> 10)Most of the time we have observed, although not a confirmed
> pattern, that if we remove the blocked link, the STP just disables
> the port on switch A (we have not observed the counter part on the
> switch B
>
> 11)Neither the switches nor the PCs were on the rest of the company
> network
>
> Its not a hang exactly as upon some topology change the system is
> back to working. I also checked on the internet. On cisco site I
> found something called unicast flooding.
>
> 1)Is this the reason for the system to blog down?
> 2) How do I find which version of STP I am using? The person who has
> originally implemented has quit.
>
> what would be the fix or some pointer in this regard?
>

You could start by using a newer kernel.  Using 2.6 might be impossible
but linux-2.4.21 is old. You might compare the current 2.4 net/bridge
directory with your kernel source.

Yes. We would try to do this. At the same time would like to mention that a
patch has been provided by Zarlink, the switch manufacturer to have a smooth
functioning between the linux STP module and the switch driver.

We have modified the switch driver reference code given by Zarlink. For this
code to work in conjunction with the STP module from the linux OS the patch
is provided.

