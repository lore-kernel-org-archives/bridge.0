Message-ID: <13322060.736601234700562470.JavaMail.defaultUser@defaultHost>
Date: Sun, 15 Feb 2009 13:22:42 +0100 (CET)
From: "topper@libero.it" <topper@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Two bridge and STP
Reply-To: "topper@libero.it" <topper@libero.it>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello, my LAN today has this topology:

[router]
    |
[bridge]
   |
[switch]



[bridge] is a Linux box with 3 NIC, 2 of them are a bridge (br0) with IPtables 
for firewalling. The other nic is for management.

I want to have a standby 
backup for [bridge] in case of failure. I've read some documentation and I came 
in conclusion that the new topoligy will be:

      [router]
            |

      [switch]
      |           |
 [bridge]   [bridge2]
      |           |

      [switch]


with the two bridges STP enabled.

I think I had to:

- 
install bridge2 configured as bridge
- rsync firewall rules between the two 
bridges
- enable STP protocol on both bridges
- assign a lower STP priority to 
[bridge] to became master
-... enjoy?

Are my assumpions correct?


