From: Robbert Wethmar <robbert@wethmar.nl>
Date: Mon, 9 Mar 2009 23:22:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903092322.17259.robbert@wethmar.nl>
Subject: [Bridge] Linux bridge works partly
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

ls,

  i have a problem with linux bridging. Out of 4 bridges, al bridging a tap 
interface (for a virtual machine) with a pysical interface, 2 work fine, and 
2 don't. 

the ones that don't work:
- are sitecom LN-013 usb nic interfaces (1 of the working ones is another type 
of usb interface)
- can ping from tap to the bridge ip, and from bridge ip to tap
- can ping from (nic connected to) eth to the bridge ip, and from the bridge 
ip to nic connected to eth
- CANNOT ping from (nic connected to) eth to tap or vice versa.
- CAN get a ip over DHCP for a nic connected to eth, from the DHCP server on 
the tap (??)

2 other bridges on same machine, same config (except for the physical 
interface) work fine.

i've read some reports some drivers are not up to bridging. I tried swapping 
the non-working 'eth2' with the working 'eth3', which confirmed the problem 
is in the LS-013 USB interface.

- can anyone confirm the problem is in the LN-013 USB interfaces?
- is there any other way I can check wether the problem really is in the 
LN-013?

thanks for any help.

-- 
Robbert Wethmar
amsterdam
eml robbert@wethmar.nl
