From: "sameer" <sameer.neugui@tatainfotech.com>
Date: Thu, 11 Aug 2005 16:33:01 +0530
Message-ID: <002401c59e64$3fa3ba20$7f2c7aa3@SameerDnD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] STP with only 2 switches
Reply-To: sameer.neugui@tatainfotech.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all,

We are facing a problem with STP implementation. We have only 2 switches.
Thats the constraint, but we feel STP should work.

Background:

We have developed a layer 2 switch. This uses Cirrus logic's ep9301
processor, embedded Linux 2.4.21 kernel as the OS and zarlink's switch
controller.

The observation:

1)we have 2 switches, switch A and switch B

2)port 1 and port 2 of switch A are connected to port 1 and port 2 of switch
B

3)1 PC is connected to port 0 of switch A and another to COM port of switch
A to observe STP

4)We restart the 2 switches and observe that one of the links is blocked and
the other in forwarding state. STP is always enabled on reboot

6)We start to ping switch A and the switches and the two PC hang.

7)the LEDs on the switch device that signify the activity are seen
continuously glowing.

8)switch A and B, PC 1 and 2 cannot be accessed at all.

9) We remove one of the links and the STP reconfigures and the switch A can
be pinged.

10)Most of the time we have observed, although not a confirmed pattern, that
if we remove the blocked link, the STP just disables the port on switch A
(we have not observed the counter part on the switch B

11)Neither the switches nor the PCs were on the rest of the company network

Its not a hang exactly as upon some topology change the system is back to
working. I also checked on the internet. On cisco site I found something
called unicast flooding.

1)Is this the reason for the system to blog down?
2) How do I find which version of STP I am using? The person who has
originally implemented has quit.

what would be the fix or some pointer in this regard?

Please help.

Sam


