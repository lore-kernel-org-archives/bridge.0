From: "Paul P. Pongco" <paulp@mozcom.com>
Content-Type: text/plain
Message-Id: <1076657825.735.72.camel@amidala.mozcom.com>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 15:37:05 +0800
Content-Transfer-Encoding: 7bit
Subject: [Bridge] maximum throughput for linux bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

Apologies if I am not suscribed to this list.

I have setup a linux bridge using 3c905C-TX/TX-M [Tornado] cards. Im
running it on RH 7.3 2.4.19 kernel.
Lately, I have seen the following errors on the bridge

Feb 10 07:40:24 safe kernel: eth2: Too much work in interrupt, status e401.
Feb 10 07:40:52 safe last message repeated 3 times
Feb 10 08:12:16 safe kernel: br0: received tcn bpdu on port 1(eth2)
Feb 10 08:12:16 safe kernel: br0: topology change detected, sending tcn bpdu
Feb 10 08:13:09 safe kernel: br0: received tcn bpdu on port 1(eth2)
Feb 10 08:13:09 safe kernel: br0: topology change detected, sending tcn bpdu

Im currently pushing around 45Mbs/20Mbs (down/up)  of traffic on the
bridge (doing some bandwidth management) and Im concerned about its
performance and how it would scale.
Thanks in advance for your advice. 

-- 
Cheers,

Paul P. Pongco
Mosaic Communications Inc.



