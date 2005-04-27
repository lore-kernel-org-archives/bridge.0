Message-ID: <426F8635.2000503@uku.co.uk>
Date: Wed, 27 Apr 2005 13:31:49 +0100
From: Robert Stannard <robert.stannard@uku.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Security question
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I don't know if anybody can help me?

 I have just set up a Linux server with bridging and I have a security 
question. I tried to enable the default firewall on the system but found 
that I have to have my bridge set as a trusted device. This is obviously 
not what I want for a secure system. I have a small number of ports that 
I want open on my server, but the rest I want firewalled. However on one 
side of my bridge I have my internet connection and on the other side is 
a winXP machine that needs to be able to use all parts of the internet 
(ie all traffic needs to be forwarded through the bridge and not 
dependent on ports.)

The default firewall included with Fedora core 3 seems to affect all the 
traffic flowing across the bridge.

Is there a way the firewall can sit after the bridge and just filter 
incoming traffic from the bridge with the bridge's assigned IP address?

Sorry if this does not make a great deal of sense. I can elaborate 
further if required. I am quite new to Linux and still have a lot to learn.
Am I thinking along the right lines that I need to learn about iptables 
or would ebtables be a better route to go down?
The simplest solution that does not require too much learning would be best!

Best Regards
Robert Stannard
