Message-ID: <413CD055.7040102@wlan-international.com>
Date: Mon, 06 Sep 2004 23:02:13 +0200
From: Axel Christiansen <axel.christiansen@wlan-international.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] topology change on a bunch of mesh-cubes with multiple
	wlan interfaces
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi list,

i was searching the archiv but could not find
something matching.

In a setup with a number of mesh-cubes
(http://www.meshcube.org/) a have troble with
topology change under specific conditions.

Setup is:

The cubes are running kernel 2.4.24.
Between root and repeaters WDS is used.

root cube A
bridge br0 has interfaces:
eth0         to copper ethernet
wlan0        Managed
wlan1wds0    Repeater to cube B
wlan1wds1    Repeater to cube C

bridge cube B
bridge br0 has interfaces:
wlan0        Managed
wlan1wds0    Repeater to cube A

bridge cube C
bridge br0 has interfaces:
wlan0        Managed
wlan1wds0    Repeater to cube A

STP on
WDS auto_add off (host_ap stuff)

There are no wireless clients connected to
the network. Basicly there are 3 ethernet
links:
                                    Managed 802.11
                                              |
                                /-(2)-> bridge_cube_B
some_eth <-(1)-> root_cube_A <=
                   |            \-(3)-> bridge_cube_C
                   |                          |
              Managed 802.11        Managed 802.11

When i either turn off cube B or cube C the root
cube A gets or makes "topology change" all the time.
This takes out the interface on cube A most of the time,
making the thing completely unusable.

Today, i did a test with 4 cubes (1 root / 3 repeater)
and the oddly thing was, when taking out 1 repeater,
only one more link became unusable. So 1 link where
left operational. In the above setup all wireless
links became unusable (there are only 2, so OK).

Please let me know witch more in depth iformation
are required.

thx, Axel
