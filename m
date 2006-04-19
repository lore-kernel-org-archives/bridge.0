Message-ID: <20060419072239.5846.qmail@webmaild.fe1.aruba.it>
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Wed, 19 Apr 2006 09:22:39 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] packet size
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,
I have just configured a Linux box with kernel 2.6.16.7 and configured two 
ethernet interfaces (with MTU 1500) in bridge mode. CONFIG_BRIDGE_NETFILTER 
is enabled.
The problem is that ping -s 1500 192.168.0.2 doesn't work from 192.168.0.1 
if the systems are separated by the bridge. Normal ping with smaller packet 
size works ok.
What is wrong? 

Best Regards
   Fulvio Ricciardi 


