Message-ID: <4016B8E3.6050701@draigBrady.com>
Date: Tue, 27 Jan 2004 19:15:47 +0000
From: P@draigBrady.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] forwarding delay
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

I'm using linux 2.4.20 here and noticed that even
when STP is disabled for a bridge, the forwarding delay
still takes affect. Is this correct? I.E. Does the
bridge need to spend time in the "listening" and
"learning" states when STP isn't used?

It's an easy work around to set the delay to 0,
I'm just wondering whether it's a buglet or
by design.

thanks,
Pádraig.

