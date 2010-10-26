Message-ID: <4CC69E41.6050205@mclink.it>
Date: Tue, 26 Oct 2010 11:24:17 +0200
From: Mauro Condarelli <mc5686@mclink.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Transparent wired/wirless bridge: is it possible?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
I read a lot on the Internet, but didn't find quite what I need.
I'm not even sure it's possible.

I have a machine with ethernet access and wireless card (in master mode).
Both are running ok under ubuntu maverick.
I also have a separate firewall (wired) acting as DHCP server for my 
whole home network.
I would like to bind the two interfaces together with no translation (no 
NAT, SNAT, masquerading, ...) so that the machines connecting to the 
wireless lan can get their address from the firewall and access the 
Internet.

Is this possible with bridging?
If so: can someone point me to the right documentation?

TiA
Mauro
