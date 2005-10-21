Date: Thu, 20 Oct 2005 21:45:08 -0400
From: Ted Kaczmarek <tedkaz@optonline.net>
Message-id: <1129859108.2987.21.camel@pluto.linsolutions.com>
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
Subject: [Bridge] Some Questions
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am battling an issue with use of bridging with xen.
For some yet undetermined reason supposedly relating to stp, they assign
a mac address of fe:ff:ff:ff:ff:ff  to the bridge.

Was hoping someone here may be able to elaborate on that.


If I enslave a bridge to an ethernet, and than restart that network
interface, should the bridge operation behave the same after the ip
interface is restarted?


Is their any arp functionality in the bridge itself?
Am thinking like arp snooping, or anything else for that matter.

In general I have been seeing a lot of odd behavior with the xen bridge
in their unstable code base. Am hoping for some insight.


Regards,
Ted

