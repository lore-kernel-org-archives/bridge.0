Message-ID: <40CEF596.1090000@ieee.org>
Date: Tue, 15 Jun 2004 09:11:50 -0400
From: Bob Beers <bbeers@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge wlan-eth
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: bbeers@ieee.org

Hi list,

I am not subscribed to this list, but I hope someone will
know the solution to my problem ...

I have checked the archives and there was a thread:

<http://lists.osdl.org/pipermail/bridge/2004-March/000224.html>

that did not really get resolved.  I have discovered something
about this situation that I hope someone can shed more light on.

Using hostap driver in AP mode, with a netgear MA311 or
  linksys WMP11, (both PCI), with older firmware

NIC: id=0x8013 v1.0.0
PRI: id=0x15 v1.0.7
STA: id=0x1f v1.3.6

bridge eth-wlan works great, but after "upgrading" to newer
  firmware (to get essid hiding feature),

NIC: id=0x8013 v1.0.0
PRI: id=0x0015 v1.1.1
STA: id=0x001f v1.7.4

bridge no longer works, even though there is no apparent (to me)
indication of error.

Is there info somewhere that tells about what was "fixed" in
different firmware versions for prism chips, or better is there
some workaround in the bridge code that I don't yet know about
to overcome this issue?

I guess I will test all the firmware versions I can get onto
  my cards and see where it broke, but if anyone already knows
  where the problem really comes from, please let us all know.

Thanks,

-Bob
-- 
Bob Beers
MIEEE 2415966

