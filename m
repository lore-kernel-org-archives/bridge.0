From: Rajashekhar Mansanpally <raj@roinet.com>
Content-Type: text/plain
Message-Id: <1074003527.27920.4.camel@honeycomb>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] ebtables
Reply-To: raj@roinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Tue, 13 Jan 2004 14:18:55 -0000
To: bridge@lists.osdl.org

Hi Stephen,
Thanks for your prompt response.
What I wanted to tell was:
the following cmd DOES NOT WORK..(here 0x828 is my protocol no. that
encapsulates the IP data, like VLAN)
ebtables -A INPUT -p 0x828 -j DROP

BUT the following does work...
ebtables -A INPUT -p 0x800 -j DROP

So, ebtables is not seeing the frame before decapsulation. For that as
Bart schuymer said I need to register my function on NF_BR_PRE_ROUTING
with lower priority.
I don't want any new filter table or extension modules.
I only want the ability to do regular stuff like:
ebtables -A INPUT -p 0x828 -j DROP

So, do you think I still need to create a module.? or
get away editing some stuff..?

PS: OUTPUT and FORWARD chains work..I didn't check for
prerouting, postrouting yet.

Thanks in advance,

Raj

