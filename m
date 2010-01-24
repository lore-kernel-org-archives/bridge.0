MIME-Version: 1.0
Date: Sun, 24 Jan 2010 17:18:36 +0200
Message-ID: <549992e51001240718l19528937j7e2cb166a3b2bd2c@mail.gmail.com>
From: Metuki Sabhe <sabhe.metuki@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] bridge: mac addresses question (for bluetooth pan-nap)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org

Hi,

I have a single bridge with up to 7 virtual TAP ports,
which are being added and removed dynamically.

Can I use the same MAC address for all ports and for the bridge ?
(I don't use STP as the topology is very very simple).

This is needed to allow macaddress header compression of BNEP...
(i plan to use the radio BDADDR as the MAC address for all TAP ports
and for the bridge)

thank you,
sabhe
