Message-ID: <41AF55D0.406@log01.org>
Date: Thu, 02 Dec 2004 17:50:08 +0000
From: Javier Valencia <jvalencia@log01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] My eth1 is crazy
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all, i'm having an issue with my bridge. I have the following network:

ADSL router (192.168.0.1) ------ [eth0] Bridge (192.168.0.2) [eth1] 
------- Workstation (192.168.0.3)

Bridge works, but after some minutes, my eth1 card (8139too driver) goes 
link down and link up, disabling
access to the bridge IP for a while (bridge functionality for 
workstation works ok). This happens between
several minutes all the day. I've readed that some NICs have problems 
working in promisc mode.

Is my realtek sucking or what's happening?
Thanks.
