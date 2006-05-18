Message-ID: <446BC951.2050803@us.checkpoint.com>
Date: Wed, 17 May 2006 18:09:37 -0700
From: Ian Schwimmer <ischwimm@us.checkpoint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] VLAN translation + PVST+
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello, I am creating a configuration where a Redhat server running 
bridge-tools 0.9.5 will be bridging between different VLANs on the same 
physical interface (for example: a bridge consisting of eth1.100 and 
eth1.110). This physical interface is being connected to modern Cisco 
switches running PVST+.

The Cisco switch does not like this configuration as the tags on its 
BPDUs are being changed but the contents of the BPDUs are left unchanged.

I need to be running PVST+ because there will be multiple Linux servers 
performing this VLAN translation/remapping (so there are going to be 
some loops that I will need blocked).

Has anyone succeeded in getting VLAN translation/remapping (bridging 
between two different VLAN tags) working with Cisco PVST+? (not simply 
disabling spanning tree). Thank you!

Ian Schwimmer
310-897-9001
ian@us.checkpoint.com
