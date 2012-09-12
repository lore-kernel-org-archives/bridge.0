Return-Path: <prvs=4602ef10c1=f.cappelletti@selta.it>
Message-ID: <50504DEA.3090509@selta.it>
Date: Wed, 12 Sep 2012 10:55:06 +0200
From: Cappelletti Fabio <f.cappelletti@selta.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] RSTP Proposal Agreement sequence
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all, I'm using rstp deamon (not the last one) on my machine.
When I close ,my machine in a loop with some commercial switch and I 
open a link of the loop I see that rstpd don't manage correctly the 
handshake of BPDU with Proposal and Agreement bit.
In particular, when I received a BPDU with Proposal bit set I resend a 
new BPDU with a new Root ID (correct), but my propsal bit is not to 1! 
So the right sequence of BPDU is not right.
Someone can help me?

Br
Fabio

